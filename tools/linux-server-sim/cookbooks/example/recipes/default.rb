package 'nginx'

user 'deploy' do
  comment 'Managed by Chef Infra'
  home '/home/deploy'
  manage_home true
  shell '/bin/bash'
end

file '/etc/profile.d/chef-baseline.sh' do
  content "export CHEF_BASELINE='managed'\n"
  owner 'root'
  group 'root'
  mode '0644'
end

service 'nginx' do
  action [:enable, :start]
end
