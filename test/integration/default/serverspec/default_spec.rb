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

  case os[:release]
  when '14.04'
    describe command('nginx -v') do
      its(:stderr) { should match /1.4.6/ }
    end

  when '16.04'
    describe command('nginx -v') do
      its(:stderr) { should match /1.10.0/ }
    end

    describe user('www-data') do
      it { should exist }
    end

    describe group('www-data') do
      it { should exist }
    end

  when /7.2.*/
    describe command('nginx -v') do
      its(:stderr) { should match /1.10.1/ }
    end

    describe user('nginx') do
      it { should exist }
    end

    describe group('nginx') do
      it { should exist }
    end
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
