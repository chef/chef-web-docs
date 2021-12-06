+++
title = "About chef-repo"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/chef_repo.html"]

[menu]
  [menu.infra]
    title = "About chef-repo"
    identifier = "chef_infra/cookbooks_reference/chef_repo.md"
    parent = "chef_infra/cookbook_reference"
    weight = 15
+++
<!-- markdownlint-disable-file MD033 -->
{{% chef_repo_description %}}

## Generate the chef-repo

Use the [chef generate repo command](/ctl_chef/#chef-generate-repo) to create your chef-repo directory along with the base folder structure. This command uses the `chef` command-line tool that is packaged as part of Chef Workstation to create a chef-repo.

```bash
chef generate repo REPO_NAME
```

{{< note >}}

`chef generate repo` generates a chef-repo that is configured for Policyfiles by default. To create a repository that is setup for Roles and Environments use the `--roles` flag when running the command.

{{< /note >}}

## Directory Structure

The chef-repo contains several directories, each with a README file that describes what it is for and how to use that directory when managing systems.

The default structure of a new chef-repo is:

{{% chef_repo_content %}}

### cookbooks/

This directory contains the cookbooks that are used to configure systems in the infrastructure which are are downloaded from the [Chef Supermarket](https://supermarket.chef.io/) or created locally. The Chef Infra Client uses cookbooks to configuring the systems in the organization. Each cookbook can be configured to contain cookbook-specific copyright, email, and license data.

### data_bags/

The `data_bags/` directory is used to store all the data bags that exist for an organization. Each sub-directory corresponds to a single data bag on the Chef Infra Server and contains a JSON file corresponding to each data bag item.

### policyfiles/

The `policyfiles/` directory is used to store Policyfiles in the `.rb` format that define the set of cookbooks and attributes to apply to specific systems managed by the Chef Infra Server.

## chefignore Files

The chefignore file is used to tell knife which cookbook files in the chef-repo should be ignored when uploading data to the Chef Infra Server. The type of data that should be ignored includes swap files, version control data, build output data, and so fort. The chefignore file uses the `File.fnmatch` Ruby syntax to define the ignore patterns using `*`, `**`, and `?` wildcards.

- A pattern is relative to the cookbook root
- A pattern may contain relative directory names
- A pattern may match all files in a directory

The chefignore file can be located in any subdirectory of a chef-repo: `/`, `/cookbooks`, `/cookbooks/COOKBOOK_NAME/`, etc. It should contain sections similar to the following:

```none
## section
*ignore_pattern

## section
ignore_pattern*

## section
**ignore_pattern

## section
ignore_pattern**

## section
?ignore_pattern

## section
ignore_pattern?
```

### Examples

The following example shows how to add entries to the `chefignore` file.

#### Ignore editor swap files

Many text editors leave files behind. To prevent these files from being uploaded to the Chef Infra Server, add an entry to the `chefignore` file.


For Emacs:

```none
*~
```

and for vim:

```none
*.sw[a-z]
```

## Many Users, Same Repo

{{% chef_repo_many_users_same_knife %}}
