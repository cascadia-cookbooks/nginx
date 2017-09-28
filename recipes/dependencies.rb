#
# Cookbook Name:: cop_nginx
# Recipe:: dependencies

# NOTE: nginx.org uses 'rhel' instead of 'redhat' in mainline list
# rhel/centos and debian/ubuntu might be identical, but rather be safe here
platform = node['platform'] == 'redhat' ? 'rhel' : node['platform']

case node['platform_family']
when 'debian'

    # NOTE: support for https in apt repos
    package 'apt-transport-https' do
        action :install
    end

    apt_repository 'nginx' do
        uri          "https://nginx.org/packages/mainline/#{platform}/"
        distribution "#{node['lsb']['codename']}"
        key          'https://nginx.org/keys/nginx_signing.key'
        components   ['nginx']
        deb_src      true
    end

    execute 'update apt' do
        command 'apt-get update'
        action  :nothing
    end

when 'rhel'

    yum_repository 'nginx' do
        description 'NGINX Repository'
        baseurl     "https://nginx.org/packages/mainline/#{platform}/#{node['platform_version'].to_i}/$basearch/"
        enabled     true
        gpgcheck    true
        gpgkey      'https://nginx.org/keys/nginx_signing.key'
        action      :create
    end

end
