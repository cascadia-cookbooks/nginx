#
# Cookbook Name:: cop_nginx
# Recipe:: dependencies
#

cache = Chef::Config[:file_cache_path]

remote_file 'download nginx gpg key' do
    path   "#{cache}/nginx.asc"
    source 'https://nginx.org/packages/keys/nginx_signing.key'
    owner  'root'
    group  'root'
    mode   0644
    action :create
end

# NOTE: nginx.org uses 'rhel' instead of 'redhat' in mainline list
# rhel/centos and debian/ubuntu might be identical, but rather be safe here
platform = node['platform'] == 'redhat' ? 'rhel' : node['platform']
case node['platform_family']
when 'debian'
    # NOTE: support for https in apt repos
    package 'apt-transport-https' do
        action :install
    end

    file 'install nginx repo' do
        path    '/etc/apt/sources.list.d/nginx.list'
        content "deb https://nginx.org/packages/mainline/#{platform}/ #{node['lsb']['codename']} nginx"
        user   'root'
        group  'root'
        mode   0644
        action :create
        notifies :run, 'execute[import nginx gpg]', :immediately
        notifies :run, 'execute[update apt]', :immediately
    end

    execute 'import nginx gpg' do
        command "apt-key add #{cache}/nginx.asc"
        # NOTE: nginx public key id: 7BD9BF62
        not_if  'apt-key list | grep 7BD9BF62'
        action  :nothing
    end

    execute 'update apt' do
        command 'apt-get update'
        action  :nothing
    end
when 'rhel'
    file 'install nginx repo' do
        path    '/etc/yum.repos.d/nginx.repo'
        content "[nginx]
name=Nginx
baseurl=https://nginx.org/packages/mainline/#{platform}/#{node['platform_version'].to_i}/$basearch/
enabled=1
gpgcheck=1"
        user   'root'
        group  'root'
        mode   0644
        action :create
        notifies :run, 'execute[import nginx gpg]', :immediately
    end

    execute 'import nginx gpg' do
        command "rpm --import #{cache}/nginx.asc"
        # NOTE: nginx public key id: 7BD9BF62
        not_if  'rpm -qa gpg-pubkey* | grep 7BD9BF62'
        action  :nothing
    end
end
