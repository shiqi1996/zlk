<?php
declare(strict_types=1);

namespace app\admin\controller;

use think\Response;
use Firebase\JWT\JWT;
use app\common\model\SysAdmin;

class AuthController extends BaseController
{
    /**
     * 管理员登录
     */
    public function login(): Response
    {
        $username = $this->request->post('username', '');
        $password = $this->request->post('password', '');
        
        if (empty($username) || empty($password)) {
            return $this->error('用户名和密码不能为空');
        }
        
        // 查找管理员
        $admin = SysAdmin::where('username', $username)
            ->where('status', 1)
            ->find();
        
        if (!$admin) {
            return $this->error('用户名或密码错误');
        }
        
        // 检查是否被锁定
        if ($admin->login_fail_count >= 5) {
            $lockTime = strtotime($admin->lock_time);
            if ($lockTime > time()) {
                $remainMinutes = ceil(($lockTime - time()) / 60);
                return $this->error("账号已锁定，请{$remainMinutes}分钟后重试");
            }
        }
        
        // 验证密码
        if (!$admin->verifyPassword($password)) {
            $admin->recordLoginFail();
            $remainAttempts = 5 - $admin->login_fail_count;
            if ($remainAttempts > 0) {
                return $this->error("密码错误，还可尝试{$remainAttempts}次");
            } else {
                return $this->error('密码错误次数过多，账号已锁定30分钟');
            }
        }
        
        // 生成JWT Token
        $key = config('app.jwt_secret') ?: 'zlk_admin_secret_key_2026';
        $payload = [
            'iss' => 'zlk-admin',
            'iat' => time(),
            'exp' => time() + 86400, // 24小时过期
            'admin_id' => $admin->id,
            'username' => $admin->username,
        ];
        
        $token = JWT::encode($payload, $key, 'HS256');
        
        // 记录登录成功
        $admin->recordLoginSuccess($this->request->ip());
        
        // 返回管理员信息和Token
        $adminInfo = $admin->hidden(['password'])->toArray();
        $adminInfo['token'] = $token;
        
        return $this->success($adminInfo, '登录成功');
    }
    
    /**
     * 退出登录
     */
    public function logout(): Response
    {
        // JWT是无状态的，客户端删除token即可
        return $this->success([], '退出成功');
    }
    
    /**
     * 获取当前管理员信息
     */
    public function info(): Response
    {
        $admin = $this->getAdminInfo();
        if (!$admin) {
            return $this->error('未登录', 401);
        }
        
        $adminInfo = $admin->hidden(['password'])->toArray();
        $adminInfo['permissions'] = $admin->getPermissions();
        
        return $this->success($adminInfo);
    }
}
