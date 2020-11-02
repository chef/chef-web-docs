+++
title = "Application Lifecycle Hooks"
description = "Control service runtime actions with application lifecycle hooks"

[menu]
  [menu.habitat]
    title = "Application Lifecycle Hooks"
    identifier = "habitat/reference/application-lifecycle-hooks Plan Lifecycle Hooks"
    parent = "habitat/reference"

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/application_lifecycle_hooks.md)

Each plan can specify lifecycle event handlers, or hooks, to perform certain actions during a service's runtime. Each hook is a script with a [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) defined at the top to specify the interpreter to be used. On Windows, Powershell Core is the only interpreter ever used.

To define a hook, simply create a file of the same name in `/my_plan_name/hooks/`, for example, `/postgresql/hooks/health-check`.

Optionally you may add an extension to the hook file. For example, you might create `/postgresql/hooks/health-check.sh` which can be useful in some editors to automatically take advantage of syntax highlighting. Note that having two files for the same hook but with different extensions is not permitted. For example you might create a `run.sh` and `run.ps1` to support both Linux and Windows packages. If you would like to create different hooks for different platforms, you must use [target directories]({{< relref "plan_writing#writing-a-plan-for-multiple-platform-targets" >}}).

{{< warning >}}
You cannot block the thread in a hook unless it is in the `run` hook. Never call `hab` or `sleep` in a hook that is not the `run` hook.
{{< /warning >}}

## Runtime Settings

