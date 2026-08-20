<?php
return [
    'default' => 'redis',
    'stores' => [
        'redis' => [
            'type' => 'redis',
            'host' => '127.0.0.1',
            'port' => 6379,
            'password' => '',
            'select' => 0,
            'timeout' => 0,
            'expire' => 0,
            'persistent' => false,
            'prefix' => 'zlk:',
        ],
        'file' => [
            'type' => 'File',
            'path' => '',
            'prefix' => '',
            'expire' => 0,
        ],
    ],
];
