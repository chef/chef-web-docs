+++
title = "Build Phase Callbacks"
description = "Override default buildtime behavior with build phase callbacks"

[menu]
  [menu.habitat]
    title = "Build Phase Callbacks"
    identifier = "habitat/reference/build-phase-callbacks"
    parent = "habitat/reference"

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/build_phase_callbacks.md)

When defining your plan, you can override the default behavior of Chef Habitat in each build phase through a callback. To define a callback, simply create a shell function of the same name in your plan file and then write your script. If you do not want to use the default callback behavior, you must override the callback and `return 0` in the function definition or simply provide no implementation in a `plan.ps1`.

These callbacks are listed in the order that they executed by the package build script.

{{< note >}}
Bash callbacks are prefixed with `do_` and use an underscore convention. Powershell plans prefix callbacks with `Invoke-` and use a PascalCase convention.
{{< /note >}}

You can also use [plan variables]({{< relref "plan_variables" >}}) in your plans to place binaries, libraries, and files into their correct locations during package compilation or when running as a service.

Additionally, [plan helper functions]({{< relref "build_helpers" >}}) can be useful in your plan to help you build your package correctly. They are mostly used for building packages - attach() is used for debugging.

do_begin()/Invoke-Begin
: Used to execute arbitrary commands before anything else happens. Note that at this phase of the build, no dependencies are resolved, the `$PATH` and environment is not set, and no external source has been downloaded. For a phase that is more completely set up, see the `do_before()` phase.

do_begin_default()/Invoke-BeginDefault
: There is an empty default implementation of this callback.

do_setup_environment()/Invoke-SetupEnvironment
: Use this to declare buildtime and runtime environment variables that overwrite or are in addition to the default environment variables created by Chef Habitat during the build process. Examples of common environment variables you might wish to add or modify are those such as `JAVA_HOME` or `GEM_PATH`.

{{< note >}}
You do not have to override this callback if you do not wish to modify your environment variables. The build system will always set up your environment according to your dependencies. For example, it will ensure that dependency binaries are always present on your `PATH` variable, and so on.
{{< /note >}}

Runtime environments of dependencies are layered together in the order they are declared in your `pkg_deps` array, followed by modifications made in this callback. In turn, these computed values will be made available to packages that use the current package as a dependency, and so on.

The buildtime environment is assembled by processing the *runtime* environments of your `pkg_build_deps` dependencies (because they will be running in your build) in a similar manner. The final environment in which your package will be built consists of:

* The system environment of your Studio as the base layer
* The assembled runtime environment of your package on top of the base
* Any buildtime environment information on top of the assembled runtime environment

Only the runtime portion of this combined buildtime environment is made available to your package when it is running in a Supervisor (or when it is being used as a dependency of another Chef Habitat package).

To add or modify your environment variables, there are special functions to call within this callback to ensure that the variables are set up appropriately.

{{< foundation_tabs tabs-id="bash-powershell-panel1" >}}
  {{< foundation_tab active="true" panel-link="bash-panel1" tab-text="Bash">}}
  {{< foundation_tab panel-link="powershell-panel1" tab-text="Powershell" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="bash-powershell-panel1" >}}
  {{< foundation_tabs_panel active="true" panel-id="bash-panel1" >}}
  ```bash
  set_runtime_env [-f] VARIABLE_NAME VALUE
  set_buildtime_env [-f] VARIABLE_NAME VALUE
  ```
  {{< /foundation_tabs_panel >}}

  {{< foundation_tabs_panel panel-id="powershell-panel1" >}}
  ```powershell
  Set-RuntimeEnv VARIABLE_NAME VALUE [-force] [-IsPath]
  Set-BuildtimeEnv VARIABLE_NAME VALUE [-force] [-IsPath]
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

In Powershell plans, if your variable contains values that are file paths pointing inside the Chef Habitat `/hab` directory, you can use the `-IsPath` flag to ensure that the path remains portable accross different Chef Habitat environments. For example in a local (non-Docker) Windows Studio, the following line:

```powershell
Set-RuntimeEnv SSL_CERT_FILE "$(Get-HabPackagePath cacerts)/ssl/cert.pem"
```

will set `SSL_CERT_FILE` to the `ssl/cert.pem` file inside of the `cacerts` package path. This path will be located inside of `c:/hab/studios` which will not be valid inside of a non-Studio Supervisor or inside of a Docker Studio. Instead, use the following code:

```powershell
Set-RuntimeEnv SSL_CERT_FILE "$(Get-HabPackagePath cacerts)/ssl/cert.pem" -IsPath
```

This will hint to the packaging system that this path should be properly rooted inside of the Chef Habitat filesystem of the current running environment.

These functions allow you to _set_ an environment variable's value. If one of your dependencies has already declared a value for this, it will result in a build failure, protecting you from inadvertently breaking anything. If you really do want to replace the value, you can supply the `-f` or `-force` flag.

For pushing new values onto a multi-valued environment variable (like `PATH`), use the following functions:

{{< foundation_tabs tabs-id="bash-powershell-panel2" >}}
  {{< foundation_tab active="true" panel-link="bash-panel2" tab-text="Bash">}}
  {{< foundation_tab panel-link="powershell-panel2" tab-text="Powershell" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="bash-powershell-panel2" >}}
  {{< foundation_tabs_panel active="true" panel-id="bash-panel2" >}}
  ```bash
  push_runtime_env VARIABLE_NAME VALUE
  push_buildtime_env VARIABLE_NAME VALUE
  ```
  {{< /foundation_tabs_panel >}}

  {{< foundation_tabs_panel panel-id="powershell-panel2" >}}
  ```powershell
  Push-RuntimeEnv VARIABLE_NAME VALUE [-IsPath]
  Push-BuildtimeEnv VARIABLE_NAME VALUE [-IsPath]
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

