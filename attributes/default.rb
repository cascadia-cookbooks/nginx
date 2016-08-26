# remove the default.conf webpage
default['nginx']['remove_default_site'] = 'true'

# latest stable release
default['nginx']['install_method'] = 'package'
default['nginx']['version']        = '1.10.0'

# master config options
default['nginx']['user']               = 'www-data'
default['nginx']['worker_processes']   = 2
default['nginx']['multi_accept']       = 'on'
default['nginx']['worker_connections'] = 1024
default['nginx']['server_tokens']      = 'off'
default['nginx']['sendfile']           = 'on'
default['nginx']['tcp_nopush']         = 'on'
default['nginx']['tcp_nodelay']        = 'on'
default['nginx']['keepalive_timeout']  = 30
