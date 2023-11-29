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

{{< readfile file="content/reusable/md/chef_repo_description.md" >}}

## Generate the chef-repo

Use the [chef generate repo command](/ctl_chef/#chef-generate-repo) to create your chef-repo directory along with the base folder structure. This command uses the `chef` command-line tool that is packaged as part of Chef Workstation to create a chef-repo.

```bash
chef generate repo REPO_NAME
```

{{< note >}}

`chef generate repo` generates a chef-repo that is configured for Policyfiles by default. To create a repository that is setup for Roles and Environments use the `--roles` flag when running the command.

{{< /note >}}

## Directory structure

The chef-repo contains several directories, each with a README file that describes what it's for and how to use that directory when managing systems.

The default structure of a new chef-repo is:

```plain
. chef-repo
├── LICENSE
├── README.md
├── chefignore
├── cookbooks
│   ├── README.md
│   └── example
│       ├── README.md
│       ├── attributes
│       │   ├── README.md
│       │   └── default.rb
│       ├── metadata.rb
│       └── recipes
│           ├── README.md
│           └── default.rb
├── data_bags
│   ├── README.md
│   └── example
│       ├── README.md
│       └── example_item.json
└── policyfiles
    └── README.md
```

### cookbooks

The `cookbooks` directory contains cookbooks that configure systems in the infrastructure which are are downloaded from the [Chef Supermarket](https://supermarket.chef.io/) or created locally. The Chef Infra Client uses cookbooks to configuring the systems in the organization. Each cookbook can be configured to contain cookbook-specific copyright, email, and license data.

### data_bags

The `data_bags` directory is used to store all the data bags that exist for an organization. Each sub-directory corresponds to a single data bag on the Chef Infra Server and contains a JSON file corresponding to each data bag item.

### policyfiles

The `policyfiles` directory is used to store Policyfiles in the `.rb` format that define the set of cookbooks and attributes to apply to specific systems managed by the Chef Infra Server.

### chefignore

A `chefignore` file tells knife which cookbook files in the chef-repo it should ignore when uploading data to the Chef Infra Server.
Include swap files, version control data, and build output data in a `chefignore` file.

The `chefignore` file has the following rules:

- Patterns use `*`, `**`, and `?` wildcards to match files and directories as defined by the `File.fnmatch` Ruby method.
- A pattern is relative to the directory it's included in.
- A pattern may contain relative directory names.
- A pattern may match all files in a directory.
- You can add a `chefignore` file to any subdirectory of a chef-repo. For example, `/`, `/cookbooks`, `/cookbooks/COOKBOOK_NAME/`, etc.
- Lines that start with `#` are comments.

Group types of ignored files in sections similar to the following:

```plain
## OS generated files
*ignore_pattern

## Editors
another_ignore_pattern*
```

See Ruby's [`File.fnmatch` documentation](https://ruby-doc.org/core-2.5.1/File.html#method-c-fnmatch) for information on creating matching file patterns.

#### Examples

Many text editors leave files behind. To prevent knife from uploading these files to the Chef Infra Server, add an entry to the `chefignore` file.

For Emacs backup files:

```plain
*~
```

and for Vim swap files:

```plain
*.sw[a-z]
```

## Many Users, Same Repo

{{< readfile file="content/reusable/md/chef_repo_many_users_same_knife.md" >}}
