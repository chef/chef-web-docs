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

### Cookbook Directory Structure

The default structure of the cookbooks directory is:

```output
. chef-repo
  - cookbooks
    - example
      - attributes
        - default.rb
      - recipes
        - default.rb
    - metadata.rb
    - README.rb
```

## Cookbook Commands

Use the following commands to create a cookbook, install a cookbook from Supermarket, and/or download cookbooks.

### Create

Chef Workstation generates the `cookbooks` directory as part of your Chef Infra repository, the `chef-repo`.

Generate a `chef-repo/cookbooks` directory with the command:

```bash
chef generate template PATH_TO_COOKBOOKS COOKBOOK_NAME
```

For example, this command generates a `custom_web` cookbook:

```bash
chef generate cookbook cookbooks/custom_web
```

The `custom_web` cookbook directory has the structure:

```text
. cookbooks
  - custom_web
    - recipes
      - default.rb
    - test
      - integration
        - default
          - default_test.rb
    - .gitignore
    - CHANGELOG.md
    - chefignore
    - kitchen.yml
    - LICENSE
    - metadata.rb
    - Policyfile.rb
    - README.md
```

Any unneeded directory components can be left unused or deleted, if
preferred.

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
`COOKBOOK_NAME.tar.gz` in the current directory (`~/chef-repo`).
Once downloaded, using a version source control system is recommended.
