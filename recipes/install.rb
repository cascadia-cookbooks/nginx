#
# Cookbook Name:: cop_nginx
# Recipe:: install
# Author:: Copious Inc. <engineering@copiousinc.com>
#

package 'nginx' do
    action :upgrade
end
