require 'spec_helper'

describe 'nginx::default' do
  describe package('nginx') do
    it { should be_installed }
  end

  describe command('nginx -v'), :if => os[:release] == '14.04' do
    its(:stderr) { should match /1.4.6/ }
  end

  describe command('nginx -v'), :if => os[:release] == '16.04' do
    its(:stderr) { should match /1.10.0/ }
  end

  it 'the NGINX service is enabled' do
    expect(service('nginx')).to be_enabled
  end

  it 'the NGINX service is running' do
    expect(service('nginx')).to be_running
  end

  describe port(80) do
    it { should be_listening.on('0.0.0.0').with('tcp') }
  end

  it 'creates a www-data user' do
    expect(user('www-data')).to exist
  end

  it 'creates a www-data group' do
    expect(group('www-data')).to exist
  end

  describe file('/etc/nginx/nginx.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end

  describe file('/etc/nginx/mime.types') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end
end
