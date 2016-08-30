resource_name :magento_vhost

property :magento_vhost, String, name_property: true
property :docroot, String, required: true
property :fpm_location, String, required: true
property :mage_run_code, String, required: false
property :mage_run_type, String, required: false

default_action :create

action :create do
    template "/etc/nginx/sites-available/#{magento_vhost}" do
        variables({
            :hostname      => magento_vhost,
            :docroot       => docroot,
            :fpm_location  => fpm_location,
            :mage_run_code => mage_run_code,
            :mage_run_type => mage_run_type,
        })
        source   'magento/vhost.conf.erb'
        owner    'root'
        group    'root'
        mode     0644
        backup   false
        action   :create
        notifies :restart, 'service[nginx]', :delayed
    end

    link "/etc/nginx/sites-enabled/#{magento_vhost}" do
        to       "/etc/nginx/sites-available/#{magento_vhost}"
        notifies :restart, 'service[nginx]', :delayed
    end

    service 'nginx' do
        action :nothing
    end
end

action :delete do
    file "/etc/nginx/sites-available/#{magento_vhost}" do
        backup   false
        action   :delete
        notifies :restart, 'service[nginx]', :delayed
    end

    link "/etc/nginx/sites-enabled/#{magento_vhost}" do
        action   :delete
        notifies :restart, 'service[nginx]', :delayed
    end

    service 'nginx' do
        action :nothing
    end
end
