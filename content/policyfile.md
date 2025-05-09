+++
title = "About Policyfiles"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/policyfile.html"]
product = ["client", "server"]

[menu]
  [menu.infra]
    title = "About Policyfiles"
    identifier = "chef_infra/policyfiles/policyfile.md About Policyfiles"
    parent = "chef_infra/policyfiles"
    weight = 20
+++

{{< readfile file="content/reusable/md/policyfile_summary.md" >}}

## Why Policyfiles?

Policyfiles make it easier to test and promote code safely with a simpler interface. Using a Policyfile improves the user experience and resolves real-world problems that some workflows built around Chef Infra must deal with. The following sections discuss in more detail some of the good reasons to use Policyfile, including:

* Focus the workflow on the entire system
* Safer development workflows
* Less expensive computation
* Code visibility
* Role mutability
* Cookbook mutability
* Replaces Berkshelf and the environment cookbook pattern

### Focused System Workflows

The knife command line tool maps closely to the Chef Infra Server API and the objects defined by it, such as roles, environments, run-lists, cookbooks, data bags, or nodes. Chef Infra Client assembles these pieces at run-time and configures a host to do useful work.

Policyfile focuses that workflow onto the entire system, rather than the individual components. For example, Policyfile describes whole systems, whereas each individual revision of the `Policyfile.lock.json` file uploaded to the Chef Infra Server describes a part of that system, inclusive of roles, environments, cookbooks, and the other Chef Infra Server objects necessary to configure that part of the system.

### Safer Workflows

Policyfile encourages safer workflows by making it easier to publish development versions of cookbooks to the Chef Infra Server without the risk of mutating the production versions and without requiring a complicated versioning scheme to work around cookbook mutability issues. Roles are mutable and those changes are applied only to the nodes specified by the policy. Policyfile doesn't require any changes to your normal workflows. Use the same repositories you are already using, the same cookbooks, and workflows. Policyfile will prevent an updated cookbook or role from being applied immediately to all machines.

### Code Visibility

When running Chef Infra without a Policyfile, the exact set of cookbooks that are applied to a node is defined by:

* The node's `run_list` property
* Any roles that are present in the node's run-list or recursively included by those roles
* The environment, which may restrict the set of valid cookbook versions for a node based on a variety of constraint operators
* Dependencies, as defined by each cookbook's metadata
* Dependency resolution picks the "best" set of cookbooks that meet dependency and environment criteria

These conditions are re-evaluated every time Chef Infra Client runs, which can make it harder to know which cookbooks will be run by Chef Infra Client or what the effects of updating a role or uploading a new cookbook will be.

Policyfile simplifies this behavior by computing the cookbook set on the workstation, and then producing a readable document of that solution: a `Policyfile.lock.json` file. This pre-computed file is uploaded to the Chef Infra Server, and is then used in each Chef Infra Client run that's managed by that particular policy name and policy group.

### Less Expensive Computation

When running Chef Infra without Policyfile, the Chef Infra Server loads dependency data for all known versions of all known cookbooks, and then runs an expensive computation to determine the correct set.

Policyfile moves this computation to the workstation, where it's done less frequently.

### Role and Environment Mutability

When running Chef Infra without Policyfile roles and environments are global objects. Changes to roles and environments are applied immediately to any node that contains that role in its run-list or belong to a particular environment. This can make it hard to update roles and environments and in some use cases discourages using them at all.

Policyfile effectively replaces roles and environments. Policyfile files are versioned automatically and new versions are applied to systems only when promoted.

### Cookbook Mutability

When running Chef without Policyfile, existing versions of cookbooks are mutable. This is convenient for many use cases, especially if users upload in-development cookbook revisions to the Chef Infra Server. But this sometimes creates issues that are similar to role mutability by allowing those cookbook changes to be applied immediately to nodes that use that cookbook. Users account for this by rigorous testing processes to ensure that only fully integrated cookbooks are ever published. This process does enforce good development habits, but at the same time it shouldn't be a required part of a workflow that ends with publishing an in-development cookbook to the Chef Infra Server for testing against real nodes. Policyfile solves this issue by using a cookbook publishing API for the Chef Infra Server that doesn't provide cookbook mutability. Name collisions are prevented by storing cookbooks by name and an opaque identifier that's computed from the content of the cookbook itself.

