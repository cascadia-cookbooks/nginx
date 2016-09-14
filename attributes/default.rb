# master config options
default['nginx'] = {
    'remove_default_site' => 'true',
    'install_method'      => 'package',
    'user'                => 'www-data',
    'worker_processes'    => 2,
    'multi_accept'        => 'on',
    'worker_connections'  => 1024,
    'server_tokens'       => 'off',
    'sendfile'            => 'on',
    'tcp_nopush'          => 'on',
    'tcp_nodelay'         => 'on',
    'keepalive_timeout'   => 30,
    'vhost_dir'           => [
        '/etc/nginx/sites-enabled/',
        '/etc/nginx/sites-available/'
    ]
}

# latest stable package release
case node['platform_version']
when '14.04'
    default['nginx']['version'] = '1.4.6-1ubuntu3.5'
when '16.04'
    default['nginx']['version'] = '1.10.0-0ubuntu0.16.04.2'
when /7.2./
    default['nginx']['user']      = 'nginx'
    default['nginx']['vhost_dir'] = [ '/etc/nginx/conf.d/' ]
    default['nginx']['version']   = '1.10.1-1.el7'
end
