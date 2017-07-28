require 'spec_helper'

describe 'nginx::default' do
    describe package('nginx') do
        it { should be_installed }
    end
  
    describe service('nginx') do
        it { should be_enabled }
        it { should be_running }
    end
  
    describe port(80) do
        it { should be_listening }
    end

    describe port(443) do
        it { should be_listening }
    end

    describe port(8080) do
        it { should be_listening }
    end
end

describe 'nginx::varnish' do
    describe service('varnish') do
        it { should be_enabled }
        it { should be_running }
    end

    describe port(6081) do
        it { should be_listening }
    end

    describe file('/etc/nginx/conf.d/varnish.localhost.com.conf') do
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode '644' }
        it { should contain('proxy_pass http://127.0.0.1:6081;') }
        it { should contain('listen 8080') }
    end
end
