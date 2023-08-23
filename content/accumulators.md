+++
title = "Accumulators"
gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Accumulators"
    identifier = "chef_infra/resources/custom_resources/accumulators"
    parent = "chef_infra/resources/custom_resources"
    weight = 20
+++

This is an advanced topic. You should have already written a Custom Resource and be familiar with:

- The built-in Chef Infra [`template`]({{< relref "resources/template" >}}) resource
- Cookbook execution [`with_run_context`]({{< relref "infra_language/cookbook_execution/#with_run_context" >}})

## Overview

An accumulator is a programming pattern that gathers multiple values together.

In the context of Custom Resources, the accumulator pattern collects a set of properties from  Custom Resources, and then applies the collection to a resource.

The steps for setting up an accumulator pattern are:

- Declare a resource
- Edit the resource
- Add both resources to the :root `run_context`
- Delay the actions on the resources

## Example Accumulator: Samba

Samba Linux tool systems for supporting sharing resources in a network with Windows systems. Samba uses a single file for configuration. To share more than one directory using this configuration file, you need to write multiple `samba_share` resources.

The accumulator pattern lets you split out each configuration section into its own resource.

<!-- markdownlint-disable MD033 MD031 -->
<!----Tabs Section--->
{{< foundation_tabs tabs-id="tabs-panel-container" >}}
{{< foundation_tab active="true" panel-link="id-1" tab-text="Share Resource 1">}}
{{< foundation_tab panel-link="id-2" tab-text="Share Resource 2" >}}
{{< /foundation_tabs >}}
<!----End Tabs --->

<!----Panels Section --->
{{< foundation_tabs_panels tabs-id="tabs-panel-container" >}}
{{< foundation_tabs_panel active="true" panel-id="id-1" >}}
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
```
{{< /foundation_tabs_panel >}}
{{< foundation_tabs_panel panel-id="id-2" >}}
```ruby
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
{{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}
<!----End Panels --->
<!-- markdownlint-enable MD033 MD031-->

## Example

The following example shows how to:

- Setup the template resource
- Set the `action` to `:nothing`
- Set the `delayed_action` to `:create`.
- Add the template resource to the `root` run context, which allows the `samba_share` resource to find it.
- Use `edit_resource` to find the template
- Use `edit_resource` to add new variables to the existing collection

_Note_: This uses the `||=` Ruby method to add a new Hash if one doesn't exist already.

```ruby
# action for the samba_server custom resource
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
end


# action for the samba_share custom resource
action :add do
  with_run_context :root do
    edit_resource(:template, new_resource.config_file) do |new_resource|
      variables[:shares] ||= {}
      variables[:shares][new_resource.share_name] ||= {}
      variables[:shares][new_resource.share_name]['comment'] = new_resource.comment
      variables[:shares][new_resource.share_name]['path'] = new_resource.path
    end
  end
end
```

## Further Reading

- [here](https://github.com/chef/chef/issues/5438#issuecomment-351153222)
- [DNSimple](https://blog.dnsimple.com/2017/10/chef-accumulators/)
- [HAProxy](https://github.com/sous-chefs/haproxy/blob/a9c24d336c01828fef52cedae8cc445d8dbc21dd/libraries/resource.rb#L22)
