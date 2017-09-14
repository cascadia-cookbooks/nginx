# master config options
default['nginx'] = {
    'block_dir'           => '/etc/nginx/block.d',
    'client_max_body_size'=> '1M',
    'gzip'                => 'on',
    'gzip_buffers'        => '16 8k',
    'gzip_comp_level'     => 6,
    'gzip_min_length'     => 1100,
    'gzip_proxied'        => 'any',
    'gzip_types'          => %w{
        application/javascript
        application/json
        application/x-javascript
        application/xml
        application/xml+rss
        image/svg+xml
        text/css
        text/javascript
        text/js
        text/plain
        text/xml
    },
    'gzip_vary'           => 'on',
    'keepalive_timeout'   => 30,
    'master_configs'      => {
        'charset' => 'utf-8'
    },
    'multi_accept'        => 'on',
    'proxy_read_timeout'  => 60,
    'remove_default_site' => false,
    'sendfile'            => 'on',
    'server_tokens'       => 'off',
    'tcp_nodelay'         => 'on',
    'tcp_nopush'          => 'on',
    'user'                => 'nginx',
    'vhost_dir'           => '/etc/nginx/conf.d',
    'worker_connections'  => 1024,
    'worker_processes'    => 2,
    'ssl' => {
        'ciphers' => %w{
            HIGH
            !aNULL
            !eNULL
            !EXPORT
            !DES
            !MD5
            !PSK
            !RC4
            !3DES
        }
    }
}

case node['platform_family']
when 'debian'
when 'rhel'
end
