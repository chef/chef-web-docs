Chef_Delivery::ClientHelper.enter_client_mode_as_delivery

ENV['AWS_CONFIG_FILE'] = File.join(node['delivery']['workspace']['root'], 'chef_aws_config')

require 'chef/provisioning/aws_driver'
ssh = encrypted_data_bag_item_for_environment('cia-creds', 'aws-ssh')
ssh_key_path =  File.join(node['delivery']['workspace']['cache'], '.ssh')
ssh_private_key_path =  File.join(node['delivery']['workspace']['cache'], '.ssh', 'id_rsa')
ssh_public_key_path =  File.join(node['delivery']['workspace']['cache'], '.ssh', 'id_rsa.pub')

with_driver 'aws::us-west-2'

directory ssh_key_path do
  owner node['delivery_builder']['build_user']
  group node['delivery_builder']['build_user']
  mode '0700'
  sensitive true
end

file ssh_private_key_path do
  content ssh['private_key']
  owner node['delivery_builder']['build_user']
  group node['delivery_builder']['build_user']
  mode '0600'
  sensitive true
end

file ssh_public_key_path do
  content ssh['public_key']
  owner node['delivery_builder']['build_user']
  group node['delivery_builder']['build_user']
  mode '0644'
end

aws_key_pair node['delivery']['change']['project']  do
  public_key_path ssh_public_key_path
  private_key_path ssh_private_key_path
  allow_overwrite false
end

execute 'build the site' do
  retries 2
  retry_delay 5
  command 'kitchen test --destroy always'
  environment(
    'PATH' => '/opt/chefdk/embedded/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games',
    'HOME' => node['delivery']['workspace']['cache'],
    'KITCHEN_YAML' => '.kitchen.delivery.yml'
  )
  cwd File.join(node['delivery']['workspace']['repo'], 'cookbooks', 'docs-builder')
end
