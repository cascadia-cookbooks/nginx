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
    'vhost_dir'           => '/etc/nginx/conf.d'
}

case node['platform_family']
when 'debian'
when 'rhel'
end
