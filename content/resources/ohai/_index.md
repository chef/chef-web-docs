---
resource_reference: true
properties_shortcode: resource_ohai_properties.md
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
title: ohai resource
resource: ohai
aliases:
- "/resource_ohai.html"
menu:
  infra:
    title: ohai
    identifier: chef_infra/cookbook_reference/resources/ohai ohai
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **ohai** resource to reload the Ohai configuration on a node.
    This allows recipes that change system attributes (like a recipe that adds a user)
    to refer to those attributes later on during the Chef Infra Client run.
syntax_full_code_block: |-
  ohai 'name' do
    plugin      String
    action      Symbol # defaults to :reload if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`ohai` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`plugin` is the property available to this resource."
actions_list:
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :reload:
    markdown: Reload Ohai Data
properties_list:
- property: plugin
  ruby_type: String
  required: false
  description_list:
  - markdown: The name of an Ohai plugin to be reloaded. If this property is not specified,
      Chef Infra Client will reload all plugins.
examples: |
  Reload All Ohai Plugins

  ```ruby
  ohai 'reload' do
    action :reload
  end
  ```

  Reload A Single Ohai Plugins

  ```ruby
  ohai 'reload' do
    plugin 'cloud'
    action :reload
  end
  ```

  Reload Ohai after a new user is created

  ```ruby
  ohai 'reload_passwd' do
    action :nothing
    plugin 'etc'
  end

  user 'daemonuser' do
    home '/dev/null'
    shell '/sbin/nologin'
    system true
    notifies :reload, 'ohai[reload_passwd]', :immediately
  end

  ruby_block 'just an example' do
    block do
      # These variables will now have the new values
      puts node['etc']['passwd']['daemonuser']['uid']
      puts node['etc']['passwd']['daemonuser']['gid']
    end
  end
  ```
---