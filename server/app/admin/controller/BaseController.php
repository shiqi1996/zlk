<?php
declare(strict_types=1);

namespace app\admin\controller;

use think\App;
use think\Request;
use think\Response;

abstract class BaseController
{
    protected App $app;
    protected Request $request;
    
    public function __construct(App $app)
    {
        $this->app = $app;
        $this->request = $this->app->request;
    }
    
    /**
     * 成功响应
     */
    protected function success($data = [], string $msg = 'success'): Response
    {
        return json([
            'code' => 0,
            'msg' => $msg,
            'data' => $data,
            'time' => time(),
        ]);
    }
    
    /**
     * 失败响应
     */
    protected function error(string $msg = 'error', int $code = 1, $data = []): Response
    {
        return json([
            'code' => $code,
            'msg' => $msg,
            'data' => $data,
            'time' => time(),
        ]);
    }
    
    /**
     * 获取当前管理员ID
     */
    protected function getAdminId(): int
    {
        return $this->request->adminId ?? 0;
    }
    
    /**
     * 获取当前站点ID
     */
    protected function getSiteId(): int
    {
        return $this->request->siteId ?? 1;
    }
    
    /**
     * 获取当前管理员信息
     */
    protected function getAdminInfo()
    {
        return $this->request->adminInfo ?? null;
    }
}
