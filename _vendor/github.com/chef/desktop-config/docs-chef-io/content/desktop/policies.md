+++
title = "Set up policy"
draft = false

[menu]
  [menu.desktop]
    title = "Set up Policy"
    identifier = "desktop/install/nodes_and_policy_groups.md Set up Policy"
    parent = "desktop/install"
    weight = 50
+++

## Upload the Chef Desktop Cookbook

Upload the Chef Desktop Cookbook to your Chef Infra Server. From the development environment command line, navigate to the `/cookbooks` directory and run:

```powershell
knife cookbook upload <your cookbook name>
```

Knife and other Chef tools use the cookbook name specified inside of either the `metadata.rb` file or the `policyfile.rb` file, which is case sensitive. Naming cookbooks in all lower-case is the easiest way to avoid conflicts with your `knife` or `chef` commands.

Now your Chef Infra Server has the cookbook and settings it needs to apply to the nodes.

## Configure and upload the Policyfile to Chef Server

Check the Policyfile and apply it to our test nodes. Policies are a convenient strategy for managing nodes. Read [more about policies](https://docs.chef.io/policy/).

### Check the Policyfile

Your Chef Desktop `Policyfile.rb` should look similar to:

```ruby
name 'desktop-config'

# default_source :supermarket, 'https://supermarket.chef.io' do |s|
#   s.preferred_for 'chef-client'
# end

# run_list: chef-client will run these recipes in the order specified.
# cookbook::recipe
run_list 'desktop-config::default'

# Specify a custom source for a single cookbook:
cookbook 'desktop-config', path: '.'
```

### Upload the Policyfile

Upload the Policyfile to the Chef Infra Server. Call `chef update` first to do some needed housekeeping around your policyfile.

If this is the first time that you are using a Policyfile, use the `chef install` command to generate a lock file:

```powershell
chef install Policyfile.rb
```

Run `chef update` and `chef push` every time you update the version of your cookbook:

```powershell
chef update
chef push 'my_Policy_Group' 'Policyfile.rb'
```

- Next: [Zero-touch Deployment with Azure]({{< relref "zero_touch/windows/_index.md" >}})
- Last: [Chef Desktop Cookbook Development Environment]({{< relref "cookbook_repository.md" >}})
