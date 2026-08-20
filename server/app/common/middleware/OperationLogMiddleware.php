<?php
declare(strict_types=1);

namespace app\common\middleware;

use think\Request;
use think\Response;
use app\common\model\SysOperationLog;

class OperationLogMiddleware
{
    public function handle(Request $request, \Closure $next): Response
    {
        $response = $next($request);
        
        // 只记录写操作
        if (in_array($request->method(), ['POST', 'PUT', 'DELETE'])) {
            $adminId = $request->adminId ?? 0;
            if ($adminId) {
                try {
                    SysOperationLog::create([
                        'admin_id' => $adminId,
                        'admin_name' => $request->adminInfo->real_name ?? '',
                        'module' => $request->controller(),
                        'action' => $request->action(),
                        'method' => $request->method(),
                        'url' => $request->url(),
                        'params' => json_encode($request->param()),
                        'ip' => $request->ip(),
                        'user_agent' => $request->header('user-agent', ''),
                        'site_id' => $request->siteId ?? 1,
                    ]);
                } catch (\Exception $e) {
                    // 日志记录失败不影响业务
                }
            }
        }
        
        return $response;
    }
}
