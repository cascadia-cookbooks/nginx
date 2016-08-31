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
}

# latest stable package release
case lsb[:release]
when '14.04'
    default['nginx']['version'] = '1.4.6-1ubuntu3.5'
when '16.04'
    default['nginx']['version'] = '1.10.0-0ubuntu0.16.04.2'
end
