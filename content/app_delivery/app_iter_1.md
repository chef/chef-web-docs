+++
title = "Define and Package App"
draft = false

[menu]
  [menu.app_delivery]
    title = "Define and Package"
    identifier = "app_delivery/app_guide/app_iter_1"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 50
+++
[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_iter_1.md)

Iteration 1: Defining and Packaging an Application with Habitat Studio

Let's get started defining the instructions for how Chef Habitat should handle installing and deploying the Java application by defining a Habitat Manifest.

The Habitat Manifest is typically added to the root of your application. It is typically structured in three parts: the  `habitat/` directory, the `results/` directory, and a `config.toml` file used for templating.

Common Habitat Manifest Directory Structure
|-- config.toml
|-- habitat
|   |-- README.md
|   |-- config
|   |-- default.toml
|   |-- hooks
|   |-- plan.sh
|-- results

The contents of the Manifest will vary according to your application requirements. For example, a minimal manifest may not require any hooks or configuration templates at all, and these could be omitted.

To get started, let's add a Habitat Manifest to your existing application that you cloned down. Make sure you're running this command within the application folder.

```bash
cd java-sample/
java-sample$ hab plan init
```

Your directory structure should now look like this:

```bash java-sample/
|-- config.toml
|-- habitat
|   |-- README.md
|   |-- config
|   |-- default.toml
|   |-- hooks
|   |-- plan.sh
|-- sample.war
|-- server.xml
```

## Packaging

Now you have created the necessary structure to begin packaging this application with Chef Habitat.

## Chef Habitat Studio

Chef Habitat ships with the Habitat Studio, a clean-room environment for building and testing Habitat Artifact files (.HART).

The Chef Habitat Studio is a self-contained, minimal environment that is free from any upstream operating system requirements, meaning that only the dependencies needed to run your application will be installed when the package is built. This minimizes unwanted dependencies, minimizes security gaps and eliminates the time-honored reasoning that "it worked on my machine". The Habitat Studio ensures that what is built in development is the exact same package loaded in production.

When Studio is loaded the environment is checked and validated as the required packages are loaded, including origin keys and licensing. After the clean room has been provisioned your development environment is all setup!

To start, let's load the Habitat Studio from within the java-sample-master directory.

```bash
hab studio enter
```

Because Chef Habitat only loads what necessary, the initial installation only contains the CLI, and additional components are downloaded as needed. The first time you run hab studio enter will take a little longer as it acquires the packages needed to load the Studio environment. This guide assumes that you have access to an internet connection and the bldr.habitat.sh domain to obtain these resources, although on-premise installations are possible.

### Navigating the Studio

```bash
/src
/hab
/etc
/bin
```

### Chef Habitat Plan File

The Habitat Plan file is what ties together a Habitat Manifest. The Plan defines important metadata about your application like it's name and version, and contains the definition for how the app should be packaged for delivery.

The hab plan init command pre-populates the plan.sh file with a number of functions that are commented out, with linked documentation to learn more about how to use them.

With Habitat you're trying to remove all the noise between your app and your automation so you've selected the most simple formats possible. In the case of Linux you'll be using Bash and while you don't need to be a bash expert knowing a few things helps accelerate you.

When you start writing a plan, you'll notice the extension is `.sh` meaning it's a BASH script.

### Bash Variables

You'll start with some simple variables. Habitat reserves some BASH variable names for its own use, like for example the name of your package.

```bash
pkg_name=sample
```

The bash variable `pkg_name` now has the value `sqlite`. Habitat will use this variables internally for metadata or various tasks, in this example you're setting the name of the package.

This is just a normal bash variable and you can use it later in your `plan.sh` as you'd expect. For example maybe I want to template out your package name so you can re-use this plan.

Wherever I need the package name, I can just use the variable like so:

```bash
${pkg_name}
```

To start off, erase everything in your `plan.sh `file except for the following:

```bash
pkg_name=java-sample
pkg_origin=INITIALS_tryhab
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_shasum="TODO"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc)

do_unpack() {
  do_default_unpack
}

do_build() {
  do_default_build
}

do_install() {
  do_default_install
}
```

