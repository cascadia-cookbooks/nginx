#
# Cookbook Name:: cop_nginx
# Recipe:: common
# Author:: Copious Inc. <engineering@copiousinc.com>
#
# The MIT License (MIT)
#
# Copyright (c) 2016 Copious Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

file '/etc/nginx/sites-available/default' do
    backup   false
    action   :delete
    notifies :restart, 'service[nginx]', :delayed
    only_if  node['nginx']['remove_default_site']
end

template 'installing master nginx config' do
    path     '/etc/nginx/nginx.conf'
    source   'nginx/nginx.conf.erb'
    group    'root'
    owner    'root'
    mode     0644
    backup   false
    action   :create
    notifies :restart, 'service[nginx]', :delayed
end

service 'nginx' do
    action [:enable, :start]
end
