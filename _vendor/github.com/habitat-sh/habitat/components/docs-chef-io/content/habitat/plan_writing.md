+++
title = "Writing Plans"
description = "Documentation for writing Chef Habitat Plan files including configuration templates, binds, and exporting"

aliases = ["/habitat/developing-packages/"]

[menu]
  [menu.habitat]
    title = "Plan Writing"
    identifier = "habitat/plans/plan-writing Chef Habitat Plan Overview"
    parent = "habitat/plans"
    weight = 10

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/plan_writing.md)

In Chef Habitat the unit of automation is the application itself. This chapter includes content related specifically to the process and workflow of developing a plan that will instruct Chef Habitat in how to build, deploy, and manage your application.

## Writing Plans

Artifacts are the cryptographically-signed tarballs that are uploaded, downloaded, unpacked, and installed in Chef Habitat. They are built from shell scripts known as plans, but may also include application lifecycle hooks and service configuration files that describe the behavior and configuration of a running service.

At the center of Chef Habitat packaging is the plan. This is a directory comprised of shell scripts and optional configuration files that define how you download, configure, make, install, and manage the lifecycle of the software in the artifact. More conceptual information on artifacts can be found in the [Package Identifiers]({{< relref "pkg_ids" >}}) page.

As a way to start to understand plans, let's look at an example `plan.sh` for [sqlite](https://www.sqlite.org/):

```bash plan.sh
pkg_name=sqlite
pkg_version=3130000
pkg_origin=core
pkg_license=('Public Domain')
pkg_maintainer="The Chef Habitat Maintainers <humans@habitat.sh>"
pkg_description="A software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine."
pkg_upstream_url=https://www.sqlite.org/
pkg_source=https://www.sqlite.org/2016/${pkg_name}-autoconf-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-autoconf-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-autoconf-${pkg_version}
pkg_shasum=e2797026b3310c9d08bd472f6d430058c6dd139ff9d4e30289884ccd9744086b
pkg_deps=(core/glibc core/readline)
pkg_build_deps=(core/gcc core/make core/coreutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
```

> Note: On Windows we would create a plan.ps1 file instead. All the variable names are the same but we use Powershell syntax so, for example, `pkg_deps=(core/glibc core/readline)` becomes `$pkg_deps=@("core/glibc", "core/readline")`.

It has the name of the software, the version, where to download it, a checksum to verify the contents are what we expect, run dependencies on `core/glibc` and `core/readline`, build dependencies on `core/coreutils`, `core/make`, `core/gcc`, libraries files in `lib`, header files in `include`, and a binary file in `bin`. Also, because it's a core plan, it has a description and upstream URL for the source project included.

> Note: The `core` prefix is the origin of those dependencies. For more information, see [Create an Origin]({{< relref "builder_origins" >}})

When you have finished creating your plan and call `build` in Chef Habitat studio, the following occurs:

1. The build script ensures that the private origin key is available to sign the artifact.
2. If specified in `pkg_source`, a compressed file containing the source code is downloaded.
3. The checksum of that file, specified in `pkg_shasum`, is validated.
4. The source is extracted into a temporary cache.
5. Unless overridden, the callback methods will build and install the binary or library via `make` and `make install`, respectively for Linux based builds.
6. Your package contents (binaries, runtime dependencies, libraries, assets, etc.) are then compressed into a tarball.
7. The tarball is signed with your private origin key and given a `.hart` file extension.

After the build script completes, you can then upload your package to Chef Habitat Builder, or install and start your package locally.

> Note: The plan.sh or plan.ps1 file is the only required file to create a package. Configuration files, runtime hooks, and other source files are optional.

## Write Your First Plan

All plans must have a `plan.sh` or `plan.ps1` at the root of the plan context. They may even include both if a package is targeting both Windows and Linux platforms. This file will be used by the `hab-plan-build` command to build your package. To create a plan, do the following:

1. If you haven't done so already, [download the `hab` CLI]({{< relref "install_habitat/" >}}) and install it per the instructions on the download page.

2. Run `hab cli setup` and follow the instructions in the setup script.

