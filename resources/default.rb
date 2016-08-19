#
# Cookbook Name:: cop_wordpress
# Resource:: default
# Author:: David Nuñez (<davidn@copiousinc.com>)
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
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

resource_name :wordpress
provides :wordpress

property :path,                 kind_of: String,                  name_property: true
property :version,              kind_of: String,                  default: 'latest'
property :user,                 kind_of: String,                  required: true
property :group,                kind_of: String,                  required: true
property :keep_wpcontent,       kind_of: [TrueClass, FalseClass], default: false

action :install do
  ark 'wordpress' do
    url "https://wordpress.org/wordpress-#{new_resource.version}.tar.gz"
    home_dir new_resource.path
    version new_resource.version
    action :install
    notifies :run, 'execute[set directory ownership]', :immediately
  end

  execute 'set directory ownership' do
    command "chown -R #{new_resource.user}:#{new_resource.group} #{new_resource.path}/"
    action :nothing
  end

  unless new_resource.keep_wpcontent
    wpcontent_dir = "#{new_resource.path}/wp-content"

    directory wpcontent_dir do
      recursive true
      action :delete
    end
  end
end

action :remove do
  directory new_resource.path do
    recursive true
    action :delete
  end
end
