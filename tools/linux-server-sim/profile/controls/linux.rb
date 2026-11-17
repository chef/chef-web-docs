control 'linux-server-01' do
  impact 'high'
  title 'Required server configuration is present'
  desc 'Linux servers must have the managed package, account, service, and file.'
  tag 'linux', 'configuration'

  describe package('nginx') do
    it { should be_installed }
  end

  describe user('deploy') do
    it { should exist }
    its('shell') { should eq '/bin/bash' }
  end

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/profile.d/chef-baseline.sh') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include "CHEF_BASELINE='managed'" }
  end
end
