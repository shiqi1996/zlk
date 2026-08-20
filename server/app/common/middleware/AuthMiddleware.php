<?php
declare(strict_types=1);

namespace app\common\middleware;

use think\Request;
use think\Response;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use app\common\model\SysAdmin;

class AuthMiddleware
{
    public function handle(Request $request, \Closure $next): Response
    {
        $token = $request->header('Authorization');
        
        if (!$token) {
            return json(['code' => 401, 'msg' => '未登录'], 401);
        }
        
        try {
            $key = config('app.jwt_secret') ?: 'zlk_admin_secret_key_2026';
            $decoded = JWT::decode($token, new Key($key, 'HS256'));
            
            $adminId = $decoded->admin_id ?? 0;
            $admin = SysAdmin::find($adminId);
            
            if (!$admin || $admin->status != 1) {
                return json(['code' => 401, 'msg' => '账号不存在或已禁用'], 401);
            }
            
            // 检查登录失败锁定
            if ($admin->login_fail_count >= 5) {
                $lockTime = strtotime($admin->lock_time);
                if ($lockTime > time()) {
                    return json(['code' => 401, 'msg' => '账号已锁定，请30分钟后重试'], 401);
                }
            }
            
            // 注入管理员信息
            $request->adminId = $admin->id;
            $request->adminInfo = $admin;
            $request->siteId = $admin->site_id;
            
        } catch (\Exception $e) {
            return json(['code' => 401, 'msg' => 'Token无效或已过期'], 401);
        }
        
        return $next($request);
    }
}
