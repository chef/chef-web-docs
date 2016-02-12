#
# Original Cookbook Name:: oc-releng-provisioner
# Recipe:: _github
#
# Copyright 2015, Chef Software, Inc.
#
# All rights reserved - Do Not Redistribute
#
Chef_Delivery::ClientHelper.enter_client_mode_as_delivery
include_recipe 'chef-sugar::default'

# Load Chef Sugar's core_extensions so we can call `String#flush` on heredocs
require 'chef/sugar/core_extensions'

build_user_home = "/var/opt/delivery/workspace"

directory "#{build_user_home}/.ssh" do
  owner node['delivery_builder']['build_user']
  group 'root'
  mode  '0700'
end

# GitHub support config for Delivery builders

# Add GitHub to ssh known_hosts
execute "ssh-keyscan -t rsa github.com >> #{build_user_home}/.ssh/known_hosts" do
  not_if "grep -q github.com '#{build_user_home}/.ssh/known_hosts'"
end

github_keys = encrypted_data_bag_item_for_environment('keys', 'github')

deploy_key_path = ::File.join(build_user_home, '.ssh', 'chef-delivery.pem')

file deploy_key_path do
  content  github_keys['chef-delivery']
  owner    node['delivery_builder']['build_user']
  group    'root'
  mode     '0600'
  sensitive true
end

file "#{build_user_home}/.ssh/config" do
  content <<-EOH.flush
    Host github.com
      IdentityFile #{deploy_key_path}
      StrictHostKeyChecking no
  EOH
  owner node['delivery_builder']['build_user']
  group 'root'
  mode  '0600'
end
Chef_Delivery::ClientHelper.leave_client_mode_as_delivery
