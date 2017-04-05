require 'spec_helper'

describe 'nginx::default' do
  # TODO: test source recipe too
  # TODO: move this to the package recipe
  describe package('nginx') do
    it { should be_installed }
  end

  it 'the NGINX service is enabled' do
    expect(service('nginx')).to be_enabled
  end

  it 'the NGINX service is running' do
    expect(service('nginx')).to be_running
  end

  describe command('nginx -v') do
    its(:stderr) { should match /1.11.?/ }
  end

  describe user('nginx') do
    it { should exist }
  end

  describe group('nginx') do
    it { should exist }
  end

  describe file('/etc/nginx/nginx.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end

  describe file('/etc/nginx/compression') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    it { should contain('gzip         on;') }
    it { should contain('application/x-javascript') }
  end

  describe file('/etc/nginx/mime.types') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
  end
end