These functions allow you to push a new value onto a multi-valued environment variable without overwriting the existing values. These multi-valued variables are referred to as "aggregate" variables in Chef Habitat. Single-value environment variables are known as "primitive" variables.

By default, Chef Habitat treats all variables as "primitive" variables. If you are working with a value that is actually an "aggregate" type, you must set the following special environment variable somewhere in the top level of your plan.

{{< foundation_tabs tabs-id="bash-powershell-panel3" >}}
  {{< foundation_tab active="true" panel-link="bash-panel3" tab-text="Bash">}}
  {{< foundation_tab panel-link="powershell-panel3" tab-text="Powershell" >}}
{{< /foundation_tabs >}}

{{< foundation_tabs_panels tabs-id="bash-powershell-panel3" >}}
  {{< foundation_tabs_panel active="true" panel-id="bash-panel3" >}}
  ```bash
  export HAB_ENV_FOO_TYPE=aggregate
  ```
  {{< /foundation_tabs_panel >}}

  {{< foundation_tabs_panel panel-id="powershell-panel3" >}}
  ```powershell
  $env:HAB_ENV_FOO_TYPE="aggregate"
  ```
  {{< /foundation_tabs_panel >}}
{{< /foundation_tabs_panels >}}

Similarly, Chef Habitat defaults to using the colon (`:`) as a separator for aggregate variables on Linux. If the hypothetical `FOO` variable uses a semicolon (`;`) as a separator instead, then you must add `export HAB_ENV_FOO_SEPARATOR=;` at the top level of the plan. On Windows, `;` is the default separator.

In all cases, when Chef Habitat is assuming a default strategy, it will emit log messages to notify you of that along with instructions on how to change the behavior.

{{< note >}}
If you discover common environment variables that Chef Habitat doesn't currently treat appropriately, feel free to request an addition to the codebase, or even to submit a pull request yourself.
{{< /note >}}

do_before()/Invoke-Before
: At this phase of the build, the origin key has been checked for, all package dependencies have been resolved and downloaded, and the `$PATH` and environment are set, but this is just before any source downloading would occur (if `$pkg_source` is set). This could be a suitable phase in which to compute a dynamic version of a package given the state of a Git repository, fire an API call, start timing something, etc.

do_before_default()/Invoke-BeforeDefault
: There is an empty default implementation of this callback.

do_download()/Invoke-Download
: If `$pkg_source` is being used, download the software and place it in `$HAB_CACHE_SRC_PATH/$pkg_filename`. If the source already exists in the cache, verify that the checksum is what we expect, and skip the download. Delegates most of the implementation to the `do_default_download()` function.

do_download_default()/Invoke-DownloadDefault
: The default implementation is that the software specified in `$pkg_source` is downloaded, checksum-verified, and placed in `$HAB_CACHE_SRC_PATH/$pkg_filename`, which resolves to a path like `/hab/cache/src/filename.tar.gz`. You should override this behavior if you need to change how your binary source is downloaded, if you are not downloading any source code at all, or if you are cloning from git. If you do clone a repo from git, you must override do_verify() to return 0.

do_verify()/Invoke-Verify
: If `$pkg_source` is being used, verify that the package we have in `$HAB_CACHE_SRC_PATH/$pkg_filename` has the `$pkg_shasum` we expect. Delegates most of the implementation to the `do_default_verify()` function.
  
  If you do clone a repo from git, you must override do_verify() to return 0.

do_verify_default()/Invoke-VerifyDefault
: The default implementation tries to verify the checksum specified in the plan against the computed checksum after downloading the source tarball to disk. If the specified checksum doesn't match the computed checksum, then an error and a message specifying the mismatch will be printed to stderr. You should not need to override this behavior unless your package does not download any files.

do_clean()Invoke-Clean
: Clean up the remnants of any previous build job, ensuring it can't pollute out new output. Delegates most of the implementation to the `do_default_clean()` function.

do_default_clean()/Invoke-DefaultClean
: The default implementation removes the `HAB_CACHE_SRC_PATH/$pkg_dirname` folder in case there was a previously-built version of your package installed on disk. This ensures you start with a clean build environment.

do_unpack()/Invoke-Unpack
: If `$pkg_source` is being used, we take the `$HAB_CACHE_SRC_PATH/$pkg_filename` from the download step and unpack it,as long as the method of extraction can be determined. This takes place in the $HAB_CACHE_SRC_PATH directory. Delegates most of the implementation to the `do_default_unpack()` function.

