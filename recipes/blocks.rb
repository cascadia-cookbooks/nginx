#
# Cookbook Name:: cop_nginx
# Recipe:: blocks
# Author:: Copious Inc. <engineering@copiousinc.com>
#

blocks = node['nginx']['blocks']

unless blocks
    return
end

directory node['nginx']['block_dir'] do
    owner 'root'
    group 'root'
    mode  0755
end

blocks.each do |block, data|
    template "Creating block: #{block}" do 
        path    "#{node['nginx']['block_dir']}/#{block}"
        source  'nginx/blocks.erb'
        owner   'root'
        group   'root'
        mode    0644
        action  :create
        variables ({
            'content': data['content']
        })
        notifies :restart, 'service[nginx]', :delayed
    end
end
