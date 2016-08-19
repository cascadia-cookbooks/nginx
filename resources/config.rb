#
# Cookbook Name:: cop_wordpress
# Resource:: config
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

resource_name :wordpress_config
provides :wordpress_config

property :path,                  kind_of: String,                   default: '/var/www/wordpress/wp-config.php', name_attribute: true
property :user,                  kind_of: String,                   default: 'www-data'
property :group,                 kind_of: String,                   default: 'www-data'
property :database_name,         kind_of: String,                   default: 'wordpress'
property :database_user,         kind_of: String,                   required: true
property :database_password,     kind_of: String,                   required: true
property :database_table_prefix, kind_of: String,                   default: 'wp_'
property :database_host,         kind_of: String,                   default: '127.0.0.1'
property :database_charset,      kind_of: String,                   default: 'utf-8'
property :database_collate,      kind_of: String,                   default: ''
property :auth_key,              kind_of: String,                   required: true
property :secure_auth_key,       kind_of: String,                   required: true
property :logged_in_key,         kind_of: String,                   required: true
property :nonce_key,             kind_of: String,                   required: true
property :auth_salt,             kind_of: String,                   required: true
property :secure_auth_salt,      kind_of: String,                   required: true
property :logged_in_salt,        kind_of: String,                   required: true
property :nonce_salt,            kind_of: String,                   required: true
property :language,              kind_of: String,                   default: ''
property :allow_multisite,       kind_of: [TrueClass, FalseClass],  default: false
property :debug_mode,            kind_of: [TrueClass, FalseClass],  default: false
property :config_options,        kind_of: Hash,                     default: {}

action :create do
  template new_resource.path do
    source 'wp-config.php.erb'
    owner new_resource.user
    group new_resource.group
    mode '0600'
    action :create
    variables(
      :db_name          => new_resource.database_name,
      :db_user          => new_resource.database_user,
      :db_password      => new_resource.database_password,
      :db_host          => new_resource.database_host,
      :db_prefix        => new_resource.database_table_prefix,
      :db_charset       => new_resource.database_charset,
      :db_collate       => new_resource.database_collate,
      :table_prefix     => new_resource.database_table_prefix,
      :debug_mode       => new_resource.debug_mode,
      :language         => new_resource.language,
      :auth_key         => new_resource.auth_key,
      :secure_auth_key  => new_resource.secure_auth_key,
      :logged_in_key    => new_resource.logged_in_key,
      :nonce_key        => new_resource.nonce_key,
      :auth_salt        => new_resource.auth_salt,
      :secure_auth_salt => new_resource.secure_auth_salt,
      :logged_in_salt   => new_resource.logged_in_salt,
      :nonce_salt       => new_resource.nonce_salt,
      :allow_multisite  => new_resource.allow_multisite,
      :config_options   => new_resource.config_options
    )
  end
end
