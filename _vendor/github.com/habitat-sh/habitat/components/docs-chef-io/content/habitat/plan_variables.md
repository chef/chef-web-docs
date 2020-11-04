+++
title = "Plan Variables"
description = "Set package, service, and cache paths, compiler options, install location and context with plan variables"

[menu]
  [menu.habitat]
    title = "Plan Variables"
    identifier = "habitat/reference/plan-variables"
    parent = "habitat/reference"

+++
[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/plan_variables.md)

The following variables can be used in your plans to help get binaries and libraries to build and install in the correct locations in your package.

pkg_prefix
: The absolute path for your package.

pkg_dirname
: Set to `{pkg_name}-{pkg_version}` by default. If a .tar file extracts to a directory that's different from the filename, then you would need to override this value to match the directory name created during extraction.

pkg_svc_path
: Where the running service is located. Location: `HAB_ROOT_PATH/svc/pkg_name`

pkg_svc_data_path
: Where the running service data is located. Location: `pkg_svc_path/data`

pkg_svc_files_path
: Where the gossiped configuration files are located. Location: `pkg_svc_path/files`

pkg_svc_var_path
: Where the running service variable data is located. Location: `pkg_svc_path/var`

pkg_svc_config_path
: Where the running service configuration is located. Location: `pkg_svc_path/config`

pkg_svc_static_path
: Where the running service static data is located. Location: `pkg_svc_path/static`

CACHE_PATH
: A temporary directory that will be clean on every build.

HAB_CACHE_SRC_PATH
: The default path where source archives are downloaded, extracted, & compiled.

HAB_CACHE_ARTIFACT_PATH
: The default download root path for packages.

HAB_PKG_PATH
: The root path containing all locally installed packages.

PLAN_CONTEXT
: The location on your local dev machine for the files in your plan directory.

CFLAGS
: C compiler options.

LDFLAGS
: C linker options.

PREFIX
: Where to install the software; same as `pkg_prefix`.

LD_RUN_PATH
: Where to find the binaries at run time.
