name 'cop_nginx'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs/Configures NGINX Web Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 12.5'
version '0.0.2'
source_url 'https://github.com/copious-cookbooks/nginx'
issues_url 'https://github.com/copious-cookbooks/nginx/issues'

supports 'ubuntu', '>= 14.04'

depends 'apt'
