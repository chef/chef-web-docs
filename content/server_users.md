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

{{< readfile file="content/server/reusable/md/ctl_chef_server_summary.md" >}}

{{< readfile file="content/server/reusable/md/ctl_chef_server_user.md" >}}

### org-create

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_create.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_create_syntax.md" >}}

#### Options

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_create_options.md" >}}

### org-delete

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_delete.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_delete_syntax.md" >}}

### org-list

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_list.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_list_syntax.md" >}}

#### Options

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_list_options.md" >}}

### org-show

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_show.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_show_syntax.md" >}}

### org-user-add

{{< warning >}}

Early RC candidates for the Chef Server 12 release named this command
`org-associate`. This is the same command, with the exception of the
`--admin` flag, which is added to the command (along with the rename)
for the upcoming final release of Chef Server 12.

{{< /warning >}}

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_user_add.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_user_add_syntax.md" >}}

#### Options

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_user_add_options.md" >}}

### org-user-remove

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_user_remove.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_org_user_remove_syntax.md" >}}

### user-create

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_create.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_create_syntax.md" >}}

#### Options

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_create_options.md" >}}

### user-delete

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_delete.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_delete_syntax.md" >}}

### user-edit

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_edit.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_edit_syntax.md" >}}

### user-list

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_list.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_list_syntax.md" >}}

#### Options

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_list_options.md" >}}

### user-show

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_show.md" >}}

#### Syntax

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_show_syntax.md" >}}

#### Options

{{< readfile file="content/server/reusable/md/ctl_chef_server_user_show_options.md" >}}
