+++
title = "About Policyfiles"
draft = false
gh_repo = "chef-web-docs"

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

Use the `chef clean-policy-cookbooks` subcommand to delete cookbooks
that are not used by Policyfile files. Cookbooks are considered unused
when they are not referenced by any policy revisions on the Chef Infra
Server.

{{< note >}}

Cookbooks that are referenced by orphaned policy revisions are not
removed. Use `chef clean-policy-revisions` to remove orphaned policies.

{{< /note >}}

#### Syntax

This subcommand has the following syntax:

```bash
chef clean-policy-cookbooks (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef clean-policy-revisions

Use the `chef clean-policy-revisions` subcommand to delete orphaned
policy revisions to Policyfile files from the Chef Infra Server. An
orphaned policy revision is not associated to any policy group and
therefore is not in active use by any node. Use
`chef show-policy --orphans` to view a list of orphaned policy
revisions.

#### Syntax

This subcommand has the following syntax:

```bash
chef clean-policy-revisions (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef delete-policy

Use the `chef delete-policy` subcommand to delete all revisions of the
named policy that exist on the Chef Infra Server. (The state of the
policy revision is backed up locally and may be restored using the
`chef undelete` subcommand.)

#### Syntax

This subcommand has the following syntax:

```bash
chef delete-policy POLICY_NAME (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef delete-policy-group

Use the `chef delete-policy-group` subcommand to delete the named policy
group from the Chef Infra Server. Any policy revision associated with
that policy group is not deleted. (The state of the policy group is
backed up locally and may be restored using the `chef undelete`
subcommand.)

#### Syntax

This subcommand has the following syntax:

```bash
chef delete-policy-group POLICY_GROUP (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef diff

Use the `chef diff` subcommand to display an itemized comparison of two
revisions of a `Policyfile.lock.json` file.

#### Syntax

This subcommand has the following syntax:

```bash
chef diff POLICY_FILE --head | --git POLICY_GROUP | POLICY_GROUP...POLICY_GROUP (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-g GIT_REF`, `--git GIT_REF`

:   Compare the specified git reference against the current revision of
    a `Policyfile.lock.json` file or against another git reference.

`-h`, `--help`

:   Show help for the command.

`--head`

:   A shortcut for `chef diff --git HEAD`. When a git-specific flag is
    not provided, the on-disk `Policyfile.lock.json` file is compared to
    one on the Chef Infra Server or (if a `Policyfile.lock.json` file is
    not present on-disk) two `Policyfile.lock.json` files in the
    specified policy group on the Chef Infra Server are compared.

`--[no-]pager`

:   Use `--pager` to enable paged output for a `Policyfile.lock.json`
    file. Default value: `--pager`.

`-v`, `--version`

:   The Chef Infra Client version.

#### Examples

##### Compare current lock to latest commit on latest branch

```bash
chef diff --git HEAD
```

##### Compare current lock with latest commit on master branch

```bash
chef diff --git master
```

##### Compare current lock to specified revision

```bash
chef diff --git v1.0.0
```

##### Compare lock on master branch to lock on revision

```bash
chef diff --git master...dev
```

##### Compare lock for version with latest commit on master branch

```bash
chef diff --git v1.0.0...master
```

##### Compare current lock with latest lock for policy group

```bash
chef diff staging
```

##### Compare locks for two policy group

```bash
chef diff production...staging
```

### chef export

Use the `chef export` subcommand to create a chef-zero-compatible
chef-repo that contains the cookbooks described by a
`Policyfile.lock.json` file. After a chef-zero-compatible chef-repo is
copied to a node, the policy can be applied locally on that machine by
running `chef-client -z` (local mode).

#### Syntax

This subcommand has the following syntax:

```bash
chef export POLICY_FILE DIRECTORY (options)
```

#### Options

This subcommand has the following options:

`-a`, `--archive`

:   Export an archive as a tarball, instead as a directory. Default
    value: `false`.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-f`, `--force`

:   Remove the contents of the destination directory if that directory
    is not empty. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef generate policyfile

Use the `chef generate policyfile` subcommand to generate a file to be
used with Policyfile.

#### Syntax

This subcommand has the following syntax:

```bash
chef generate policyfile POLICY_NAME (options)
```

#### Options

This subcommand has the following options:

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef generate repo

Use the `chef generate repo` subcommand to create a chef-repo. By
default, the repo is a cookbook repo with options available to support
generating a cookbook that supports Policyfile.

{{< note >}}

This subcommand requires using one (or more) of the options (below) to support Policyfile files.

{{< /note >}}

#### Syntax

This subcommand has the following syntax:

```bash
chef generate repo REPO_NAME (options)
```

#### Options

This subcommand has the following options:

`-h`, `--help`

:   Show help for the command.

`-p`, `--policy-only`

:   Create a repository that does not store cookbook files, only
    Policyfile files.

`-P`, `--policy`

:   Use Policyfile instead of Berkshelf.

`-r`, `--roles`

:   Create directories for `/roles` and `/environments` instead of
    creating directories for Policyfile.

`-v`, `--version`

:   The Chef Infra Client version.

### chef install

Use the `chef install` subcommand to evaluate a Policyfile and find a
compatible set of cookbooks, build a run-list, cache it locally, and
then emit a `Policyfile.lock.json` file that describes the locked policy
set. The `Policyfile.lock.json` file may be used to install the locked
policy set to other machines and may be pushed to a policy group on the
Chef Infra Server to apply that policy to a group of nodes that are
under management by Chef.

#### Syntax

This subcommand has the following syntax:

```bash
chef install POLICY_FILE (options)
```

#### Options

This subcommand has the following options:

`-D`, `--debug`

:   Enable stack traces and other debug output.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

#### Policyfile.lock.json

{{< readfile file="content/reusable/md/policyfile_lock_json.md" >}}

{{< readfile file="content/reusable/md/policyfile_lock_json_example.md" >}}

### chef push

Use the `chef push` subcommand to upload an existing
`Policyfile.lock.json` file to the Chef Infra Server, along with all of
the cookbooks that are contained in the file. The `Policyfile.lock.json`
file will be applied to the specified policy group, which is a set of
nodes that share the same run-list and cookbooks.

#### Syntax

This subcommand has the following syntax:

```bash
chef push POLICY_GROUP POLICY_FILE (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef push-archive

The `chef push-archive` subcommand is used to publish a policy archive
file to the Chef Infra Server. (A policy archive is created using the
`chef export` subcommand.) The policy archive is assigned to the
specified policy group, which is a set of nodes that share the same
run-list and cookbooks.

#### Syntax

This subcommand has the following syntax:

```bash
chef push-archive POLICY_GROUP ARCHIVE_FILE (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

### chef show-policy

Use the `chef show-policy` subcommand to display revisions for every
`Policyfile.rb` file that is on the Chef Infra Server. By default, only
active policy revisions are shown. When both a policy and policy group
are specified, the contents of the active `Policyfile.lock.json` file
for the policy group is returned.

#### Syntax

This subcommand has the following syntax:

```bash
chef show-policy POLICY_NAME POLICY_GROUP (options)
```

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-o`, `--orphans`

:   Show policy revisions that are not currently assigned to any policy
    group.

`--[no-]pager`

:   Use `--pager` to enable paged output for a `Policyfile.lock.json`
    file. Default value: `--pager`.

`-v`, `--version`

:   The Chef Infra Client version.

### chef undelete

Use the `chef undelete` subcommand to recover a deleted policy or policy
group. This command:

- Does not detect conflicts. If a deleted item has been recreated,
    running this command will overwrite it
- Does not include cookbooks that may be referenced by Policyfiles;
    cookbooks that are cleaned after running this command may not be
    fully restorable to their previous state
- Does not store access control data

#### Syntax

This subcommand has the following syntax:

```bash
chef undelete (options)
```

When run with no arguments, returns a list of available operations.

#### Options

This subcommand has the following options:

`-c CONFIG_FILE`, `--config CONFIG_FILE`

:   The path to the knife configuration file.

`-D`, `--debug`

:   Enable stack traces and other debug output.

`-h`, `--help`

:   Show help for the command.

`-i ID`, `--id ID`

:   Undo the delete operation specified by `ID`.

`-l`, `--last`

:   Undo the most recent delete operation.

`--list`

:   Default. Return a list of available operations.

`-v`, `--version`

:   The Chef Infra Client version.

### chef update

Use the `chef update` subcommand to read the `Policyfile.rb` file, and
then apply any changes. This will resolve dependencies and will create a
`Policyfile.lock.json` file. The locked policy will reflect any changes
to the run-list and will pull in any cookbook updates that are
compatible with any version constraints defined in the `Policyfile.rb`
file.

#### Syntax

This subcommand has the following syntax:

```bash
chef update POLICY_FILE (options)
```

#### Options

This subcommand has the following options:

`-a`, `--attributes`

:   Update attributes. Default value: `false`.

`-D`, `--debug`

:   Enable stack traces and other debug output. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.
