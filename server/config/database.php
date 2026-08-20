<?php
return [
    'default' => 'mysql',
    'connections' => [
        'mysql' => [
            'type' => 'mysql',
            'hostname' => '127.0.0.1',
            'database' => 'zlk666',
            'username' => 'zlk666',
            'password' => 'zlk666',
            'hostport' => '3306',
            'charset' => 'utf8mb4',
            'prefix' => '',
            'debug' => true,
            'deploy' => 0,
            'rw_separate' => false,
            'master_num' => 1,
            'slave_no' => '',
            'fields_strict' => true,
            'break_reconnect' => false,
            'trigger_sql' => true,
            'fields_cache' => false,
        ],
    ],
];
