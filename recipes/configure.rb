#
# Cookbook Name:: cop_nginx
# Recipe:: configure
# Author:: Copious Inc. <engineering@copiousinc.com>
#

file "#{node['nginx']['vhost_dir']}/default.conf" do
    backup   false
    action   :delete
    notifies :restart, 'service[nginx]', :delayed
    only_if  { node['nginx']['remove_default_site'] }
end

template 'installing compression config' do
    path     '/etc/nginx/compression'
    source   'nginx/compression.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   5
    action   :create
    notifies :restart, 'service[nginx]', :delayed
end

template 'installing master nginx config' do
    path     '/etc/nginx/nginx.conf'
    source   'nginx/nginx.conf.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   5
    action   :create
    notifies :restart, 'service[nginx]', :delayed
end

service 'nginx' do
    action :enable
    notifies :start, 'service[nginx]', :delayed
end