The plan is a shell file, and values like `pkg_name`, `pkg_origin` and `pkg_version `will become bash variables. Chef Habitat reserves some variables like these for internal use, and you can use them freely within your Plan file.

After the basic definitions you'll find a list of functions you can uncomment to declare the build steps for your application.
Defining Build Instructions

A general overview of the build process looks like this:

```text
Phase 1: Locate and validate plan file
Phase 2: (do_begin...do_before) Check for optional pre-build steps, validate dependencies
Phase 3: (do_download...do_unpack) If package source is set, download and validate, and clean up remnants of previous builds before unpacking
Phase 4: (do_prepare...do_build) Set build environment variables and execute application-specific build logic
Phase 5: (do_check...do_install) run post-compile checks and move built artifacts to appropriate location for packaging
Phase 6: (_build_metadata...do_strip) copy config directories and strip binaries
Phase 7: (do_after...do_end) execute custom post-build steps, compress and sign artifact and clean up
```

### Common Build Plan Functions

Let's examine some common functions used within the Plan file.

Chef Habitat's build callbacks are a set of commands that make your code more readable and easier to use. Just like with variables, Habitat has some reserved Bash Function used in it's build process. You'll use a few in a moment, but these are just standard BASH functions you use to perform your needed tasks.

There are a number of functions that correspond to each build phase. For example, the do_build function builds your applications from source, and uses make by default to build an executable binary. If you're not building from source or your application can't be built with make then you can put the appropriate build commands in the function body.

If you wanted to skip any function like if you aren't building your app from source you can return a zero status within the body of the function, such as:

```bash
do_build() {
  return 0
}

do_unpack

do_install
```

After the source components are available, `do_install` can be used to move these items to the right places before they are packaged. Some components might only be needed during the build process and might be unnecessary afterwards.

Another common variable for use within a Plan is `${PREFIX}`, which contains anything that should be packaged into the resulting binary. During the packaging phase Chef Habitat replaces `${PREFIX}` with the dynamically generated artifact name, which by default appends the date timestamp from when the package was built.

### Package Dependencies
Within Plan files you can declare two types of dependencies: buildtime and runtime.

**Buildtime dependencies** are available within the Studio and are needed to package the application and are declared with `pkg_build_deps`.

**Runtime dependencies** are shipped with the binary, and are needed to run the application and are declared with `pkg_deps`.

There are no standard dependencies that a package must have. These are defined from what the application natively needs at buildtime or runtime. For example, `glibc` is a common runtime dependency, while `coreutils` is a common buildtime dependency and is usually not needed at runtime. However this all depends on the needs of the application.

**Transitive Dependencies** are installed as dependencies of buildtime `pkg_build_deps` or runtime `pkg_deps` and do not need to be explicitly declared. However, you will see them during the build process and in the `/hab/pkgs/` directory within the Studio.

### Core Plans
Chef Habitat has a number of core plans

Planning the Java Sample Application
In this guide you will build the application from the local .war file that you cloned locally. You will also need to install Java Runtime Environment 8, and Tomcat8 as dependencies to run the application, which you can obtain from the core packages provided by the Chef Habitat maintainers.

Update your plan as follows:

```bash
pkg_name=java-sample
pkg_origin=INITIALS_tryhab
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_shasum="TODO"
pkg_deps=(core/tomcat8 core/corretto11)

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  cp ${pkg_name}.war ${PREFIX}/
}
```

Notice that you are returning 0 (skipping) the `do_unpack` and `do_build` steps here, since you do not need to expand the application or build it with make. Because you already have the `.war` file available locally, you can simply package it with the binary and installation instructions with `do_install`. This simply requires copying the `.war` file to the `${PREFIX}` directory.

Save this file, and it's time to build and package the application!

### Packaging the Application

It's time to try packaging up this application. There's a good chance this step will fail when learning to package your application, so don't get discouraged! Remember you are building an installable artifact in this stage, so learning how to debug is a big part of the packaging process you'll review later.

