name 'cop_nginx'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures the NGINX web server.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.9.1'

source_url 'https://github.com/copious-cookbooks/nginx'
issues_url 'https://github.com/copious-cookbooks/nginx/issues'

supports 'ubuntu', '>= 14.04'
supports 'debian', '>= 6.0'
supports 'redhat', '>= 6.0'
supports 'centos', '>= 6.0'

depends 'cop_tls'