3. The easiest way to create a plan is to use the `hab plan init` subcommand. This subcommand will create a directory, known as the plan context, that contains your plan file and any runtime hooks and/or templated configuration data.

    To use `hab plan init` as part of your project repo, navigate to the root of your project repo and run `hab plan init`. It will create a new `habitat` sub-directory with a plan.sh (or plan.ps1 on Windows) based on the name of the parent directory, and include a `default.toml` file as well as `config` and `hooks` directories for you to populate as needed. For example:

    ```bash
    cd /path/to/<reponame>
    hab plan init
    ```

    will result in a new `habitat` directory located at `/path/to/<reponame>/habitat`. A plan file will be created and the `pkg_name` variable will be set to _\<reponame\>_. Also, any environment variables that you have previously set (such as `HAB_ORIGIN`) will be used to populate the respective `pkg_*` variables.

    If you want to auto-populate more of the `pkg_*` variables, you also have the option of setting them when calling `hab plan init`, as shown in the following example:

    ```bash
    env pkg_svc_user=someuser pkg_deps="(core/make core/coreutils)" \
       pkg_license="('MIT' 'Apache-2.0')" pkg_bin_dirs="(bin sbin)" \
       pkg_version=1.0.0 pkg_description="foo" pkg_maintainer="you" \
       hab plan init yourplan
    ```

     See [hab plan init]({{< relref "habitat_cli#hab-plan-init" >}}) for more information on how to use this subcommand.

4. Now that you have stubbed out your plan file in your plan context, open it and begin modifying it to suit your needs.

When writing a plan, it's important to understand that you are defining both how the package is built and the actions Chef Habitat will take when the Supervisor starts and manages the child processes in the package. The following sections explain what you need to do for each phase.

## Writing a Plan for Multiple Platform Targets

You may want to create a plan for an application that can run on multiple platform targets. You can create target specific folders beneath either the root of your project or a top level `habitat` folder. Then save the plan, hooks, and configuration templates specific to a single platform all inside of that target specific folder.

For example, an application targeting linux, Linux kernel 2, and Windows may have the following structure:

```
app_root/
├── x86_64-linux/
|   |   plan.sh
|   └── hooks/
|           run
├── x86_64-linux-kernel2/
|   |   plan.sh
|   └── hooks/
|           run
└── x86_64-windows/
    |   plan.ps1
    └── hooks/
            run
```

The build script will look for the base of your plan in the following locations:

- `<app_root>/<target>/`
- `<app_root>/habitat/<target>/`
- `<app_root>/`
- `<app_root>/habitat/`

If it finds a plan both inside as well as outside of a target folder, the target specific plan will be used as long as that is the target currently being built. However it is strongly recommended that you do not have plans both inside and outside of a target folder. We currently allow this only for backwards compatibility with some existing plans but plan to eventually fail builds where a plan exists in both places. The best practice when you need multiple plans for different targets is to put each plan in its own target folder.

Of course if your plan does not include hooks or configuration templates and just requires a plan file, you may choose this simpler structure:

```
app_root/
└── habitat/
        plan.sh
        plan.ps1
```

> Note: It is recommended to place all plan files inside of a `habitat` parent folder in order to allow for clean separation between your application source code and habitat specific files. However, if you maintain a separate repository solely for the purpose of storing habitat plans, then the use of a `habitat` folder may not be necessary.

On Windows, only a `plan.ps1` will be used and a `plan.sh` will only be used on Linux or Linux kernel 2. So if your application requires different plans for Linux and Linux Kernel 2, even without hooks and configuration templates, you will need to use target folders for each platform.

### Buildtime Workflow

For buildtime installation and configuration, workflow steps need to be included in the plan file to define how you will install your application source files into a package. Before writing your plan, you should know and understand how your application binaries are currently built, installed, what their dependencies are, and where your application or software library expects to find those dependencies.

The main steps in the buildtime workflow are the following:

1. Create your fully-qualified package identifier.
2. Add licensing and contact information.
3. Download and unpack your source files.
4. Define your dependencies.
5. (Optional) Override any default build phases you need to using callbacks.

The following sections describe each of these steps in more detail.

#### Create your Package Identifier

