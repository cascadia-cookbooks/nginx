require 'spec_helper'

describe 'nginx::default' do
  describe package('nginx') do
    it { should be_installed }
  end

  # Test for additional packages
  describe package('nginx-module-geoip') do
    it { should be_installed }
  end

  describe service('nginx') do
      it { should be_enabled }
      it { should be_running }
  end

  describe command('nginx -v') do
    # NOTE: version 2 should be far enough out
    its(:stderr) { should match /1\.[0-9]/ }
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
    its(:content) { should include 'load_module modules/ngx_http_geoip_module.so;'}
    its(:content) { should include 'load_module modules/ngx_stream_geoip_module.so;'}
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

  describe file('/etc/nginx/block.d') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '755' }
  end

  describe file('/etc/nginx/block.d/string_block') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    it { should contain('Some nice NGINX code') }
  end

  describe file('/etc/nginx/block.d/hashed_block') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    it { should contain("# This\n# works\n# too") }
  end
end

describe 'nginx::vhost' do
    describe file('/etc/nginx/conf.d/test.localhost.com.conf') do
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode '644' }
        its(:content) { should include 'ssl_ciphers               HIGH:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4:!3DES:;' }
    end
end
