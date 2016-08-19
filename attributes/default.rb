# remove the default.conf webpage
default['nginx']['default_site_enabled'] = false

# latest stable release
default['nginx']['install_method']     = 'package'
default['nginx']['version']            = '1.10.1'