Next, you'll build the package from within the Studio.

```
[1][default:/src:0]# build
   : Loading /src/habitat/plan.sh
   sample: Plan loaded
   sample: Validating plan metadata
...
   sample: Source Path: /src
   sample: Installed Path: /hab/pkgs/myinitials_tryhab/sample/0.1.0/20200324174336
   sample: Artifact: /src/results/myinitials_tryhab-sample-0.1.0-20200324174336-x86_64-linux.hart
   sample: Build Report: /src/results/last_build.env
   sample: SHA256 Checksum: 81dcee3296e1fade608d1fcb9da96d736ba4f0ab71779eee9916a70672a9743e
   sample: Blake2b Checksum: 21e8c9bdf11d654dedc4b576b05ae4f8a3bd6ac7ea71f1c4dcd5a7a705415e88
   sample:
   sample: I love it when a plan.sh comes together.
   sample:
   sample: Build time: 0m22s
``

Review the output and see if you understand what's going on. You should see Chef Habitat validating your Plan file, downloading and installing dependencies, building and signing the package, and finally generating the Habitat package artifact (.HART).

I love
A Habitat "Build" takes your application definition, runs the tasks you've defined like building from source or downloading your software. Then packages that with it's instructions in a signed/compressed artifact you call a Habitat Artifact or .hart.

You've successfully packaged your application if you see:
 "I love it when a plan.sh comes together"
Packaging a Chef Habitat Artifact (.hart) in the Habitat Studio

The Habitat Studio environment makes it easy to test the artifact in a few ways:

All successful builds are stored in the results/ directory
A helper file containing useful environment variables for the latest build is available at results/last_build.env . You can source this file to make testing easier, meaning you won't have to figure out the latest time stamped version manually. You'll show you how to use these values shortly.

[default:/src:0]# cat results/last_build.env
pkg_origin=myinitials_tryhab
pkg_name=sample
pkg_version=0.1.0
pkg_release=20200324174336
pkg_target=x86_64-linux
pkg_ident=myinitials_tryhab/sample/0.1.0/20200324174336
pkg_artifact=myinitials_tryhab-sample-0.1.0-20200324174336-x86_64-linux.hart
pkg_sha256sum=81dcee3296e1fade608d1fcb9da96d736ba4f0ab71779eee9916a70672a9743e
pkg_blake2bsum=21e8c9bdf11d654dedc4b576b05ae4f8a3bd6ac7ea71f1c4dcd5a7a705415e88

The package has also been "installed" locally within the testing environment. This means the Habitat Supervisor has unpacked the .HART file that was just built and placed in on disk. While this initially might seem unproductive, the behavior is meant to show you exactly what was packaged during the last build within the Studio environment.

You will find the latest successful build installed under /hab/pkgs/PKG_IDENT, with PKG_IDENT found inside the results/last_build.env file. These variables are very helpful when your pipeline tool manages your builds.

Remember that this environment is destroyed when you exit the Studio!

Chef Habitat Studio: Results/Directory
|-- results
|   |-- last_build.env
|   |-- MYORIGIN-PACKAGE_NAME-0.1.0-20200309174347-x86_64-linux.hart

Origin-package_name-version-timestamp-platform.hart
PKG_ORIGIN-PKG_NAME-PKG_VERSION-TIMESTAMP-PLATFORM.hart
or
PKG_IDENT-platform.hart
or
PKG_ARTIFACT.hart
Chef Habitat Studio: Sourcing the Latest Build
To make it easy to work with your last build there are a number of environment variables stored in results/last_build.env . Sourcing this file makes it easier to type commands without having to manually figure out the timestamp of the latest and greatest build.

First, source the latest build:

[default:/src:0]# source results/last_build.env

And now you can easily refer to the location of your Habitat Artifact using the $PKG_ARTIFACT variable, or use the $PKG_IDENT variable to examine the installed artifact.
Chef Habitat Studio: Auto-Installation
To verify your package results, let's take a look at where the Studio auto-installed the last successful build.

[default:/src:0]# ls /hab/pkgs/$pkg_ident
DEPS  FILES  IDENT  MANIFEST  RUNTIME_ENVIRONMENT  RUNTIME_ENVIRONMENT_PROVENANCE  RUNTIME_PATH  TARGET  TDEPS  config  default.toml  hooks  sample.war  server.xml

Notice your sample.war file is right there in the root of the installed package. Well done!

There are a number of other things in the installed package directory. Which of these folders make sense to you so far? Do you understand the components of the DEPS and TDEPS folders? You'll learn more about config, hooks, and the default.toml components as you go.

It should be made clear that the /hab/pkgs/ directory is a no-touch zone for humans. Only Chef Habitat should manage what ends up here for repeated, reliable packaging. That's what makes a package "immutable", meaning that a package built within the Studio will not change when it's deployed on another system.
Chef Habitat Studio: Loading the Application
Although the Habitat Artifact was unpacked on disk under the /hab/pkgs/ folder after the successful build, that doesn't mean the package was loaded as a running service using the Habitat Supervisor. Next you'll attempt to load the installed application inside the Studio.
Chef Habitat Studio: Running the Supervisor
To test a package within the Habitat Studio you need to load it as a service. It's important to note that this is the exact same process that will be followed by production nodes running Chef Habitat code later on, whether packages are delivered as .HART files or exported to another format, like a Docker container.

Think of the Supervisor as a process manager, much like PID 1 in Linux. The Supervisor is responsible for two things:

Starting and monitoring the service that's defined in the Habitat package.
Receiving and acting upon configuration changes from other Supervisors.

Now let's see what happens when you load your package as a running service.

### Chef Habitat Studio: Loading a Service

```bash
[default:/src:0]# hab svc load $pkg_ident
...
[Err: 0] Package is not runnable: myinitials_tryhab/sample/0.1.0/20200324174336
```

Uh-oh. Although the package was successfully built, it doesn't run! This scenario will feel familiar to anyone who has packaged up binaries or executables before, and it's why the Studio is a great environment for building and testing applications.
Chef Habitat Studio: Troubleshooting a Run Failure
To get a little more information about why the package won't run, you should check out the Supervisor logs to see what went wrong:

```bash
[default:/src:0]# sup-log
Tailing the Habitat Supervisor's output (use 'Ctrl+c' to stop)
Using core/zlib/1.2.11/20190115003728
Installed core/hab-launcher/13458/20200318174911
Install of core/hab-launcher/13458/20200318174911 complete with 1 new packages installed.
Logging configuration file '/hab/sup/default/config/log.yml' not found; using default logging configuration
hab-sup(MR): core/hab-sup (core/hab-sup/1.5.0/20200122225210)
hab-sup(MR): Supervisor Member-ID c5380b47f33c4506b88f2b8093b6127c
hab-sup(MR): Starting gossip-listener on 0.0.0.0:9638
hab-sup(MR): Starting ctl-gateway on 127.0.0.1:9632
hab-sup(MR): Starting http-gateway on 0.0.0.0:9631
hab-sup(UT): Can't start non-runnable service: myinitials_tryhab/sample/0.1.0/20200324174336
```

The first thing you notice here is at the end of the output: Can't start non-runnable service.

Remember that for your Java application Tomcat is responsible for running your .war file. To allow Tomcat to run as a service, Chef Habitat will need to copy the installed dependency to it's running service variable directory, usually located at /hab/svc.

After Tomcat is available, you'll then need to copy the .war file into Tomcat's tc/webapps/ directory, where it can be automatically loaded. If you're unfamiliar with how Tomcat loads services you can learn more at https://tomcat.apache.org/tomcat-8.0-doc/ .

As you continue enhancing your build you can add more complexity that customizes where and how the application should be delivered. You can use components like runtime hooks, configuration variables and templating to create robust deployments. Next, you'll add a hook to ensure that Tomcat can deploy your .war file.
