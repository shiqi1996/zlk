<?php
use think\facade\Route;

// 登录接口（无需认证）
Route::post('api/admin/auth/login', 'admin/auth/login');

// 需要认证的路由组
Route::group('api/admin', function () {
    
    // 认证相关
    Route::post('auth/logout', 'admin/auth/logout');
    Route::get('auth/info', 'admin/auth/info');
    
    // 分站管理
    Route::get('site/list', 'admin/site/list');
    Route::get('site/detail', 'admin/site/detail');
    Route::post('site/save', 'admin/site/save');
    Route::post('site/delete', 'admin/site/delete');
    
    // 管理员管理
    Route::get('admin/list', 'admin/admin/list');
    Route::get('admin/detail', 'admin/admin/detail');
    Route::post('admin/save', 'admin/admin/save');
    Route::post('admin/delete', 'admin/admin/delete');
    Route::post('admin/resetPassword', 'admin/admin/resetPassword');
    
    // 角色权限管理
    Route::get('role/list', 'admin/role/list');
    Route::get('role/detail', 'admin/role/detail');
    Route::post('role/save', 'admin/role/save');
    Route::post('role/delete', 'admin/role/delete');
    Route::get('permission/list', 'admin/permission/list');
    
    // 会员管理
    Route::get('member/list', 'admin/member/list');
    Route::get('member/detail', 'admin/member/detail');
    Route::post('member/edit', 'admin/member/edit');
    Route::post('member/status', 'admin/member/status');
    
    // 验资管理
    Route::get('verify/list', 'admin/verify/list');
    Route::get('verify/detail', 'admin/verify/detail');
    Route::post('verify/audit', 'admin/verify/audit');
    
    // 模特资料管理
    Route::get('profile/list', 'admin/profile/list');
    Route::get('profile/detail', 'admin/profile/detail');
    Route::post('profile/audit', 'admin/profile/audit');
    
    // 操作日志
    Route::get('log/operation', 'admin/log/operation');
    Route::get('log/audit', 'admin/log/audit');
    
})->middleware([
    \app\common\middleware\SiteMiddleware::class,
    \app\common\middleware\ThrottleMiddleware::class,
    \app\common\middleware\AuthMiddleware::class,
    \app\common\middleware\PermissionMiddleware::class,
    \app\common\middleware\OperationLogMiddleware::class,
]);

// 异常处理
Route::miss(function() {
    return json(['code' => 404, 'msg' => '接口不存在'], 404);
});
