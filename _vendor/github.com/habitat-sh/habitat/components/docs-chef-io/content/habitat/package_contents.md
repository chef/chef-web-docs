+++
title = "Package Contents"
description = "Package Contents"

[menu]
  [menu.habitat]
    title = "Package Contents"
    identifier = "habitat/reference/package-contents"
    parent = "habitat/reference"

+++
[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/package_contents.md)

During the build process, the hab-plan-build script creates several files that specify dependency, build, and configuration information. When packages are unpacked (extracted) and installed during the initialization phase of a Chef Habitat service, these files define what those packages need to run.

Packages are installed in the `/hab/pkgs/` directory, and then further organized in subdirectories corresponding to fully-qualified package identifiers: `origin/name/version/release`. For more information on package identifiers, see [Packages]({{< relref "pkg_ids" >}}).

## Contents of a Chef Habitat package

BUILD_DEPS
: Fully-qualified package identifiers of any build dependencies that your package depends on. These are listed in the root plan.sh file of your plan directory.

BUILD_TDEPS
: Fully-qualified package identifiers of any runtime dependencies that the build dependencies for your project depend on. This is essentially a flattened tree of dependencies all the way up to the root dependency (`linux-headers` in most cases).

BUILDTIME_ENVIRONMENT
: A file that contains similar information as the RUNTIME_ENVIRONMENT file, but is constructed from a package's build-time dependencies instead of its runtime dependencies. This file is not currently consumed by any other software in the Chef Habitat ecosystem, but can be used for troubleshooting and informative purposes.

BUILDTIME_ENVIRONMENT_PROVENANCE
: A file that provides information on which specific dependencies have influenced the final value of a given variable in the BUILDTIME_ENVIRONMENT file. This file is not currently consumed by any other software in the Chef Habitat ecosystem, but can be used for troubleshooting and informative purposes.

CFLAGS
: Additional switches to be passed to the compiler when this package is used as a build dependency.

DEPS
: Runtime dependencies for your package. These dependencies are processed by Chef Habitat and their corresponding environment variables (such as `PATH` and `LD_LIBRARY_PATH`) are added to the current environment.

FILES
: List of all files in this package along with their blake2b checksums. The FILES file itself is signed using `hab pkg sign` to provide an assurance that its contents haven't been tampered with.

IDENT
: The fully-qualified identifier for the package. The format is `origin/name/version/release`.

INTERPRETERS
: If `pkg_interpreters` is specified in your plan.sh, then this file will be generated and contain a list of absolute paths to any interpreters that a package can provide. Code in a `plan.sh` may use the `fix_interpreter` function to replace hard-coded instances of interpreters, such as `/bin/env`. The location of interpreters in Chef Habitat will be nested under `/hab/pkgs/`. For more information on interpreters, see the fix_interpreter description in [Plan helper functions]({{< relref "build_helpers" >}}).

LDFLAGS
: Additional switches to be passed to the compiler when this package is used as a build dependency.

LD_RUN_PATH
: Additional switches to be passed to the compiler when this package is used as a build dependency.

MANIFEST
: A file containing package information, such as checksum, maintainer, build variables, and other metadata specified in plan.sh as well as the contents of the plan.sh itself.

PATH
: A file that contains all directories in the package which contain program binaries. The directories are separated with the target platform's path separator character (i.e. either `:` or `;`).

RUNTIME_ENVIRONMENT
: A file containing the result of the layering operation of the current package's runtime environment variables on top of those of its dependencies. This is what the build process consults when it processes dependencies, and this is what the Supervisor consults in concert with `RUNTIME_PATH` when generating the full set of environment variables that should be added to an environment before running a supervised process.

RUNTIME_ENVIRONMENT_PROVENANCE
: A file that provides information on which specific dependencies have influenced the final value of a given variable in the RUNTIME_ENVIRONMENT file. This file is not currently consumed by any other software in the Chef Habitat ecosystem, but can be used for troubleshooting and informative purposes.

RUNTIME_PATH
: A file that contains all directories that need to be prepended to an environment's `$PATH` before a program in this package can be expected to run correctly. The order of the elements are precise and meaningful so should not be altered. This file is used in concert with `RUNTIME_ENVIRONMENT` to compute the full set of environment variables that should be added to an environment before running a program in this package.

TARGET
: The CPU architecture and platform for the package. The format is `architecture-platform`. For example, x86_64-linux.

TDEPS
: Fully-qualified package identifiers of any runtime dependencies that the runtime dependencies for your project depend on. This is essentially a flattened tree of dependencies all the way up to the root dependency (`linux-headers` in most cases).

SVC_GROUP
: The value of `pkg_svc_group` from a plan. The Chef Habitat Supervisor will try to start a service with this group if it exists.

SVC_USER
: The value of `pkg_svc_user` from a plan. The Chef Habitat Supervisor will try to start a service with this user if it exists.

default.toml
: If you have defined a `default.toml` file in the root of your plan, then it will be included in the same relative location within the installed package directory. For more information on configuration and the default.toml file, see [Configuration Updates]({{< relref "service_updates" >}}).

config directory
: If you have defined a `config` subdirectory with a templatized configuration file in your plan, then they will be included in the same relative location within the installed package directory. For more information on templatized configuration files, see [Add configuration to plans]({{< relref "config_templates" >}}).

config_install directory
: If you have defined a `config_install` subdirectory with a templatized configuration file in your plan, then they will be included in the same relative location within the installed package directory. For more information on templatized configuration files, see [Add configuration to plans]({{< relref "config_templates" >}}).

hooks directory
: If you have defined a `hooks` subdirectory with hook scripts in your plan, then they will be included in the same relative location within the installed package directory. Read more about [Application Lifecycle Hooks]({{< relref "application_lifecycle_hooks" >}}).
