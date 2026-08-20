<?php
declare(strict_types=1);

namespace app\admin\controller;

use think\Response;
use app\common\model\SysAdmin;
use app\common\model\SysAuditLog;

class AdminController extends BaseController
{
    /**
     * 管理员列表
     */
    public function list(): Response
    {
        $page = $this->request->get('page', 1);
        $limit = $this->request->get('limit', 20);
        $keyword = $this->request->get('keyword', '');
        
        $query = SysAdmin::where('site_id', $this->getSiteId());
        
        if ($keyword) {
            $query->where(function($q) use ($keyword) {
                $q->where('username', 'like', "%{$keyword}%")
                  ->whereOr('real_name', 'like', "%{$keyword}%")
                  ->whereOr('phone', 'like', "%{$keyword}%");
            });
        }
        
        $total = $query->count();
        $list = $query->with(['role', 'site'])
            ->page($page, $limit)
            ->order('id', 'desc')
            ->select()
            ->toArray();
        
        return $this->success([
            'list' => $list,
            'total' => $total,
            'page' => $page,
            'limit' => $limit,
        ]);
    }
    
    /**
     * 管理员详情
     */
    public function detail(): Response
    {
        $id = $this->request->get('id', 0);
        $admin = SysAdmin::where('id', $id)
            ->where('site_id', $this->getSiteId())
            ->with(['role', 'site'])
            ->find();
        
        if (!$admin) {
            return $this->error('管理员不存在');
        }
        
        return $this->success($admin->toArray());
    }
    
    /**
     * 保存管理员
     */
    public function save(): Response
    {
        $id = $this->request->post('id', 0);
        $data = $this->request->post();
        
        // 验证数据
        $validate = validate([
            'username' => 'require|alphaDash|length:3,20',
            'password' => 'length:6,20',
            'real_name' => 'require|chsDash|length:2,20',
            'phone' => 'mobile',
            'role_id' => 'require|number',
        ]);
        
        if (!$validate->check($data)) {
            return $this->error($validate->getError());
        }
        
        if ($id) {
            // 编辑
            $admin = SysAdmin::where('id', $id)
                ->where('site_id', $this->getSiteId())
                ->find();
            
            if (!$admin) {
                return $this->error('管理员不存在');
            }
            
            $beforeValue = $admin->toArray();
            
            // 检查用户名是否重复
            if (isset($data['username']) && $data['username'] != $admin->username) {
                $exists = SysAdmin::where('username', $data['username'])
                    ->where('id', '<>', $id)
                    ->find();
                if ($exists) {
                    return $this->error('用户名已存在');
                }
            }
            
            // 更新数据
            $updateData = [
                'real_name' => $data['real_name'] ?? $admin->real_name,
                'phone' => $data['phone'] ?? $admin->phone,
                'email' => $data['email'] ?? $admin->email,
                'role_id' => $data['role_id'] ?? $admin->role_id,
                'status' => $data['status'] ?? $admin->status,
            ];
            
            if (!empty($data['password'])) {
                $updateData['password'] = SysAdmin::hashPassword($data['password']);
            }
            
            $admin->save($updateData);
            
            // 记录审计日志
            SysAuditLog::log(
                $this->getAdminId(),
                'admin',
                'edit',
                'sys_admin',
                $id,
                $beforeValue,
                $admin->toArray(),
                $this->request->ip()
            );
            
            return $this->success([], '编辑成功');
            
        } else {
            // 新增
            if (empty($data['password'])) {
                return $this->error('密码不能为空');
            }
            
            // 检查用户名是否重复
            $exists = SysAdmin::where('username', $data['username'])->find();
            if ($exists) {
                return $this->error('用户名已存在');
            }
            
            $admin = SysAdmin::create([
                'username' => $data['username'],
                'password' => SysAdmin::hashPassword($data['password']),
                'real_name' => $data['real_name'],
                'phone' => $data['phone'] ?? '',
                'email' => $data['email'] ?? '',
                'role_id' => $data['role_id'],
                'site_id' => $this->getSiteId(),
                'status' => 1,
            ]);
            
            // 记录审计日志
            SysAuditLog::log(
                $this->getAdminId(),
                'admin',
                'add',
                'sys_admin',
                $admin->id,
                [],
                $admin->toArray(),
                $this->request->ip()
            );
            
            return $this->success(['id' => $admin->id], '添加成功');
        }
    }
    
    /**
     * 删除管理员
     */
    public function delete(): Response
    {
        $id = $this->request->post('id', 0);
        
        if ($id == $this->getAdminId()) {
            return $this->error('不能删除自己');
        }
        
        $admin = SysAdmin::where('id', $id)
            ->where('site_id', $this->getSiteId())
            ->find();
        
        if (!$admin) {
            return $this->error('管理员不存在');
        }
        
        if ($admin->is_super == 1) {
            return $this->error('不能删除超级管理员');
        }
        
        $beforeValue = $admin->toArray();
        $admin->delete();
        
        // 记录审计日志
        SysAuditLog::log(
            $this->getAdminId(),
            'admin',
            'delete',
            'sys_admin',
            $id,
            $beforeValue,
            [],
            $this->request->ip()
        );
        
        return $this->success([], '删除成功');
    }
    
    /**
     * 重置密码
     */
    public function resetPassword(): Response
    {
        $id = $this->request->post('id', 0);
        $newPassword = $this->request->post('new_password', '123456');
        
        $admin = SysAdmin::where('id', $id)
            ->where('site_id', $this->getSiteId())
            ->find();
        
        if (!$admin) {
            return $this->error('管理员不存在');
        }
        
        $beforeValue = ['password' => '******'];
        $admin->password = SysAdmin::hashPassword($newPassword);
        $admin->save();
        
        // 记录审计日志
        SysAuditLog::log(
            $this->getAdminId(),
            'admin',
            'reset_password',
            'sys_admin',
            $id,
            $beforeValue,
            ['password' => '******'],
            $this->request->ip()
        );
        
        return $this->success([], '密码重置成功');
    }
}