do_default_unpack()/Invoke-DefaultUnpack
: The default implementation extracts your tarball source file into `HAB_CACHE_SRC_PATH`. The supported archive extensions on Linux are: .tar, .tar.bz2, .tar.gz, .tar.xz, .rar, .zip, .Z, .7z. Only .zip is supported on Windows. If the file archive could not be found or has an unsupported extension, then a message will be printed to stderr with additional information.

do_prepare()/Invoke-Prepare
: There is no default implementation of this callback. At this point in the build process, the tarball source has been downloaded, unpacked, and the build environment variables have been set, so you can use this callback to perform any actions before the package starts building, such as exporting variables, adding symlinks, and so on.

  A step that exists to be overridden. Do what you need to do before we actually run the build steps.

do_default_prepare()/Invoke-DefaultPrepare
: There is an empty default implementation of this callback.

do_build()/Invoke-Build
: You should override this behavior if you have additional configuration changes to make or other software to build and install as part of building your package. This step builds the software; assumes the GNU pattern. Delegates most of the implementation to the `do_default_build()` function.

do_default_build()/Invoke-DefaultBuild
: The default implementation is to update the prefix path for the configure script to use `$pkg_prefix` and then run `make` to compile the downloaded source. This means the script in the default implementation does `./configure --prefix=$pkg_prefix && make`.

do_check()/Invoke-Check
: Will run post-compile tests and checks, provided 2 conditions are true:

1. A `do_check()` function has been declared. By default, no such function exists, so Plan author must add one explicitly--there is no reasonably good default here.
1. A `$DO_CHECK` environment variable is set to some non-empty value. As tests can dramatically inflate the build time of a Plan, this has been     left as an opt-in option.

   Here's an example of a vanilla Plan such as `sed`:

   ```bash
   core-plans/sed/plan.sh
   pkg_name=sed
   # other Plan metadata...

   do_check() {
     make check
   }
   ```

do_install()/Invoke-Install
:  Installs the software. Delegates most of the implementation to the `do_default_install()` function. You should override this behavior if you need to perform custom installation steps, such as copying files from `HAB_CACHE_SRC_PATH` to specific directories in your package, or installing pre-built binaries into your package.

do_default_install()/Invoke-DefaultInstall
: The default implementation is to run `make install` on the source files and place the compiled binaries or libraries in `HAB_CACHE_SRC_PATH/$pkg_dirname`, which resolves to a path like `/hab/cache/src/packagename-version/`. It uses this location because of do_build() using the `--prefix` option when calling the configure script.

do_build_config()/Invoke-BuildConfig
: Copy the `./config` directory, relative to the Plan, to `$pkg_prefix/config`. Do the same with `default.toml`. Delegates most of the implementation to the `do_default_build_config()` function.

  Allows users to depend on a core plan and pull in its configuration but set their own unique configurations at build time.

do_default_build_config()/Invoke-DefaultBuildConfig
: Default implementation for the `do_build_config()` phase.

do_build_service()/Invoke-BuildService
: Write out the `$pkg_prefix/run` file. If a file named `hooks/run` exists, we skip this step. Otherwise, we look for `$pkg_svc_run`, and use that. We assume that the binary used in the `$pkg_svc_run` command is set in the $PATH.

  This will write a `run` script that uses `chpst` to run the command as the `$pkg_svc_user` and `$pkg_svc_group`. These are `hab` by default.

  Delegates most of the implementation to the `do_default_build_server()` function.

do_default_build_service()/Invoke-DefaultBuildService
: Default implementation of the `do_build_service()` phase.

do_strip()
: `plan.sh` only. You should override this behavior if you want to change how the binaries are stripped, which additional binaries located in subdirectories might also need to be stripped, or whether you do not want the binaries stripped at all.

do_default_strip()
: `plan.sh` only. The default implementation is to strip any binaries in `$pkg_prefix` of their debugging symbols. Goal of this step is to reduce our total size.

do_after()/Invoke-After
: At this phase, the package has been built, installed, stripped, but before the package metadata is written and the artifact is created and signed.

do_default_after()/Invoke-DefaultAfter
: There is an empty default implementation of this callback.

do_end()/Invoke-End
: A function for cleaning up after yourself, this is called after the package artifact has been created. You can use this callback to remove any temporary files or perform other post-build clean-up actions.

do_default_end()/Invoke-DefaultEnd
: There is an empty default implementation of this callback.

do_after_success()
: `plan.sh` only. A function that is called at the absolute end of a successful build process. This can be used to provide integration points with external systems, among other things, particularly if you are not using Builder (a Notifications feature is coming to Builder in H2 2018). Failure of this callback will not fail your build, nor will it trigger a `do_after_failure` call.

do_after_failure()
: `plan.sh` only. A function that is called at the absolute end of a failed build process. This can be used to provide integration points with external systems, among other things, particularly if you are not using Builder (a Notifications feature is coming to Builder in H2 2018). The result of this callback cannot affect the disposition of the overall build; once the build has failed, it's failed. Keep in mind that since a build could potentially fail at any time, certain variables or data structures may not be present or initialized when this callback is called, so code accordingly.
