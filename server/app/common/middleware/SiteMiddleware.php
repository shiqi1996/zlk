<?php
declare(strict_types=1);

namespace app\common\middleware;

use think\Request;
use think\Response;
use app\common\model\SysSite;

class SiteMiddleware
{
    public function handle(Request $request, \Closure $next): Response
    {
        $host = $request->host();
        
        // 根据域名识别分站
        $site = SysSite::where('domain', $host)
            ->where('status', 1)
            ->find();
        
        if (!$site) {
            // 尝试泛域名匹配
            $site = SysSite::where('wildcard_domain', 'like', '%' . $this->getWildcardPattern($host) . '%')
                ->where('status', 1)
                ->find();
        }
        
        if (!$site) {
            // 默认主站
            $site = SysSite::find(1);
        }
        
        if (!$site) {
            return json(['code' => 404, 'msg' => '站点不存在'], 404);
        }
        
        // 注入 site_id 到请求
        $request->siteId = $site->id;
        $request->siteInfo = $site;
        
        return $next($request);
    }
    
    private function getWildcardPattern(string $host): string
    {
        $parts = explode('.', $host);
        if (count($parts) >= 2) {
            return '*.' . implode('.', array_slice($parts, -2));
        }
        return $host;
    }
}
