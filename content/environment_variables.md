+++
title = "Unix Environment Variables"
description = "DESCRIPTION"
draft = false

aliases = "/environment_variables.html"

[menu]
  [menu.docs]
    title = "Environment Variables"
    identifier = "chef_infra/getting_started/environment_variables.html Environment Variables"
    parent = "chef_infra/getting_started"
    weight = 80
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/environment_variables.rst)

{{% environment_variables_summary %}}

Child Processes and Inheritance
===============================

Child processes inherit a copy of their parent's environment. In Bash
(and other shells) the environment is accessible via shell variables.
Shell variables can be added to the environment that is inherited by
children processes using the export keyword.

Consider the following example:

``` bash
% WOO="woo" #Set a shell variable
% echo $WOO
woo
% bash #Start a new process, a child of our first shell
% echo $WOO # Shell variable is empty because we didn't export it

% exit # Return to original shell
exit
% export WOO # Export variable
% bash
% echo $WOO #Shell variable now available in children.
woo
% exit
```

As mentioned, the child process gets a copy of its parent's environment.
This means that any changes made to that environment do not affect the
parent process. For example:

``` bash
% WOO="woo" #Set a shell variable
% echo $WOO
woo
% bash #Start a new process, a child of our first shell
% export WOO="hello" # Change and export the shell variable
% exit # Return to original shell
exit
% echo $WOO #The parent's value remains unchanged.
woo
% exit
```

The principles mentioned above (a child process receives a copy of its
parent's environment and cannot affect their parent's environment) apply
in Ruby just as they do in Bash.

In Ruby, the current environment can be altered via the `ENV` variable.
Any changes made to the environment will also be available to child
process started by Chef Infra Client. For example, consider the
following recipe:

``` ruby
ENV['FOO'] = 'bar'
bash 'env_test0' do
  code <<-EOF
  echo $FOO
EOF
end
```

When run, the **bash** resource will correctly `echo 'bar'` to its
standard output.

However, just as in Bash, changes made in child processes have no affect
on the parent, and thus no affect on subsequent child processes:

``` ruby
bash 'env_test1' do
  code <<-EOF
  export BAZ='bar'
EOF
end

bash 'env_test2' do
  code <<-EOF
  echo $BAZ
EOF
end
```

When run, the second **bash** resource will not cause anything to be
echoed to standard out as `BAZ` is not part of its environment.

Managing Environments
=====================

Services and other processes often look to environment variables for
important information needed at run time. There are a number of ways to
ensure that processes have access to the environment variables they need
to run properly.

Using an Init Script
--------------------

Ideally, a service's init script would contain everything needed to
properly start that service, including the necessary environment.
Ensuring that the init script itself contains the necessary environment
changes ensures that the service will start properly whenever it is
being started using its init script, whether that be from the
**service** resource or directly from the shell. In classic System V
init scripts, the environment can be altered just as it can be altered
in any other shell script, by using a shell variable marked with the
export keyword:

``` ruby
export IMPORTANT_VAR='value'
```

### Upstart Services

For services started using Upstart (the System V-compatible init system
used by recent versions of Ubuntu and other distributions), their
environment can be altered using `env`:

``` ruby
env IMPORTANT_VAR='value'
```

### Systemd Services

For services started using systemd (the System V-compatible init system
by the recent versions of Fedora and other distributions), their
environment can be altered using the `Environment` or `EnvironmentFile`
options:

``` ruby
Environment="IMPORTANT_VAR='value'"
```

If the init script provided by the package does not include the
necessary environment variables, you can manage your altered init script
using the **template** resource.

Using ENV
---------

Another method is to use the Ruby predefined `ENV` variable to set the
environment variable. This ensures that any child processes (including
the service that a resource may be starting) have this value in their
environment. While not technically a Hash, `ENV` can be manipulated as
if it were. For example:

``` ruby
ENV['IMPORTANT_VAR'] = 'value'

# Some service that requires IMPORTANT VAR
service 'example_service' do
  action :start
end
```

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

Changes made to `ENV` only effect the environment of the Chef Infra
Client process and child processes. Altering the environment in this way
will often ensure that Chef Infra Client can start a service properly,
but will not ensure that a service will start properly when started
using other methods.

</div>

Using Resource Attributes
-------------------------

{{% environment_variables_access_resource_attributes %}}

Other Issues
============

**My init script works fine when I'm logged in but not over ssh or when
launched from Chef Infra Client running as daemon!**

Shells commonly alter their environment at startup by loading various
initialization scripts. The files used for initialization vary based on
whether the shell is started as an interactive or non-interactive shell
and whether it is is started as a login or non-login shell. When a user
first logs in, most often an interactive login shell is started. When a
command is run via SSH, this is often a non-interactive shell. This can
mean that the process in question is receiving different environments.
Ensure that a service or process is being started in a way that ensures
its environment has the necessary key-value pairs.

**I want to change the environment for every process!**

This isn't possible on unix-like operating systems. In general, the best
course of action is to ensure that the startup routine for a given
process ensures that any necessary environment variables are set.

You can alter the system-wide initialization scripts for the common
shells, which will impact many new processes started on the system.
These scripts can be managed using the **template** resource; however,
there are a few caveats:

-   The environments of existing processes will be unaffected
-   Shells look to different startup files when started with different
    options. See the shell-specific documentation for the definitive
    list of files that need to be altered and whether it is possible to
    alter the environment for every possible invocation of the shell
-   When a shell's initialization file is first changed, it will have no
    affect on your current shell or process since its environment has
    already been initialized
-   From a shell, the source command can be used to reload a given
    initialization file; however, since child processes do not affect
    their parent's environment, using a script or execute resource to
    run source from inside a recipe will have no effect on the Chef
    Infra Client environment.
