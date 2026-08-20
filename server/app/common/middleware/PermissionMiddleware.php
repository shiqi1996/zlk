<?php
declare(strict_types=1);

namespace app\common\middleware;

use think\Request;
use think\Response;
use app\common\model\SysRolePermission;

class PermissionMiddleware
{
    public function handle(Request $request, \Closure $next): Response
    {
        $admin = $request->adminInfo;
        
        // 超级管理员跳过权限检查
        if ($admin->is_super == 1) {
            return $next($request);
        }
        
        // 获取当前路由需要的权限
        $route = $request->rule()->getName();
        $permissionCode = $this->getPermissionCode($route);
        
        if (!$permissionCode) {
            return $next($request);
        }
        
        // 检查角色权限
        $hasPermission = SysRolePermission::where('role_id', $admin->role_id)
            ->where('permission_code', $permissionCode)
            ->find();
        
        if (!$hasPermission) {
            return json(['code' => 403, 'msg' => '无权限访问'], 403);
        }
        
        return $next($request);
    }
    
    private function getPermissionCode(string $route): ?string
    {
        // 路由到权限码映射
        $map = [
            'admin/site/list' => 'site:view',
            'admin/site/save' => 'site:edit',
            'admin/admin/list' => 'admin:view',
            'admin/admin/save' => 'admin:edit',
            'admin/member/list' => 'member:view',
            'admin/member/edit' => 'member:edit',
            'admin/verify/list' => 'verify:view',
            'admin/verify/audit' => 'verify:audit',
            'admin/profile/list' => 'profile:view',
            'admin/profile/audit' => 'profile:audit',
        ];
        
        return $map[$route] ?? null;
    }
}