[Chef Habitat's runtime configuration settings]({{< relref "service_templates" >}}) can be used in any of the plan hooks and also in any templatized configuration file for your application or service.

{{< note >}}
In Chef Habitat 0.68.0 and less, some hooks used `_` in their names. This is now deprecated; if you used them, please use `-` instead.
{{< /note >}}

### file-updated

File location: `<plan>/hooks/file-updated`. This hook is run whenever a configuration file that is not related to a user or about the state of the service instances is updated.

### health-check

**File location**: `<plan>/hooks/health-check`. **Default**: 30 seconds

This hook repeats at a configured interval. There are two exceptions to the interval used between `health-check` runs:

- If the `health-check` hook exits with a non-`ok` status the next `health-check` will run after the default `health-check` interval (thirty seconds). This is only done when the configured interval is greater than the default interval.
- If the `health-check` hook returns an `ok` status for the first time, then the next `health-check` will run after a randomly chosen delay between 0 and the configured `health-check` interval. This introduces a splay - a degree of difference - in the timing between the first and second `health-check` runs. All following health-check hooks run at the configured interval. The splay prevents more than one health-check hook from starting at the same time by giving each of them a unique starting point.

The `health-check` script must return a valid exit code from the list below.

- **0**- ok
- **1**- warning
- **2**- critical
- **3**- unknown
- any other code - failed health check with additional output taken from `health-check` stdout.

A `health-check` hook can use the following as a template:

```bash hooks/health-check
#!/bin/sh

# define default return code as 0
rc=0
program_that_returns_a_status
case $? in
  0)
    rc=1 ;;
  3)
    rc=0 ;;
  4)
    rc=2 ;;
  *)
    rc=3 ;;
esac

exit $rc
```

### init

File location: `<plan>/hooks/init`. This hook is run when a Chef Habitat topology starts.

### install

File location: `<plan>/hooks/install`. This hook is run when a package is initially installed.

An `install` hook may be triggered by `hab pkg install` or by a Supervisor loading a new package. Note that any package can define an `install` hook and it is not limited to packages that are loaded as services into a Supervisor. A package may have dependencies defined in `pkg_deps` or `pkg_build_deps` that define their own `install` hook. An `install` hook defined in an dependant package that has not yet been installed will run when the parent package is installed. However `install` hooks in a runtime dependency (`pkg_deps`) will not run when loaded via a package `build` inside of a Studio.

The exit code returned from an `install` hook will be "remembered". If a previously installed package is either installed again via `hab pkg install` or loaded into a Supervisor, its `install` hook will be rerun if it previously failed (exited with a non `0` result) or has not been previously run (perhaps because `--ignore-install-hook` was passed to `hab pkg install`).

An `install` hook, unlike other hooks, will not have access to any census data exposed via binds or the `svc` namespace. Also, configuration in `svc_config_path` is not accessible to an `install` hook. If an `install` hook needs to utilize templated configuration files, templates located in the `svc_config_install_path` may be referenced. This location will contain rendered templates in a package's `config_install` folder. Finally, any configuration updates made during a service's runtime that would alter an `install` hook or any configuration template in `svc_config_install_path` will not cause a service to reload.

### reload

File location: `<plan>/hooks/reload`. This hook is now deprecated; you should use `reconfigure` instead (see below). To provide backward compatibility, if a `reload` hook is provided, the service will restart in response to configuration changes.

### reconfigure

File location: `<plan>/hooks/reconfigure`. A `reconfigure` hook can be written for services that can respond to changes in `<plan>/config` without requiring a restart. This hook will execute **instead** of the default behavior of restarting the process. `{{pkg.svc_pid_file}}` can be used to get the `PID` of the service.

Habitat does not support changing the `PID` of the underlying service in any lifecycle hook. If part of a service's reconfiguration relies on changing the `PID`, you should not provide a `reconfigure` hook, and instead, use the default behavior of restarting the service for reconfiguration.

The `reconfigure` hook is not necessarily run on every change to `<plan>/config`. The `reconfigure` hook will not be run if the service restarts before the `reconfigure` hook has run. The restart is considered sufficient for reconfiguring the service. For example, when applying a configuration that changes both the `run` hook and `<plan>/config`, the change to the `run` hook will trigger a restart. Therefore, the `reconfigure` hook will not be run. To put it another way, the `reconfigure` hook will only respond to changes in `<plan>/config` after the service has started.

### suitability

File location: `<plan>/hooks/suitability`. The suitability hook allows a service to report a priority by which it should be elected leader. The hook is called when a new election is triggered and the last line it outputs to `stdout` should be a number parsable as a `u64`. In the event that a leader goes down and an election is started the service with the highest reported suitability will become the new leader.

### run

File location: `<plan>/hooks/run`. This hook is run when one of the following conditions occur:

- The main topology starts, after the `init` hook has been called.
- When a package is updated, after the `init` hook has been called.
- When the package config changes, after the `init` hook has been called, but before a `reconfigure` hook is called.

You can use this hook in place of `$pkg_svc_run` when you need more complex behavior such as setting environment variables or command options that are based on dynamic configuration.

Services run using this hook should do two things:

- Redirect stderr to stdout (e.g. with `exec 2>&1` at the start of the hook)
- Call the command to execute with `exec <command> <options>` rather than running the command directly. This ensures the command is executed in the same process and that the service will restart correctly on configuration changes.

It is important to also consider what side effects the command to execute will have. For example, does the command spin off other processes in separate process groups? If so, they may not be cleaned up automatically when the system is reconfigured. In general, the command executed should behave in a manner similar to a daemon, and be able to clean up properly after itself when it receives a SIGTERM, and properly forward signals to other processes that it creates. For an even more specific example: let's say you are trying to start a node.js service. Instead of your command being `npm start`, you should use `node server.js` directly.

A run hook can use the following as a template:

```bash hooks/run
#!/bin/sh

#redirect stderr
exec 2>&1

# Set some environment variables
export MY_ENVIRONMENT_VARIABLE=1
export MY_OTHER_ENVIRONMENT_VARIABLE=2

# Run the command
exec my_command --option {{cfg.option}} --option2 {{cfg.option2}}
```

### post-run

File location: `<plan>/hooks/post-run`. The post run hook will get executed after initial startup. For many data services creation of specific users / roles or datastores is required. This needs to happen once the service has already started.

### post-stop

File location: `<plan>/hooks/post-stop`. The post-stop hook will get executed after service has been stopped successfully. You may use this hook to undo what the `init` hook has done.