For example, name/version collisions can occur when users temporarily fork an upstream cookbook. Even if the user contributes their change and the maintainer is responsive, there may be a period of time where the user needs their fork to make progress. This situation presents a versioning dilemma: if the user doesn't update their own version, they must overwrite the existing copy of that cookbook on the Chef Infra Server, wheres if they do update the version number it might conflict with the version number of the future release of that upstream cookbook.

#### Opaque IDs

The opaque identifier that's computed from the content of a cookbook is the only place where an opaque identifier is necessary. When working with Policyfile, be sure to:

* Use the same names and version constraints as normal in the `Policyfile.rb` file
* Use the same references to cookbooks pulled from Chef Supermarket
* Use the same branch, tag, and revision patterns for cookbooks pulled from git
* Use the same paths for cookbooks pulled from disk

Extra metadata about the cookbook is stored and included in Chef Infra Server API responses and in the `Policyfile.lock.json` file, including the source of a cookbook (Chef Supermarket, git, local disk, etc.), as well as any upstream identifiers, such as git revisions. For cookbooks that are loaded from the local disk that are in a git repo, the upstream URL, current revision ID, and the state of the repo are stored also.

The opaque identifier is mostly behind the scenes and is only visible once published to the Chef Infra Server. Cookbooks that are uploaded to the Chef Infra Server may have extended version numbers such as `1.0.0-dev`.

### Environment Cookbooks

Policyfile replaces the environment cookbook pattern that's often required by Berkshelf, along with a dependency solver and fetcher. That said, Policyfile doesn't replace all Berkshelf scenarios.

## Knife Commands

The following knife commands used to set the policy group and policy name on the Chef Infra Server. For example:

```bash
knife node policy set test-node 'test-policy-group-name' 'test-policy-name'
```

## Policyfile.rb

{{< readfile file="content/reusable/md/policyfile_rb.md" >}}

### Syntax

{{< readfile file="content/reusable/md/policyfile_rb_syntax.md" >}}

### Settings

{{< readfile file="content/reusable/md/policyfile_rb_settings.md" >}}

### Example

{{< readfile file="content/reusable/md/policyfile_rb_example.md" >}}

## client.rb Settings

The following settings may be configured in the client.rb file for use with Policyfile:

`named_run_list`

: The run-list associated with a Policyfile.

`policy_group`

: The name of a policy group that exists on the Chef Infra Server. `policy_name` must also be specified.

`policy_name`

: The name of a policy, as identified by the `name` setting in a `Policyfile.rb` file. `policy_group` must also be specified.

`use_policyfile`

: Chef Infra Client automatically checks the configuration, node JSON, and the stored node on the Chef Infra Server to determine if Policyfile files are being used, and then automatically updates this flag. Default value: `false`.

## knife bootstrap

A node may be bootstrapped to use Policyfile files. Use the following options as part of the bootstrap command:

`--policy-group POLICY_GROUP`

: The name of a policy group that exists on the Chef Infra Server.

`--policy-name POLICY_NAME`

: The name of a policy, as identified by the `name` setting in a `Policyfile.rb` file.

For a customized bootstrap process, add `policy_name` and `policy_group` to the first-boot JSON file that's passed to Chef Infra Client.

## knife search

The `policy_name` and `policy_group` settings for a node are stored as searchable attributes and as such are available when using a fuzzy matching search pattern. For example: `knife search dev` will return nodes that are part of the `dev` policy group.

## Test w/Kitchen

Kitchen may be used to test Policyfile files. Add the following to kitchen.yml:

```yaml
provisioner:
  name: chef_zero
```

A named run-list may be used for each suite:

```yaml
suites:
  - name: client
    provisioner:
      named_run_list: test_client_recipe
  - name: server
    provisioner:
      named_run_list: test_server_recipe
```

