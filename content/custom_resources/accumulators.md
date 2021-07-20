+++
title = "Accumulators"
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Accumulators"
    identifier = "chef_infra/cookbook_reference/custom_resources/accumulators"
    parent = "chef_infra/cookbook_reference/custom_resources"
    weight = 15
+++

This is an advanced topic. You should have already written a Custom Resource and be familiar with:

- the built-in Chef Infra `template` resource
- resource `[run_context](dsl/run_context.md)`

## Overview

An accumulator is a programming pattern to gather multiple values together.

In the context of Custom Resources, this means we collect a set of properties from multiple Custom Resources, and then apply the final collection to a resource.

If the software you are automating has a single configuration file, but you wish to split out each configuration section into its own resource this can be done with the accumulator pattern.

For example, Samba uses a single file for configuration. You may wish to share multiple directories within the same configuration file. This is not possible without multiple `samba_share` resources.

```ruby
samba_share 'first_share' do
  comment 'exported share 1'
  path '/srv/export'
  guest_ok true
  printable false
  write_list ['test_user_1']
  create_mask '0644'
  directory_mask '0775'
  options 'inherit permissions' => 'yes'
end

samba_share 'second_share' do
  comment 'exported share 2'
  path '/srv/export_2'
  guest_ok false
  printable false
  write_list ['test_user_2']
  create_mask '0644'
  directory_mask '0775'
  create_directory false
end
```

To setup the accumulator pattern we need to:

- delcare a resource
- edit the resource
- put both resources in the :root `run_context`
- delay the actions on the resources

In the example below we:

- Setup the template resource so we can later add new items to it.
- Set the `action` to `:nothing`, and the `delayed_action` to `:create`.
- Place the template resource into the root run_context so that we can later find the resource with the `samba_share` resource.
- Use edit_resource to find the template
- Add new variables to the existing collection using edit_resource

_Note_: We use the `||=` Ruby method to add a new Hash if one does not exist already.

```ruby
# samba_server
action :create do
  package 'samba'

  # We need to force both the server template and the
  # share templates into the root context to find each other
  with_run_context :root do
    template new_resource.config_file do
      source 'smb.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      cookbook 'samba'
      variables(samba_options: new_resource.options)
      action :nothing
      delayed_action :create
    end
end


# samba_share
action :add do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      variables[:shares] ||= {}
      variables[:shares][new_resource.share_name] ||= {}
      variables[:shares][new_resource.share_name]['comment'] = new_resource.comment
      variables[:shares][new_resource.share_name]['path'] = new_resource.path
    end
end
```

## Further Reading

- [here](https://github.com/chef/chef/issues/5438#issuecomment-351153222)
- [DNSimple](https://blog.dnsimple.com/2017/10/chef-accumulators/)
- [HAProxy](https://github.com/sous-chefs/haproxy/blob/a9c24d336c01828fef52cedae8cc445d8dbc21dd/libraries/resource.rb#L22)
