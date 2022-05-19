+++
title = "Users"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/server_users.html"]
product = ["server"]

[menu]
  [menu.legacy]
    title = "Users"
    identifier = "legacy/manage/server_users.md Users"
    parent = "legacy/manage"
+++

The following tasks are available for user management in Chef Infra
Server:

* Creating users
* Editing a user's profile
* Changing a password
* Recovering a password
* Regenerating a private key
* Viewing a user's profile

## chef-server-ctl

{{% chef-server/ctl_chef_server_summary %}}

{{% chef-server/ctl_chef_server_user %}}

### org-create

{{% chef-server/ctl_chef_server_org_create %}}

#### Syntax

{{% chef-server/ctl_chef_server_org_create_syntax %}}

#### Options

{{% chef-server/ctl_chef_server_org_create_options %}}

### org-delete

{{% chef-server/ctl_chef_server_org_delete %}}

#### Syntax

{{% chef-server/ctl_chef_server_org_delete_syntax %}}

### org-list

{{% chef-server/ctl_chef_server_org_list %}}

#### Syntax

{{% chef-server/ctl_chef_server_org_list_syntax %}}

#### Options

{{% chef-server/ctl_chef_server_org_list_options %}}

### org-show

{{% chef-server/ctl_chef_server_org_show %}}

#### Syntax

{{% chef-server/ctl_chef_server_org_show_syntax %}}

### org-user-add

{{< warning >}}

Early RC candidates for the Chef Server 12 release named this command
`org-associate`. This is the same command, with the exception of the
`--admin` flag, which is added to the command (along with the rename)
for the upcoming final release of Chef Server 12.

{{< /warning >}}

{{% chef-server/ctl_chef_server_org_user_add %}}

#### Syntax

{{% chef-server/ctl_chef_server_org_user_add_syntax %}}

#### Options

{{% chef-server/ctl_chef_server_org_user_add_options %}}

### org-user-remove

{{% chef-server/ctl_chef_server_org_user_remove %}}

#### Syntax

{{% chef-server/ctl_chef_server_org_user_remove_syntax %}}

### user-create

{{% chef-server/ctl_chef_server_user_create %}}

#### Syntax

{{% chef-server/ctl_chef_server_user_create_syntax %}}

#### Options

{{% chef-server/ctl_chef_server_user_create_options %}}

### user-delete

{{% chef-server/ctl_chef_server_user_delete %}}

#### Syntax

{{% chef-server/ctl_chef_server_user_delete_syntax %}}

### user-edit

{{% chef-server/ctl_chef_server_user_edit %}}

#### Syntax

{{% chef-server/ctl_chef_server_user_edit_syntax %}}

### user-list

{{% chef-server/ctl_chef_server_user_list %}}

#### Syntax

{{% chef-server/ctl_chef_server_user_list_syntax %}}

#### Options

{{% chef-server/ctl_chef_server_user_list_options %}}

### user-show

{{% chef-server/ctl_chef_server_user_show %}}

#### Syntax

{{% chef-server/ctl_chef_server_user_show_syntax %}}

#### Options

{{% chef-server/ctl_chef_server_user_show_options %}}
