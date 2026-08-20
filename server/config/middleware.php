<?php
return [
    'alias' => [
        'site' => app\common\middleware\SiteMiddleware::class,
        'auth' => app\common\middleware\AuthMiddleware::class,
        'permission' => app\common\middleware\PermissionMiddleware::class,
        'throttle' => app\common\middleware\ThrottleMiddleware::class,
        'operation_log' => app\common\middleware\OperationLogMiddleware::class,
    ],
    'priority' => [
        app\common\middleware\SiteMiddleware::class,
        app\common\middleware\ThrottleMiddleware::class,
        app\common\middleware\AuthMiddleware::class,
        app\common\middleware\PermissionMiddleware::class,
        app\common\middleware\OperationLogMiddleware::class,
    ],
];
