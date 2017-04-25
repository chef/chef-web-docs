#
# Cookbook Name:: docs-builder
# Recipe:: default
#
# Copyright:: 2015-2017, Chef Software Inc.
#

package %w( git python-pip python-dev parallel )

execute 'install awscli' do
  command 'pip install awscli'
  not_if { ::File.exist?('/usr/local/bin/aws') }
end

directory '/root/.ssh' do
  mode '0755'
end

file '/root/.ssh/id_rsa' do
  mode '0600'
  content node['docs-builder']['ssh_key'].gsub(/::::::::/, "\n")
  sensitive true
end

directory '/root/bin'

cookbook_file '/root/bin/git_ssh' do
  mode '0755'
  source 'git_ssh'
end

execute 'ssh-keyscan -t rsa delivery.chef.co >> /root/.ssh/known_hosts' do
  not_if "grep -q delivery.chef.co '/root/.ssh/known_hosts'"
end

directory '/srv'

execute 'mkfs' do
  command 'mkfs.ext4 /dev/xvdi'
  not_if 'blkid -o value -s TYPE /dev/xvdi'
end

mount '/srv' do
  device '/dev/xvdi'
end

git '/srv/chef-web-docs' do
  action :sync
  repository node['docs-builder']['repo_location']
  revision 'web'
  environment 'GIT_SSH' => '/root/bin/git_ssh'
end

execute 'pip install -r requirements.txt' do
  cwd '/srv/chef-web-docs'
end

build_targets = <<END
docs
END

file '/srv/chef-web-docs/targets.txt' do
  content build_targets
end

execute 'parallel -a targets.txt make' do
  cwd '/srv/chef-web-docs'
end

file ::File.join('/srv/chef-web-docs', 'build', 'version.txt') do
  content node['docs-builder']['build_name']
end

execute 'create the tarball' do
  command "tar cvzf /srv/#{node['docs-builder']['build_name']}.tar.gz --exclude .git --exclude .delivery --exclude .doctrees build"
  cwd '/srv/chef-web-docs'
  environment 'AWS_ACCESS_KEY_ID' => node['docs-builder']['prod_aws_access_key'],
              'AWS_SECRET_ACCESS_KEY' => node['docs-builder']['prod_aws_secret_access_key'],
              'AWS_DEFAULT_REGION' => 'us-east-1'
end

execute 'upload the tarball' do
  command "aws s3 cp /srv/#{node['docs-builder']['build_name']}.tar.gz s3://#{node['docs-builder']['bucket_name']}/"
  cwd '/srv/chef-web-docs'
  environment 'AWS_ACCESS_KEY_ID' => node['docs-builder']['prod_aws_access_key'],
              'AWS_SECRET_ACCESS_KEY' => node['docs-builder']['prod_aws_secret_access_key'],
              'AWS_DEFAULT_REGION' => 'us-east-1'
end

checksum = ''
ruby_block 'get checksum' do
  block do
    checksum = `shasum -a 256 /srv/#{node['docs-builder']['build_name']}.tar.gz`.split[0]
  end
end

file "/srv/#{node['docs-builder']['build_name']}.tar.gz.checksum" do
  content lazy { checksum }
end

execute 'upload the checksum' do
  command "aws s3 cp /srv/#{node['docs-builder']['build_name']}.tar.gz.checksum s3://#{node['docs-builder']['bucket_name']}/"
  cwd '/srv/chef-web-docs'
  environment 'AWS_ACCESS_KEY_ID' => node['docs-builder']['prod_aws_access_key'],
              'AWS_SECRET_ACCESS_KEY' => node['docs-builder']['prod_aws_secret_access_key'],
              'AWS_DEFAULT_REGION' => 'us-east-1'
end
