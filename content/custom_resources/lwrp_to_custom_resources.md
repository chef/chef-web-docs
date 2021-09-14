+++
title = "Migrating from LWRPs to Custom Resources"
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Migrating from LWRPs"
    identifier = "chef_infra/cookbook_reference/custom_resources/lwrp"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 50
+++

## Overview

It is no longer recommended to write resources in the __Light Weight Resource Provider (LWRP)__ format.

This guide describes how to migrate from an existing LWRP to a Custom Resource.

If you are creating a Custom Resource from scratch please see the [Custom Resource Getting Started Guide](getting-started.md) instead.

## Convert files to Custom Resources Layout

LWRPs consist of two library files: a resource and a provider for that resource.

```text
|- libraries
  |- provider_rvm_ruby.rb
  |- resource_rvm_ruby.rb
```

These files are merged into one, and moved into the resources directory.

```text
|- resources
    |- rvm_ruby.rb
```

## Drop LWRP classes

LWRPs used classes to separate Provider and Resource behaviors, but Custom Resources do not need this distinction. This means that we remove the class definitions in their entirety, as shown in the following example:

```ruby
#rvm/libraries/resource_rvm_ruby.rb
require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class RvmRuby < Chef::Resource::LWRPBase
      provides :rvm_ruby

      self.resource_name = :rvm_ruby
      default_action :install
    end
  end
end

# rvm/libraries/provider_rvm_ruby.rb
require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class RvmRuby < Chef::Provider::LWRPBase
      provides :rvm_ruby

      action :install do
        remote_file 'rvm_installer' do
          path "#{Chef::Config[:file_cache_path]}/rvm_installer.sh"
          source node['rvm']['installer_url']
          mode '755'
          not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/rvm_installer.sh") }
          action :create
        end
      end
    end
  end
end
```

Replace the above files with a singular resource:

```ruby
#rvm/resources/rvm_ruby.rb
provides :rvm_ruby
default_action :install

action :install do
  remote_file 'rvm_installer' do
    path "#{Chef::Config[:file_cache_path]}/rvm_installer.sh"
    source node['rvm']['installer_url']
    mode '755'
    not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/rvm_installer.sh") }
    action :create
  end
end
```

## Remove Attributes

It is best practice to use properties to change the behavior of resources.

In the previous example example we used an attribute to change the `installer_url`.

Instead, we should use a property that we can perform checks on. In this case, we can make sure we only accept a String.

```ruby
#rvm/resources/rvm_ruby.rb
provides :rvm_ruby
default_action :install

property installer_url, String, default: 'https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer'

action :install do
  remote_file 'rvm_installer' do
    path "#{Chef::Config[:file_cache_path]}/rvm_installer.sh"
    source new_resource.installer_url
    mode '755'
    not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/rvm_installer.sh") }
    action :create
  end
end
```
