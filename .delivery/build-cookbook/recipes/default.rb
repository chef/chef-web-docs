################################################################################
#
# Welcome to chef-web-learn
#
# This is the default recipe. It is the only recipe that runs as root. Here we
# install all the components we need to be functional or have to be done as
# root.
#
################################################################################

# We include chef-sugar because it gives us easy ways to interact with encrypted
# data bags. It may go away in the future.
include_recipe 'chef-sugar::default'

# We use the chef_handler recipe/cookbook so that we can register the an
# exception handler. The only issue here is that we register it inside the
# recipe so we are only going to get converge time exceptions.
include_recipe 'chef_handler::default'

# We include the delivery-truck default recipe so any setup that delivery-truck
# needs gets done.
include_recipe 'delivery-truck::default'

# We use the route53 resource later on so we need to include it here to get gems
# and other dependencies installed.
include_recipe 'route53::default'

# We use fastly as our CDN. This pulls in the gems to do the interaction later.
include_recipe 'fastly::default'

# We need the toolchain from node to deal with the javascripts... pull in node.
include_recipe 'nodejs::default'

# We need to ensure we have a full toolchain
include_recipe 'build-essential::default'
package 'libxml2-dev'

# We need the linkchecker in functional in order to check the links
execute 'install linkchecker' do
  command 'pip install linkchecker'
  not_if { File::exists?('/usr/local/bin/linkchecker') }
end

load_delivery_chef_config

# We need aws creds so we get them here.
aws_creds = encrypted_data_bag_item_for_environment('cia-creds', 'chef-cia')
chef_aws_creds = encrypted_data_bag_item_for_environment('cia-creds', 'chef-aws')

# Here we are installing the aws cli that is needed durring publish. The python
# install is actually done during the setup of the build nodes.
#
# TODO Move the python recipe back into the build cookbook
execute 'install awscli' do
  command 'pip install awscli'
  not_if { File::exists?('/usr/local/bin/aws') }
end

# chef-provisioning requires an aws config file. This generates the content for
# that file.
aws_config_contents = <<EOF
[default]
region = us-east-1
aws_access_key_id = #{aws_creds['access_key_id']}
aws_secret_access_key = #{aws_creds['secret_access_key']}
EOF

# This figures out where we are going to put the config file.
aws_config_filename = File.join(node['delivery']['workspace']['root'], 'aws_config')

# And here we write it out.
file aws_config_filename do
  sensitive true
  content aws_config_contents
end

chef_aws_config_contents = <<EOF
[default]
region = us-east-1
aws_access_key_id = #{chef_aws_creds['access_key_id']}
aws_secret_access_key = #{chef_aws_creds['secret_access_key']}
EOF

# This figures out where we are going to put the config file.
chef_aws_config_filename = File.join(node['delivery']['workspace']['root'], 'chef_aws_config')

# And here we write it out.
file chef_aws_config_filename do
  sensitive true
  content chef_aws_config_contents
end