or globally:

```yaml
provisioner:
  name: chef_zero
  named_run_list: integration_test_run_list
```

or testing with policies for each suite, once the Policyfile files are available in your repo:

```yaml
suites:
   - name: defaultmega
      provisioner:
         policyfile: policies/default.rb
   - name: defaultultra
      provisioner:
         policyfile: policies/defaulttwo.rb
```

{{< note >}}

As `chef_zero` explicitly tests outside the context of a Chef Infra Server, the `policy_groups` concept isn't applicable. The value of `policy_group` during a converge will be set to `local`.

{{< /note >}}

## chef Commands

{{< readfile file="content/reusable/md/policyfile_chef_commands.md" >}}

### chef clean-policy-cookbooks

{{< readfile file="content/workstation/reusable/md/ctl_chef_clean_policy_cookbooks.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_clean_policy_cookbooks_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_clean_policy_cookbooks_options.md" >}}

### chef clean-policy-revisions

{{< readfile file="content/workstation/reusable/md/ctl_chef_clean_policy_revisions.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_clean_policy_revisions_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_clean_policy_revisions_options.md" >}}

### chef delete-policy

{{< readfile file="content/workstation/reusable/md/ctl_chef_delete_policy.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_delete_policy_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_delete_policy_options.md" >}}

### chef delete-policy-group

{{< readfile file="content/workstation/reusable/md/ctl_chef_delete_policy_group.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_delete_policy_group_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_delete_policy_group_options.md" >}}

### chef diff

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_options.md" >}}

#### Examples

##### Compare current lock to latest commit on latest branch

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_current_lock_latest_branch.md" >}}

##### Compare current lock with latest commit on master branch

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_current_lock_master_branch.md" >}}

##### Compare current lock to specified revision

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_current_lock_specified_revision.md" >}}

##### Compare lock on master branch to lock on revision

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_master_lock_revision_lock.md" >}}

##### Compare lock for version with latest commit on master branch

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_version_lock_master_branch.md" >}}

##### Compare current lock with latest lock for policy group

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_current_lock_policy_group.md" >}}

##### Compare locks for two policy group

{{< readfile file="content/workstation/reusable/md/ctl_chef_diff_two_policy_groups.md" >}}

### chef export

{{< readfile file="content/workstation/reusable/md/ctl_chef_export.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_export_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_export_options.md" >}}

### chef generate policyfile

{{< readfile file="content/workstation/reusable/md/ctl_chef_generate_policyfile.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_generate_policyfile_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_generate_policyfile_options.md" >}}

### chef generate repo

{{< readfile file="content/workstation/reusable/md/ctl_chef_generate_repo.md" >}}

{{< note >}}

This subcommand requires using one (or more) of the options (below) to support Policyfile files.

{{< /note >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_generate_repo_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_generate_repo_options.md" >}}

### chef install

{{< readfile file="content/workstation/reusable/md/ctl_chef_install.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_install_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_install_options.md" >}}

#### Policyfile.lock.json

{{< readfile file="content/reusable/md/policyfile_lock_json.md" >}}

{{< readfile file="content/reusable/md/policyfile_lock_json_example.md" >}}

### chef push

{{< readfile file="content/workstation/reusable/md/ctl_chef_push.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_push_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_push_options.md" >}}

### chef push-archive

{{< readfile file="content/workstation/reusable/md/ctl_chef_push_archive.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_push_archive_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_push_archive_options.md" >}}

### chef show-policy

{{< readfile file="content/workstation/reusable/md/ctl_chef_show_policy.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_show_policy_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_show_policy_options.md" >}}

### chef undelete

{{< readfile file="content/workstation/reusable/md/ctl_chef_undelete.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_undelete_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_undelete_options.md" >}}

### chef update

{{< readfile file="content/workstation/reusable/md/ctl_chef_update.md" >}}

#### Syntax

{{< readfile file="content/workstation/reusable/md/ctl_chef_update_syntax.md" >}}

#### Options

{{< readfile file="content/workstation/reusable/md/ctl_chef_update_options.md" >}}
