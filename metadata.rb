name 'cop_nginx'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures the NGINX web server.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 12.5'
version '0.1.0'

source_url 'https://github.com/copious-cookbooks/nginx'
issues_url 'https://github.com/copious-cookbooks/nginx/issues'

supports 'ubuntu', '= 16.04'
supports 'ubuntu', '= 14.04'

depends 'apt'