The origin is a place for you to set default privacy rules, store your packages, and collaborate with teammates. For example, the "core" origin is where the core maintainers of Chef Habitat share packages that are foundational to building other packages. If you would like to browse them, they are located in the [core-plans repo](https://github.com/habitat-sh/core-plans), and on [Chef Habitat Builder's Core Origin](https://bldr.habitat.sh/#/pkgs/core).

Creating artifacts for a specific origin requires that you have access to the that origin's private key. The private origin key will be used to sign the artifact when it is built by the `hab plan build` command. Origin keys are kept in `$HOME/.hab/cache/keys` on the host machine when running `hab` as a non-root user and `/hab/cache/keys` when running as root (including in the studio). For more information on origin keys, see [Keys]({{< relref "keys" >}}).

The next important part of your package identifier is the name of the package. Standard naming convention is to base the name of the package off of the name of the source or project you download and install into the package.

#### Add Licensing and Contact Information

You should enter your contact information in your plan.

Most importantly, you should update the `pkg_license` value to indicate the type of license (or licenses) that your source files are licensed under. Valid license types can be found at [https://spdx.org/licenses/](https://spdx.org/licenses/). You can include multiple licenses as an array.

> Note: Because all arrays in the pkg_* settings are shell arrays, they are whitespace delimited.

#### Download and Unpack Your Source Files

Add in the `pkg_source` value that points to where your source files are located at. Any `wget` url will work; however, unless you're downloading a tarball from a public endpoint, you may need to modify how you download your source files and where in your plan.sh you perform the download operation.

Chef Habitat supports retrieving source files from [GitHub](https://github.com). When cloning from GitHub, it is recommended to use https URIs because they are proxy friendly, whereas `git@github` or `git://` are not. To download the source from a GitHub repository, implement `do_download()` in your plan.sh (or `Invoke-Download` in a plan.ps1) and add a reference the `core/git` package as a build dependency. Because Chef Habitat does not contain a system-wide CA cert bundle, you must use the `core/cacerts` package and export the `GIT_SSL_CAINFO` environment variable to point the `core/cacerts` package on Linux. Here's an example of how to do this in the `do_download()` callback.

```bash
do_download() {
  export GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  git clone https://github.com/chef/chef
  pushd chef
  git checkout $pkg_version
  popd
  tar -cjvf $HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}.tar.bz2 \
      --transform "s,^\./chef,chef-${pkg_version}," ./chef \
      --exclude chef/.git --exclude chef/spec
  pkg_shasum=$(trim $(sha256sum $HAB_CACHE_SRC_PATH/${pkg_filename} | cut -d " " -f 1))
}
```

The plan.ps1 equivalent would be:

```powershell
Function Invoke-Download {
  git clone https://github.com/chef/chef
  pushd chef
  git checkout $pkg_version
  popd
  Compress-Archive -Path chef/* -DestinationPath $HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version.zip -Force
  $script:pkg_shasum = (Get-FileHash -path $HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version.zip -Algorithm SHA256).Hash.ToLower()
}
```

After you have either specified your source in `pkg_source`, or overridden the **do_download()** or **Invoke-Download** callback, create a sha256 checksum for your source archive and enter it as the `pkg_shasum` value. The build script will verify this after it has downloaded the archive.

> Note: If your computed value does not match the value calculated by the `hab-plan-build` script, an error with the expected value will be returned when you execute your plan.

If your package does not download any application or service source files, then you will need to override the **do_download()**, **do_verify()**, and **do_unpack()** callbacks. See [Callbacks]({{< relref "build_phase_callbacks" >}}) for more details.

#### Define Your Dependencies

Applications have two types of dependencies: buildtime and runtime.

Declare any build dependencies in `pkg_build_deps` and any run dependencies in `pkg_deps`. You can include version and release information when declaring dependencies if your application is bound to a particular version.

The package `core/glibc` is typically listed as a run dependency and `core/coreutils` as a build dependency, however, you should not take any inference from this. There are no standard dependencies that every package must have. For example, the mytutorialapp package only includes the `core/node` as a run dependency. You should include dependencies that would natively be part of the build or runtime dependencies your application or service would normally depend on.

There is a third type of dependencies, transitive dependencies, that are the run dependencies of either the build or run dependencies listed in your plan. You do not need to explicitly declare transitive dependencies, but they are included in the list of files when your package is built. See [Package contents]({{< relref "package_contents" >}}) for more information.

#### Override Build Phase Defaults with Callbacks

As shown in an example above, there are occasions when you want to override the default behavior of the hab-plan-build script. The Plan syntax guide lists the default implementations for [build phase callbacks]({{< relref "build_phase_callbacks" >}}), but if you need to reference specific packages in the process of building your applications or services, then you need to override the default implementations as in the example below.

```bash
pkg_name=httpd
pkg_origin=core
pkg_version=2.4.18
pkg_maintainer="The Chef Habitat Maintainers <humans@habitat.sh>"
pkg_license=('apache')
pkg_source=http://www.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=1c39b55108223ba197cae2d0bb81c180e4db19e23d177fba5910785de1ac5527
pkg_deps=(core/glibc core/expat core/libiconv core/apr core/apr-util core/pcre core/zlib core/openssl)
pkg_build_deps=(core/patch core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=serverport
)
pkg_svc_run="httpd -DFOREGROUND -f $pkg_svc_config_path/httpd.conf"
pkg_svc_user="root"

do_build() {
  ./configure --prefix=$pkg_prefix \
              --with-expat=$(pkg_path_for expat) \
              --with-iconv=$(pkg_path_for libiconv) \
              --with-pcre=$(pkg_path_for pcre) \
              --with-apr=$(pkg_path_for apr) \
              --with-apr-util=$(pkg_path_for apr-util) \
              --with-z=$(pkg_path_for zlib) \
              --enable-ssl --with-ssl=$(pkg_path_for openssl) \
              --enable-modules=most --enable-mods-shared=most
  make
}
```

In this example, the `core/httpd` plan references several other core packages through the use of the `pkg_path_for` function before `make` is called. You can use a similar pattern if you need reference a binary or library when building your source files.

Or consider this override from a plan.ps1:

```powershell
function Invoke-Build {
    Push-Location "$PLAN_CONTEXT"
    try {
        cargo build --release --verbose
        if($LASTEXITCODE -ne 0) {
            Write-Error "Cargo build failed!"
        }
    }
    finally { Pop-Location }
}
```

Here the plan is building an application written in Rust. So it overrides `Invoke-Build` and uses the `cargo` utility included in its buildtime dependency on `core/rust`.

> Note: Powershell plan function names differ from their Bash counterparts in that they use the `Invoke` `verb` instead of the `do_` prefix.

When overriding any callbacks, you may use any of the [variables]({{< relref "plan_variables" >}}), [settings]({{< relref "plan_settings" >}}), or [functions]({{< relref "build_helpers" >}}), except for the [runtime template data]({{< relref "service_templates" >}}). Those can only be used in Application Lifecycle hooks once a Chef Habitat service is running.

### Runtime Workflow

Similar to defining the setup and installation experience at buildtime, behavior for your application or service needs to be defined for the Supervisor. This is done at runtime through Application lifecycle hooks. See [Application Lifecycle hooks]({{< relref "application_lifecycle_hooks" >}}) for more information and examples.

If you only need to start the application or service when the Chef Habitat service starts, you can instead use the `pkg_svc_run` setting and specify the command as a string. When your package is created, a basic run hook will be created by Chef Habitat.

You can use any of the [runtime configuration settings]({{< relref "service_templates" >}}), either defined by you in your config file, or defined by Chef Habitat.

Once you are done writing your plan, use the studio to [build your package]({{< relref "pkg_build" >}}).

### Related Resources

- [Write plans]({{< relref "#writing-plans" >}}): Describes what a plan is and how to create one.
- [Add configuration to plans]({{< relref "config_templates" >}}): Learn how to make your running service configurable by templatizing configuration files in your plan.
- [Binary-only packages]({{< relref "binary_wrapper" >}}): Learn how to create packages from software that comes only in binary form, like off-the-shelf or legacy programs.

You may also find the [settings]({{< relref "plan_settings" >}}), [variables]({{< relref "plan_variables" >}}), and [functions]({{< relref "build_helpers" >}}) documentation useful when creating your plan.
