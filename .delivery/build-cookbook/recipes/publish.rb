################################################################################
# Welcome to the publish phase
#
# This is run as the delivery build user and is where most of the magic happens.
# Here, we need to build our shipable package and put it somewhere to consume
# it.
#
#
################################################################################
include_recipe 'build-cookbook::_handler'
include_recipe 'chef-sugar::default'
include_recipe 'delivery-truck::publish'

Chef_Delivery::ClientHelper.enter_client_mode_as_delivery

ENV['AWS_CONFIG_FILE'] = File.join(node['delivery']['workspace']['root'], 'aws_config')

require 'chef/provisioning/aws_driver'
with_driver 'aws'

software_version = Time.now.strftime('%F_%H%M')
build_name = "#{node['delivery']['change']['project']}-#{software_version}"
artifact_bucket = "#{node['delivery']['change']['project'].gsub(/_/, '-')}-artifacts"
chef_aws_creds = encrypted_data_bag_item_for_environment('cia-creds', 'chef-aws')
chef_cia_creds = encrypted_data_bag_item_for_environment('cia-creds', 'chef-cia')
ssh = encrypted_data_bag_item_for_environment('cia-creds', 'aws-ssh')
ssh_key_path =  File.join(node['delivery']['workspace']['cache'], '.ssh')
ssh_private_key_path =  File.join(node['delivery']['workspace']['cache'], '.ssh', node['delivery']['change']['project'])
ssh_public_key_path =  File.join(node['delivery']['workspace']['cache'], '.ssh', "#{node['delivery']['change']['project']}.pub")

chef_gem 'kitchen-ec2'

aws_s3_bucket artifact_bucket do
  enable_website_hosting false
  website_options :index_document => {
    :suffix => "index.html"
  },
  :error_document => {
    :key => "not_found.html"
  }
end

template File.join(node['delivery']['workspace']['repo'], 'cookbooks', 'docs-builder', '.kitchen.delivery.yml') do
  source '.kitchen.delivery.yml.erb'
  variables(
    chef_aws_access_key: chef_aws_creds['access_key_id'],
    chef_aws_secret_key: chef_aws_creds['secret_access_key'],
    cia_access_key: chef_cia_creds['access_key_id'],
    cia_secret_key: chef_cia_creds['secret_access_key'],
    build_name: build_name,
    bucket_name: artifact_bucket,
    ssh_key: File.read('/var/opt/delivery/workspace/etc/builder_key'),
    repo_location: 'ssh://builder@chef@delivery.chef.co:8989/chef/CIA/chef-web-docs',
    cached: false
  )
  sensitive true
end

include_recipe 'build-cookbook::_run_builder'

execute "download the checksum" do
  command "aws s3 cp s3://#{artifact_bucket}/#{build_name}.tar.gz.checksum #{node['delivery']['workspace']['cache']}/"
  cwd node['delivery']['workspace']['repo']
  environment 'AWS_CONFIG_FILE'=> File.join(node['delivery']['workspace']['root'], 'aws_config')
end

checksum = ''
ruby_block 'get checksum' do
  block do
    checksum = File.read(File.join(node['delivery']['workspace']['cache'], "#{build_name}.tar.gz.checksum"))
  end
end

ruby_block 'upload data bag' do
  block do
    Chef_Delivery::ClientHelper.enter_client_mode_as_delivery
    dbag = Chef::DataBag.new
    dbag.name(node['delivery']['change']['project'])
    dbag.save
    dbag_data = {
      'id' => software_version,
      'version' => software_version,
      'artifact_location' => "s3://#{artifact_bucket}/#{build_name}.tar.gz",
      'artifact_name' => "#{build_name}.tar.gz",
      'artifact_checksum' => checksum,
      'artifact_type' => 's3',
      'delivery_data' => node['delivery']
    }
    dbag_item = Chef::DataBagItem.new
    dbag_item.data_bag(dbag.name)
    dbag_item.raw_data = dbag_data
    dbag_item.save
    Chef_Delivery::ClientHelper.leave_client_mode_as_delivery
  end
end

ruby_block 'set the version in the env' do
  block do
    Chef_Delivery::ClientHelper.enter_client_mode_as_delivery
    begin
      to_env = Chef::Environment.load(get_acceptance_environment)
    rescue Net::HTTPServerException => http_e
      raise http_e unless http_e.response.code == "404"
      Chef::Log.info("Creating Environment #{get_acceptance_environment}")
      to_env = Chef::Environment.new()
      to_env.name(get_acceptance_environment)
      to_env.create
    end

    to_env.override_attributes['applications'] ||= {}
    to_env.override_attributes['applications'][node['delivery']['change']['project']] = software_version
    to_env.save
    ::Chef::Log.info("Set #{node['delivery']['change']['project']}'s version to #{software_version} in #{node['delivery']['change']['project']}.")
    Chef_Delivery::ClientHelper.leave_client_mode_as_delivery
  end
end
