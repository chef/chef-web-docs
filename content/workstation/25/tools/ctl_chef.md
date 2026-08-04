+++
title = "chef executable"
draft = false

[menu]
  [menu.workstation_25]
    title = "chef executable"
    identifier = "workstation_25/tools_ctl_chef.md chef executable"
    parent = "workstation_25/tools"
    weight = 10
+++
<!-- markdownlint-disable-file MD024 MD036-->
<!-- vale chef.policyfile = NO -->

The chef executable is a command-line tool that does the following:

- Generates repositories, cookbooks, recipes, attributes, templates, and custom resources.
- Installs gems into the Chef development environment's Ruby installation.
- Helps you manage your [Policyfiles](/client/latest/policy/policyfile/). Please refer the Policyfile commands [section](#policyfile-commands).

{{< note >}}

The default cookbook cache location is `~/.chef-workstation` on macOS and Linux, and `%LOCALAPPDATA%\chef-workstation` on Windows.

To use a different cache location, set the `CHEF_WORKSTATION_HOME` environment variable:

- **macOS and Linux**: Add `CHEF_WORKSTATION_HOME="~/.workstation"` (or your preferred path) to your `.bashrc` or `.zshrc` file.
- **Windows**: Use the [`setx` command](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/setx) or set the variable through the [Advanced tab in System Properties](https://support.microsoft.com/en-us/topic/how-to-manage-environment-variables-in-windows-xp-5bf6725b-655e-151c-0b55-9a8c9c7f747d).

{{< /note >}}

## chef capture

Use the `chef capture` subcommand to capture a node's state as a local [chef-repo](/client/latest/cookbooks/cookbook_repo/). Use the generated repository if you need to converge a node locally.

### Syntax

This subcommand has the following syntax:

```bash
chef capture NODE-NAME [options]
```

### Options

`-c`, `--credentials`

: Credentials file (default $HOME/.chef/credentials).

`-d`, `--with-data-bags`

: Download all data bags as part of node capture.

`-h`, `--help`

: Show help for the command.

`-k`, `--client-key`

: Chef Infra Server API client key.

`-n`, `--client-name`

: Chef Infra Server API client name.

`-o`, `--ssl-no-verify`

: Don't verify SSL when connecting to Chef Infra Server (default: verify).

`-p`, `--profile`

: Profile to use from credentials file (default "default").

`-s`, `--chef-server-url`

: Chef Infra Server URL.

### Examples

**Capture a node**

To capture a node in a local repository, run a command similar to:

```bash
chef capture test-server
```

This will return something similar to:

```bash
- Setting up local repository
 - Capturing node object 'test-server'
 - Capturing policy data...
 - Capturing cookbook artifacts...
 - Writing kitchen configuration...

Repository has been created in './node-test-server-repo'.

Next, locate version-controlled copies of the cookbooks. This is
important so that you can track changes to the cookbooks as you
edit them. You may have one or more existing paths where you have
checked out cookbooks. If not, now is a good time to open a
separate terminal and clone or check out the cookbooks.

If all cookbooks aren't available in the same base location,
you will have a chance to provide additional locations.

Press Enter to Continue:

You're ready to begin!

Start with 'cd ./node-test-server-repo; kitchen converge'.

As you identify issues, you can modify cookbooks in their
original checkout locations or in the repository's cookbooks
directory and they will be picked up on subsequent runs
of 'kitchen converge'.

```

See the [Upgrade Lab](/workstation/25/tools/upgrade_lab/#create-an-upgrade-environment-with-chef-capture) documentation for additional
information on upgrading Chef Infra Client.

## chef env

Use the `chef env` subcommand to configure the environment for Chef
Workstation.

### Syntax

This subcommand has the following syntax:

```bash
chef env
```

### Options

This command doesn't have any specific options.

### Examples

None.

## chef exec

Use the `chef exec` subcommand to run arbitrary shell commands with the
`PATH` environment variable and the `GEM_HOME` and `GEM_PATH` Ruby
environment variables pointed at Chef Workstation.

### Syntax

This subcommand has the following syntax:

```bash
chef exec SYSTEM_COMMAND (options)
```

### Options

This subcommand has the following options:

`-h`, `--help`

: Show help for the command.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

None.

## chef gem

The `chef gem` subcommand is a wrapper around the `gem` command in
RubyGems and is used by Chef to install RubyGems into Chef Workstation
development environment. All knife plugins, drivers for Kitchen, and
other Ruby applications that aren't packaged within Chef Workstation
will be installed to the `.Chef Workstation` path in the home directory:
`~/.Chef Workstation/gem/ruby/version#/bin` (where `version#` is the
version of Ruby that's packaged within Chef Workstation).

### Syntax

This subcommand has the following syntax:

```bash
chef gem GEM_COMMAND GEM_OPTIONS (options)
```

### Options

This subcommand has the following options:

`-h`, `--help`

: Show help for the command.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

**Show an existing gem in Chef Workstation**

To show a gem, run a command similar to:

```bash
chef gem list cookstyle
```

to return something similar to:

```bash
*** LOCAL GEMS ***

cookstyle (5.20.0)
```

**List all local gems**

To list the installed gems on your development environment, use
the `list` command without any arguments:

```bash
chef gem list
```

**Search for local gems**

The `list` command can also be used to search for locally installed
gems. For example, to list the gems with `knife` in their title:

```bash
chef gem list knife
```

which returns the following output:

```bash
*** LOCAL GEMS ***

knife-opc (0.3.2)
knife-windows (1.9.0)
```

**Search remote gems**

Use the `search` command to search for remote gems available for
installation:

```bash
chef gem search kitchen
```

to return something similar to:

```bash
*** REMOTE GEMS ***

chefkitchen_cli (0.0.1)
gst-kitchen (0.9.0)
guard-kitchen (0.0.2)
jackal-kitchen (0.1.2)
jackal-kitchen-slack (0.1.2)
kitchen (0.0.3)
```

**Install a gem**

To install a gem, run a command similar to:

```bash
chef gem install knife-config
```

to return something similar to:

```bash
Successfully installed knife-config-1.1.0
1 gem installed
```

**Uninstall a gem**

To uninstall a gem from Chef Workstation environment:

```bash
chef gem uninstall knife-config
```

to return something similar to:

```bash
Successfully uninstalled knife-config-1.1.0
```

**View the contents of a gem**

To view the contents of a gem, run a command similar to:

```bash
chef gem content knife-config
```

to return something similar to:

```bash
/Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/LICENSE
/Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/README.md
/Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/lib/chef/knife/config.rb
/Users/user/.chefdk/gem/ruby/2.1.0/gems/knife-config-1.1.0/lib/knife-config.rb
```

## chef generate attribute

Use the `chef generate attribute` subcommand to generate an attribute
file in the `/attributes` directory.

### Syntax

This subcommand has the following syntax:

```bash
chef generate attribute COOKBOOK_PATH NAME (options)
```

### Options

This subcommand has the following options:

`-g GENERATOR_COOKBOOK_PATH`, `--generator-cookbook GENERATOR_COOKBOOK_PATH`

: The path at which a cookbook named `code_generator` is located. This cookbook is used by the `chef generate` subcommands to generate cookbooks, cookbook files, templates, attribute files, and more. Default value: `lib/chef-dk/skeletons`, under which is the default `code_generator` cookbook that's included as part of Chef Workstation.

`-h`, `--help`

: Show help for the command.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

**Create an attribute**

To generate an attribute, run a command similar to:

```bash
chef generate attribute /path/to/cookbook FOO
```

will return something similar to:

```bash
Recipe: code_generator::attribute
  * directory[/Users/grantmc/chef-repo/cookbooks/chef-repo/attributes] action create
    - create new directory /Users/grantmc/chef-repo/cookbooks/chef-repo/attributes

  * template[/Users/grantmc/chef-repo/cookbooks/chef-repo/attributes/FOO.rb] action create
    - create new file /Users/grantmc/chef-repo/cookbooks/chef-repo/attributes/FOO.rb
```

## chef generate cookbook

Use the `chef generate cookbook` subcommand to generate a cookbook.

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/ruby_style_patterns_hyphens.md" >}}

{{< /note >}}

### Syntax

This subcommand has the following syntax:

```bash
chef generate cookbook COOKBOOK_PATH/COOKBOOK_NAME (options)
```

### Options

This subcommand has the following options:

`-g GENERATOR_COOKBOOK_PATH`, `--generator-cookbook GENERATOR_COOKBOOK_PATH`

: The path at which a cookbook named `code_generator` is located. This cookbook is used by the `chef generate` subcommands to generate cookbooks, cookbook files, templates, attribute files, and more. Default value: `lib/chef-dk/skeletons`, under which is the default `code_generator` cookbook that's included as part of Chef Workstation.

`-b`, `--berks`

: Create a Berksfile in the cookbook. Default: disabled. Optional. Use to create a berksfile by overriding default creation of a Policyfile.

`-C COPYRIGHT`, `--copyright COPYRIGHT`

: Specify the copyright holder for copyright notices in generated files, as well as the `maintainer` in `metadata.rb`. Default value: `The Authors`

`-m EMAIL`, `--email EMAIL`

: Specify the `maintainer_email` for `metadata.rb`. Default value: `you@example.com`.

`-a KEY=VALUE`, `--generator-arg KEY=VALUE`

: Sets a property named `KEY` to the given `VALUE` on the generator context object in the generator cookbook. This allows custom generator cookbooks to accept optional user input on the command line.

`-I LICENSE`, `--license LICENSE`

: Sets the license. Valid values are `all_rights`, `apache2`, `mit`, `gplv2`, or `gplv3`. Default value: `all_rights`.

`-P`, `--policy`

: Create a Policyfile in the cookbook instead of a Berksfile. Default: enabled.

`-h`, `--help`

: Show help for the command.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

**Create a cookbook**

To generate a cookbook, run a command similar to:

```bash
chef generate cookbook chefdocs
```

will return something similar to:

```bash
Recipe: code_generator::cookbook
  * directory[/Users/grantmc/chefdocs] action create
    - create new directory /Users/grantmc/chefdocs

  * template[/Users/grantmc/chefdocs/metadata.rb] action create
    - create new file /Users/grantmc/chefdocs/metadata.rb

  * template[/Users/grantmc/chefdocs/README.md] action create
    - create new file /Users/grantmc/chefdocs/README.md

  * cookbook_file[/Users/grantmc/chefdocs/chefignore] action create
    - create new file /Users/grantmc/chefdocs/chefignore

  * cookbook_file[/Users/grantmc/chefdocs/Berksfile] action create
    - create new file /Users/grantmc/chefdocs/Berksfile

  * template[/Users/grantmc/chefdocs/kitchen.yml] action create
    - create new file /Users/grantmc/chefdocs/kitchen.yml

  * directory[/Users/grantmc/chefdocs/recipes] action create
    - create new directory /Users/grantmc/chefdocs/recipes

  * template[/Users/grantmc/chefdocs/recipes/default.rb] action create
    - create new file /Users/grantmc/chefdocs/recipes/default.rb

  * execute[initialize-git] action run
    - execute git init .

  * cookbook_file[/Users/grantmc/chefdocs/.gitignore] action create
    - create new file /Users/grantmc/chefdocs/.gitignore
```

and which creates a directory structure similar to:

```txt
    /chefdocs
      /.git
      .gitignore
      kitchen.yml
      chefignore
      metadata.rb
      README.md
      /recipes
        default.rb
```

**Create a cookbook using a custom skeleton cookbook**

If a custom skeleton cookbook is located on a macOS desktop (and in this
example, the `chef_generator` cookbook is simply a copy of the same
cookbook that ships in Chef Workstation), the following command will use
the skeleton cookbook at the custom location to generate a cookbook into
the repository from which the `chef` command is run:

```bash
chef generate cookbook --generator-cookbook ~/Desktop testcookbook
```

{{< note >}}

The `code_generator` cookbook itself isn't specified as part of the
path.

{{< /note >}}

will return something similar to:

```bash
Compiling Cookbooks...
Recipe: code_generator::cookbook
  * directory[/Users/grantmc/Desktop/chef-repo/test-cookbook] action create
    - create new directory /Users/grantmc/Desktop/chef-repo/test-cookbook

  * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/metadata.rb] action create
    - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/metadata.rb

  * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/README.md] action create
    - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/README.md

  * cookbook_file[/Users/grantmc/Desktop/chef-repo/test-cookbook/chefignore] action create
    - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/chefignore

  * cookbook_file[/Users/grantmc/Desktop/chef-repo/test-cookbook/Berksfile] action create
    - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/Berksfile

  * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/kitchen.yml] action create
    - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/kitchen.yml

  * directory[/Users/grantmc/Desktop/chef-repo/test-cookbook/recipes] action create
    - create new directory /Users/grantmc/Desktop/chef-repo/test-cookbook/recipes

  * template[/Users/grantmc/Desktop/chef-repo/test-cookbook/recipes/default.rb] action create
    - create new file /Users/grantmc/Desktop/chef-repo/test-cookbook/recipes/default.rb
```

## chef generate file

Use the `chef generate file` subcommand to generate a file in the
`/files` directory.

### Syntax

This subcommand has the following syntax:

```bash
chef generate file COOKBOOK_PATH NAME (options)
```

### Options

This subcommand has the following options:

`-g GENERATOR_COOKBOOK_PATH`, `--generator-cookbook GENERATOR_COOKBOOK_PATH`

: The path at which a cookbook named `code_generator` is located. This cookbook is used by the `chef generate` subcommands to generate cookbooks, cookbook files, templates, attribute files, and more. Default value: `lib/chef-dk/skeletons`, under which is the default `code_generator` cookbook that's included as part of Chef Workstation.

`-h`, `--help`

: Show help for the command.

`-s SOURCE_FILE`, `--source SOURCE_FILE`

: Copy the contents from a source file.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

None.

## chef generate resource

Use the `chef generate resource` subcommand to generate a custom
resource in the `/resources` directory.

{{< note >}}

{{< readfile file="content/workstation/25/reusable/md/ruby_style_patterns_hyphens.md" >}}

{{< /note >}}

### Syntax

This subcommand has the following syntax:

```bash
chef generate resource COOKBOOK_PATH NAME (options)
```

### Options

This subcommand has the following options:

`-g GENERATOR_COOKBOOK_PATH`, `--generator-cookbook GENERATOR_COOKBOOK_PATH`

: The path at which a cookbook named `code_generator` is located. This cookbook is used by the `chef generate` subcommands to generate cookbooks, cookbook files, templates, attribute files, and more. Default value: `lib/chef-dk/skeletons`, under which is the default `code_generator` cookbook that's included as part of Chef Workstation.

`-h`, `--help`

: Show help for the command.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

None.

## chef generate recipe

Use the `chef generate recipe` subcommand to generate a recipe in the
`/recipes` directory.

### Syntax

This subcommand has the following syntax:

```bash
chef generate recipe COOKBOOK_PATH NAME (options)
```

### Options

This subcommand has the following options:

`-g GENERATOR_COOKBOOK_PATH`, `--generator-cookbook GENERATOR_COOKBOOK_PATH`

: The path at which a cookbook named `code_generator` is located. This cookbook is used by the `chef generate` subcommands to generate cookbooks, cookbook files, templates, attribute files, and more. Default value: `lib/chef-dk/skeletons`, under which is the default `code_generator` cookbook that's included as part of Chef Workstation.

`-h`, `--help`

: Show help for the command.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

None.

## chef generate repo

Use the `chef generate repo` subcommand to create a chef-repo. By
default, the repo is a cookbook repo with options available to support
generating a cookbook that supports Policyfile.

### Syntax

This subcommand has the following syntax:

```bash
chef generate repo REPO_NAME (options)
```

### Options

This subcommand has the following options:

`-h`, `--help`

:   Show help for the command.

`-p`, `--policy-only`

:   Create a repository that doesn't store cookbook files, only
    Policyfile files.

`-P`, `--policy`

:   Use Policyfile instead of Berkshelf.

`-r`, `--roles`

:   Create directories for `/roles` and `/environments` instead of
    creating directories for Policyfile.

`-v`, `--version`

:   The Chef Infra Client version.

### Examples

None.

## chef generate template

Use the `chef generate template` subcommand to generate a template in
the `/templates` directory.

### Syntax

This subcommand has the following syntax:

```bash
chef generate template COOKBOOK_PATH NAME (options)
```

### Options

This subcommand has the following options:

`-g GENERATOR_COOKBOOK_PATH`, `--generator-cookbook GENERATOR_COOKBOOK_PATH`

: The path at which a cookbook named `code_generator` is located. This cookbook is used by the `chef generate` subcommands to generate cookbooks, cookbook files, templates, attribute files, and more. Default value: `lib/chef-dk/skeletons`, under which is the default `code_generator` cookbook that's included as part of Chef Workstation.

`-h`, `--help`

: Show help for the command.

`-s SOURCE_FILE`, `--source SOURCE_FILE`

: Copy the contents from a source file.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

None.

## chef generate profile

Use the `chef generate profile` subcommand to generate a [profile](/inspec/latest/profiles/) for Chef Infra Client's Compliance Phase execution.

### Syntax

This subcommand has the following syntax:

```bash
chef generate profile [path/to/cookbook] NAME
```

### Options

This subcommand has the following options:

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Workstation version.

### Examples

None.

## chef generate input

Use the `chef generate input` subcommand to generate an [input](/inspec/latest/inputs/) file for Chef Infra Client's Compliance Phase execution.

### Syntax

This subcommand has the following syntax:

```bash
chef generate input [path/to/cookbook] NAME
```

### Options

Use the `chef export` subcommand to create a chef-zero-compatible
chef-repo that contains the cookbooks described by a
`Policyfile.lock.json` file. After a chef-zero-compatible chef-repo is
copied to a node, the policy can be applied locally on that machine by
running `chef-client -z` (local mode).

### Examples

None.

## chef generate waiver

Use the `chef generate waiver` subcommand to generate a [waiver](/inspec/latest/waivers/) file for Chef Infra Client's Compliance Phase execution.

### Syntax

This subcommand has the following syntax:

```bash
chef generate waiver [path/to/cookbook] NAME
```

### Options

This subcommand has the following options:

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Workstation version.

### Examples

None.

## chef report cookbooks

Use the `chef report cookbooks` subcommand to generate a cookbook-oriented report for your Chef Infra environment.
This report provides details about upgrade compatibility errors and node cookbook usage.

### Syntax

This subcommand has the following syntax:

```bash
chef report cookbooks [options]
```

### Options

This subcommand has the following options:

`-a`, `--anonymize`

: Replace cookbook and node names with hash values to protect the sensitive information.

`-c`, `--credentials string`

: Credentials file (default $HOME/.chef/credentials).

`-f`, `--format`

: Output format: txt is human readable, csv is machine readable (default "txt").

`-F`, `--node-filter`

: Search filter to apply to nodes.

`-h`, `--help`

: Show help for the command.

`-k`, `--client-key`

: Chef Infra Server API client key.

`-n`, `--client-name`

: Chef Infra Server API client name.

`-o`, `--ssl-no-verify`

: Don't verify SSL when connecting to Chef Infra Server (default: verify).

`-p`, `--profile`

: Profile to use from credentials file (default "default").

`-s`, `--chef-server-url`

: Chef Infra Server URL.

`-u`, `--only-unused`

: Generate a report that only includes cookbooks that aren't included in any node's runlist.

`-V`, `--verify-upgrade`

: Verify the upgrade compatibility of every cookbook.

`-w`, `--workers`

: Maximum number of parallel workers at once (default 50).

### Examples

**Generate a report**

To generate a cookbook oriented report, run a command similar to:

```bash
chef report cookbooks
```

will return something similar to:

```bash
Finding available cookbooks... (5 found)
Analyzing cookbooks...
5 / 5 [----------------------------------------------------------------------------------------------------------------] 100.00% 13 p/s

-- REPORT SUMMARY --

  Cookbook   Version   Policy Group   Policy   Nodes Affected
-----------+---------+--------------+--------+-----------------
  apt        2.7.0                             2
  Go         0.1.0                             3
  java       0.3.0                             4
  java                 Production     K8s      1
  K8s                  Production     K8s      1


Cookbooks report saved to .chef-workstation/reports/cookbooks-20200722120938.txt
```

More details of this summary report can be viewed in the text file, the location for which is given at the end of the summary.

See the [Upgrade Lab](/workstation/25/tools/upgrade_lab/#chef-report-cookbooks) documentation for additional
information on upgrading Chef Infra Client.

## chef report nodes

Use the `chef report nodes` subcommand to generate a nodes-oriented report for your chef environment. This report provides details about nodes, applied policies and the cookbooks used during the most recent Chef Infra Client run.

### Syntax

This subcommand has the following syntax:

```bash
chef report nodes [options]
```

### Options

This subcommand has the following options:

`-a`, `--anonymize`

: Replace cookbook and node names with hash values to protect sensitive information.

`-c`, `--credentials string`

: Credentials file (default $HOME/.chef/credentials).

`-f`, `--format`

: Output format: txt is human readable, csv is machine readable (default "txt").

`-F`, `--node-filter`

: Search filter to apply to nodes.

`-h`, `--help`

: Show help for the command.

`-k`, `--client-key`

: Chef Infra Server API client key.

`-n`, `--client-name`

: Chef Infra Server API client name.

`-o`, `--ssl-no-verify`

: Don't verify SSL when connecting to Chef Infra Server (default: verify).

`-p`, `--profile`

: Profile to use from credentials file (default "default").

`-s`, `--chef-server-url`

: Chef Infra Server URL.

### Examples

**Generate a report**

To generate a nodes oriented report, run a command similar to:

```bash
chef report nodes
```

will return something similar to:

```bash
Analyzing nodes...

-- REPORT SUMMARY --

      Node Name        Chef Version   Operating System   Number Cookbooks
---------------------+--------------+------------------+-------------------
  dev-server-backend   16.1.16        redhat v8.2                       3
  dev-server-web       16.1.16        redhat v8.2                       1
  production-server    16.1.16        redhat v8.2                       2
  staging-server       16.1.16        redhat v8.2                       4
  test-server          16.1.16        redhat v8.2                       3

Nodes report saved to .chef-workstation/reports/nodes-20200722130502.txt

```

More details of this summary report can be viewed in the text file, the location for which is given at the end of the summary.

[Upgrade Lab](/workstation/25/tools/upgrade_lab) provides further details on how this command can be used in Chef Infra Client upgrade process.

## chef shell-init

Use the `chef shell-init` subcommand to set the Ruby included in Chef
Workstation as the system Ruby. Chef Workstation is designed to allow
the isolation of applications used by Chef Workstation from other Ruby
development tools that may be present on the workstation. This supports
Bash, fish, Windows PowerShell (posh), and zsh.

### Syntax

This subcommand has the following syntax:

```bash
chef shell-init SHELL_NAME (options)
```

### Options

This subcommand has the following options:

`-h`, `--help`

: Show help for the command.

`-v`, `--version`

: The Chef Infra Client version.

### Examples

**Set PowerShell**

You can use the `chef shell-init` command with Windows PowerShell to add
the appropriate variables to your environment.

To try it in your current session:

```bash
chef shell-init powershell | Invoke-Expression
```

To enable it permanently:

```bash
"chef shell-init powershell | Invoke-Expression" >> $PROFILE
```

**Set the execution policy on new machines**

On new Windows machines, PowerShell scripts won't work until an
administrator runs the following command:

```bash
Set-ExecutionPolicy RemoteSigned
```

**Create a \$PROFILE on new machines**

On new Windows machines, commands can't be appended to `$PROFILE` if
the folder doesn't exist, or if there is a new user profile. This will
result in an error similar to the following:

```bash
PS C:\Users\Stuart> "chef shell-init powershell | Invoke-Expression" >> $PROFILE
out-file : Could not find a part of the path
'C:\Users\Stuart\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.
At line:1 char:1
+ "chef shell-init powershell | Invoke-Expression" >> $PROFILE
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OpenError: (:) [Out-File], DirectoryNotFoundException
    + FullyQualifiedErrorId : FileOpenFailure,Microsoft.PowerShell.Commands.OutFileCommand
```

In this situation, run the following `chef shell-init` command instead:

```bash
if(Test-Path $PROFILE){ chef shell-init powershell | Add-Content $PROFILE } else { New-Item -Force -ItemType File $PROFILE; chef shell-init powershell | Add-Content $PROFILE }
```

## Policyfile Commands

The following commands are built into the `chef` executable and support
the use of Policyfile files.

### chef clean-policy-cookbooks

Use the `chef clean-policy-cookbooks` subcommand to delete cookbooks
that aren't used by Policyfile files. Cookbooks are considered unused
when they aren't referenced by any policy revisions on the Chef Infra
Server.

{{< note >}}

Cookbooks that are referenced by orphaned policy revisions aren't
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

#### Examples

None.

### chef clean-policy-revisions

Use the `chef clean-policy-revisions` subcommand to delete orphaned
policy revisions to Policyfile files from Chef Infra Server. An
orphaned policy revision isn't associated to any policy group and
therefore isn't in active use by any node. Use
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

#### Examples

None.

### chef delete-policy

Use the `chef delete-policy` subcommand to delete all revisions of the
named policy that exist on Chef Infra Server. (The state of the
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

#### Examples

None.

### chef delete-policy-group

Use the `chef delete-policy-group` subcommand to delete the named policy
group from Chef Infra Server. Any policy revision associated with
that policy group isn't deleted. (The state of the policy group is
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

#### Examples

None.

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
    one on Chef Infra Server or (if a `Policyfile.lock.json` file is
    not present on-disk) two `Policyfile.lock.json` files in the
    specified policy group on Chef Infra Server are compared.

`--[no-]pager`

:   Use `--pager` to enable paged output for a `Policyfile.lock.json`
    file. Default value: `--pager`.

`-v`, `--version`

:   The Chef Infra Client version.

#### Examples

**Compare current lock to latest commit on latest branch**

```bash
chef diff --git HEAD
```

**Compare current lock with latest commit on main branch**

```bash
chef diff --git main
```

**Compare current lock to specified revision**

```bash
chef diff --git v1.0.0
```

**Compare lock on main branch to lock on revision**

```bash
chef diff --git main...dev
```

**Compare lock for version with latest commit on main branch**

```bash
chef diff --git v1.0.0...main
```

**Compare current lock with latest lock for policy group**

```bash
chef diff staging
```

**Compare locks for two policy groups**

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
    isn't empty. Default value: `false`.

`-h`, `--help`

:   Show help for the command.

`-v`, `--version`

:   The Chef Infra Client version.

#### Examples

None.

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

#### Examples

None.

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

When the `chef install` command is run, Chef Workstation caches any
necessary cookbooks and emits a `Policyfile.lock.json` file that
describes:

- The versions of cookbooks in use
- A hash of cookbook content
- The source for all cookbooks
- Attributes included with the Policyfile

A `Policyfile.lock.json` file is associated with a specific policy
group, which means it's associated with one (or more) nodes that use the same
revision of a given policy.

A `Policyfile.lock.json` file is similar to:

```json
{
  "revision_id": "288ed244f8db8bff3caf58147e840bbe079f76e0",
  "name": "jenkins",
  "run_list": [
    "recipe[java::default]",
    "recipe[jenkins::main]",
    "recipe[policyfile_demo::default]"
  ],
  "cookbook_locks": {
    "policyfile_demo": {
      "version": "0.1.0",
      "identifier": "f04cc40faf628253fe7d9566d66a1733fb1afbe9",
      "dotted_decimal_identifier": "67638399371010690.23642238397896298.25512023620585",
      "source": "cookbooks/policyfile_demo",
      "cache_key": null,
      "scm_info": null,
      "source_options": {
        "path": "cookbooks/policyfile_demo"
      }
    },
  "java": {
    "version": "1.24.0",
    "identifier": "4c24ae46a6633e424925c24e683e0f43786236a3",
    "dotted_decimal_identifier": "21432429158228798.18657774985439294.16782456927907",
    "cache_key": "java-1.24.0-supermarket.chef.io",
    "origin": "https://supermarket.chef.io/api/v1/cookbooks/java/versions/1.24.0/download",
    "source_options": {
      "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/java/versions/1.24.0/download",
      "version": "1.24.0"
    }
  "default_attributes": {
    "audit": {
      "reporter": [
        "chef-server-automate",
        "cli"
      ]
    }
  },
  "override_attributes": {

  },
```

#### Examples

None.

### chef push

Use the `chef push` subcommand to upload an existing
`Policyfile.lock.json` file to Chef Infra Server, along with all of
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

#### Examples

None.

### chef push-archive

The `chef push-archive` subcommand is used to publish a policy archive
file to Chef Infra Server. (A policy archive is created using the
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

#### Examples

None.

### chef show-policy

Use the `chef show-policy` subcommand to display revisions for every
`Policyfile.rb` file that's on Chef Infra Server. By default, only
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

:   Show policy revisions that aren't currently assigned to any policy
    group.

`--[no-]pager`

:   Use `--pager` to enable paged output for a `Policyfile.lock.json`
    file. Default value: `--pager`.

`-v`, `--version`

:   The Chef Infra Client version.

#### Examples

None.

### chef undelete

Use the `chef undelete` subcommand to recover a deleted policy or policy
group. This command:

- doesn't detect conflicts. If a deleted item has been recreated,
    running this command will overwrite it
- doesn't include cookbooks that may be referenced by Policyfiles;
    cookbooks that are cleaned after running this command may not be
    fully restorable to their previous state
- doesn't store access control data

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

#### Examples

None.

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

#### Examples

None.
