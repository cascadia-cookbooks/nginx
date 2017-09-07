#
# Cookbook Name:: cop_nginx
# Recipe:: install
# Author:: Copious Inc. <engineering@copiousinc.com>
#

package 'nginx' do
    action :upgrade
end

if node['nginx']['packages']
    package node['nginx']['packages'] do
        action :upgrade
    end
end
