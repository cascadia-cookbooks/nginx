# master config options
default['nginx'] = {
    'remove_default_site' => false,
    'user'                => 'nginx',
    'worker_processes'    => 2,
    'multi_accept'        => 'on',
    'worker_connections'  => 1024,
    'server_tokens'       => 'off',
    'sendfile'            => 'on',
    'tcp_nopush'          => 'on',
    'tcp_nodelay'         => 'on',
    'keepalive_timeout'   => 30,
    'vhost_dir'           => '/etc/nginx/conf.d',
    'block_dir'           => '/etc/nginx/block.d',
    'gzip'                => 'on',
    'gzip_vary'           => 'on',
    'gzip_proxied'        => 'any',
    'gzip_comp_level'     => 6,
    'gzip_min_length'     => 1100,
    'gzip_buffers'        => '16 8k',
    'gzip_types'          => %w{
        text/plain
        text/css
        text/js
        text/xml
        text/javascript
        application/javascript
        application/x-javascript
        application/json
        application/xml
        application/xml+rss
        image/svg+xml
    }
}

case node['platform_family']
when 'debian'
when 'rhel'
end
