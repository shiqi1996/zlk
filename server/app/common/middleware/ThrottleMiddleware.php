<?php
declare(strict_types=1);

namespace app\common\middleware;

use think\Request;
use think\Response;
use think\facade\Cache;

class ThrottleMiddleware
{
    public function handle(Request $request, \Closure $next): Response
    {
        $adminId = $request->adminId ?? 0;
        if (!$adminId) {
            return $next($request);
        }
        
        $key = 'throttle:admin:' . $adminId;
        $limit = 60; // 每分钟60次
        $ttl = 60;
        
        $current = Cache::get($key) ?? 0;
        
        if ($current >= $limit) {
            return json(['code' => 429, 'msg' => '请求过于频繁，请稍后再试'], 429);
        }
        
        Cache::set($key, $current + 1, $ttl);
        
        return $next($request);
    }
}
