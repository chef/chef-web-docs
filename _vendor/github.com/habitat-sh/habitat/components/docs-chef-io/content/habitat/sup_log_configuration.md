+++
title = "Supervisor Log Configuration"
description = "Dynamically adjust the logging configuration of a running Supervisor"

[menu]
  [menu.habitat]
    title = "Supervisor Log Configuration"
    identifier = "habitat/supervisors/sup-log-configuration"
    parent = "habitat/supervisors"
    weight = 90

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/sup_log_configuration.md)

With the 0.83.0 release of the Chef Habitat Supervisor, it is possible to have greater control over logging output, including the ability to dynamically adjust the logging configuration of a running Supervisor. There are two main ways of configuring logging, each of which has their own strengths and weaknesses: using environment variables, and using a configuration file.

## Environment Variable Configuration

It is still possible to configure logging via the `RUST_LOG` environment variable. This approach is often useful for quickly re-configuring logging (requiring a restart), or for easily configuring logging in container-based deployments.

The configuration scheme is essentially the same as that described in the documentation of the Rust [env_logger](https://docs.rs/env_logger/0.6.1/env_logger/#enabling-logging) crate, with the exception that we do not allow additional regular expression-based filtering. The configuration values the Supervisor recognizes are described below:

## Simple Logging Levels

The recognized values are, in increasing verbosity (or, equivalently, in decreasing severity): `error`, `warn`, `info`, `debug`, and `trace`.

Setting `RUST_LOG` to one of these values will cause all log messages at that verbosity and below (equivalently, that severity and above) to be printed. This includes log messages from Habitat, as well as any libraries that it uses.

## Rust Logging Levels

This is much finer grained than the simple logging levels above, and to fully leverage it requires some knowledge of both the internal code structure of Habitat itself, as well as of how Rust code is organized generally. Despite this, it allows you to target specific subsystems, which can be very helpful for troubleshooting.

For example, `RUST_LOG=habitat_sup::manager=info` will cause all log messages at the `info` level or more severe (i.e., `error`, `warn`, and `info`) originating anywhere in the module hierarchy rooted at `habitat_sup::manager`.

Note that Rust modules are identified first by the crate (or library) they come from, followed by a `::`-delimited path of module names.

## Variations

Multiple logging specifiers can be submitted, separated by commas. A simple logging level will act as the default, with additional module-targeted levels serving to refine the logging for the target code. If you supply multiple simple logging levels, only the last one will count. Any number of targeted logging levels are allowed, however.

For example, `RUST_LOG=info,habitat_sup::manager=debug,tokio_reactor=error` will limit logs generally to the `info` level, while additionally allowing `debug` messages coming from the `habitat_sup::manager` module hierarchy, and restricting log messages from the `tokio_reactor` library to only `error`.

## Dynamic, File-based Configuration

For further control over logging output, as well as the ability to change the configuration of a running Supervisor, a configuration file is needed. This file is processed by the [log4rs](https://docs.rs/log4rs/) crate, and shares many of the same concepts as the Log4J logging system of the Java ecosystem. The `log4rs` configuration documentation can be found [here](https://docs.rs/log4rs/0.8.3/log4rs/#configuration).

Place an appropriate YAML configuration file at `/hab/sup/default/config/log.yml` when the Supervisor starts up if you wish to take advantage of this style of configuration. Note that if such a file is present, it will take priority over any `RUST_LOG` environment variable that may also be present.

Here is an example configuration file that mimics the default logging configuration of the Supervisor. It emits UTC timestamped message lines to standard output at the `error` level.

```yaml
# ALWAYS keep this key in the configuration; removing it means changes
# to config won't get picked up without a restart.
#
# Uses humantime to parse the duration; see
# https://docs.rs/humantime/1.2.0/humantime/fn.parse_duration.html
refresh_rate: 5 seconds

appenders:
  stdout:
    kind: console
    encoder:
      # See https://docs.rs/log4rs/0.8.3/log4rs/#configuration for
      # formatting options
      pattern: "[{d(%Y-%m-%dT%H:%M:%SZ)(utc)} {l} {module}] {message}{n}"

root:
  level: error
  appenders:
    - stdout
```

The `refresh_rate` configuration is very important. If it is present when the Supervisor starts, the file will be checked periodically for updates (according to the value of `refresh_rate`; in the above example, the file will be checked every 5 seconds). If the file changes, then the current content of the file becomes the active configuration. This allows you to, for example, increase the logging level of a running supervisor if you suspect you are running into problems.

This dynamism also has a catch, though: you can change the refresh rate as well, and even remove it entirely. If you remove it, however, the Supervisor will stop checking for updates to the file. Any subsequent changes you might make would require a Supervisor restart to be recognized. Work is planned to make this more flexible, however.

You can also target individual module hierarchies with this configuration scheme, just as you can with the `RUST_LOG` environment variable. For this, you will need to add a new top-level `loggers` key to the file, like so:

```yaml
loggers:
  habitat_sup::manager:
    level: debug
  tokio_reactor:
    level: error
```

Here, `loggers` is a map of maps. Map keys are module paths (as described above in the `RUST_LOG` environment variable documentation), while the values are maps with additional configuration. Here, we are only setting the logging level, but more advanced configurations are possible.

Users are encouraged to read the [log4rs configuration documentation](https://docs.rs/log4rs/0.8.3/log4rs/#configuration) for further details.
