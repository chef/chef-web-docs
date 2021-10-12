+++
title = "Get Started"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/cookbook_repo.html"]
product = ["client", "server", "workstation"]

[menu]
  [menu.infra]
    title = "Cookbook Directory"
    identifier = "chef_infra/cookbook_reference/cookbook_repo.md Cookbook Repo"
    parent = "chef_infra/cookbook_reference"
    weight = 20
+++

The `cookbooks/` directory of your Chef Infra repository is used to
store the cookbooks that Chef Infra Client uses in configuring the
various systems in the organization.

## Chef Repository 

The the `\cookbook` directory is automatically generated as part of your Chef Infra repository.

```bash
chef generate repo REPO_NAME
```

## Cookbook Commands

Use the following commands to create a cookbook, install a cookbook from Supermarket, and/or download cookbooks.

### Create

To create a cookbook (including all default components), run the
following command:

```bash
chef generate cookbook COOKBOOK_NAME
```

where `COOKBOOK_NAME` is the name of the cookbook that will be created.
Any unneeded directory components can be left unused or deleted, if
preferred.

#### Cookbook Directory Structure

{{% cookbooks_content %}}

### Install

To download a cookbook when git is used for version source control, run
the following command:

```bash
knife supermarket install COOKBOOK_NAME
```

where `COOKBOOK_NAME` is the name of a cookbook on [Chef
Supermarket](https://supermarket.chef.io/). This will start a process
that:

- downloads the cookbook from [Chef
    Supermarket](https://supermarket.chef.io/) as a tar.gz archive
- ensures that its using the git master branch, and then checks out
    the cookbook from a vendor branch (creating a new vendor branch, if
    required)
- removes the old (existing) version
- expands the tar.gz archive and adds the expanded files to the git
    index and commits
- creates a tag for the version that was downloaded
- checks out the master branch
- merges the cookbook into the master (to ensure that any local
    changes or modifications are preserved)

### Download

To download a cookbook when git is not used for version source control,
run the following command:

```bash
knife supermarket download COOKBOOK_NAME
```

where `COOKBOOK_NAME` is the name of a cookbook on [Chef
Supermarket](https://supermarket.chef.io/). This will download the
tar.gz file associated with the cookbook and will create a file named
`COOKBOOK_NAME.tar.gz` in the current directory (e.g., `~/chef-repo`).
Once downloaded, using a version source control system is recommended.
