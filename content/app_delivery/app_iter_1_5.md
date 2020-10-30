+++
title = "Build your App"
draft = false

[menu]
  [menu.app_delivery]
    title = "Build"
    identifier = "app_delivery/app_guide/app_iter_1_5"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 55
+++
[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_iter_1.5.md)

In this stage, you will try packaging your Chef App Delivery demo application. Just like a real build, there's a good chance this step will fail on your first attempt at packaging your application. Learning how to debug is a big part of learning how to package an app.

A Chef Habitat "Build" takes your application definition, runs the tasks you've defined in your plan, such as building from source or downloading your software. It then combines the software package with its instructions into a signed and compressed artifact, which is called a Habitat Artifact or `.hart` file.

The Chef Habitat build process generally has seven phases:

- **Phase 1**: Locate and validate plan file
- **Phase 2**: _do\_begin()...do\_before()_. Checks for optional pre-build steps, validate dependencies
- **Phase 3**: _do\_download()...do\_unpack()_. If a package source is set, download and validate, and clean up remnants of previous builds before unpacking
- **Phase 4**: _do\_prepare()...do\_build()_. Sets build environment variables and execute application-specific build logic
- **Phase 5**: _do\_check()...do\_install()_. Runs post-compile checks and move built artifacts to appropriate location for packaging
- **Phase 6**: _build\_metadata()...do\_strip()_. Copies config directories and strip binaries
- **Phase 7**: _do\_after()...do\_end()_. Executes custom post-build steps, compress and sign artifact and clean up

## Build your App

You'll build your app inside the Studio. From the Studio command prompt, run the `build` command:

```
build
```

The build process may take several seconds. Review the output and see if you understand what is happening during the build. You should see Chef Habitat validating your Plan file, downloading and installing dependencies, building and signing the package, and finally generating the Habitat package artifact (.HART).

You've successfully packaged your application if you see:
 "I love it when a plan.sh comes together"You should see output similar to:

You should see output similar to:

```txt
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

## Testing a Chef Habitat Artifact in the Habitat Studio

The Habitat Studio environment makes it easy to test your artifact in a few ways:

- All successful builds are stored in the results/ directory
- A helper file containing useful environment variables for the latest build is available at `results/last_build.env`. You can source this file to make testing easier, meaning you won't have to figure out the latest time stamped version manually.

```bash
cat results/last_build.env
```

Returns:

```text
pkg_origin=myinitials_tryhab
pkg_name=sample
pkg_version=0.1.0
pkg_release=20200324174336
pkg_target=x86_64-linux
pkg_ident=myinitials_tryhab/sample/0.1.0/20200324174336
pkg_artifact=myinitials_tryhab-sample-0.1.0-20200324174336-x86_64-linux.hart
pkg_sha256sum=81dcee3296e1fade608d1fcb9da96d736ba4f0ab71779eee9916a70672a9743e
pkg_blake2bsum=21e8c9bdf11d654dedc4b576b05ae4f8a3bd6ac7ea71f1c4dcd5a7a705415e88
```

The package is automatically "installed" locally in the testing environment. This means the Habitat Supervisor has already unpacked the `.hart` file and placed in on disk, which will help you see exactly what was packaged during the last build. Chef Habitat destroys this environment when you exit the Studio.

The latest successful build is installed under `/hab/pkgs/PKG_IDENT`, where `PKG_IDENT` is the same value as the one in the `results/last_build.env` file. These variables are helpful when you use an automated pipeline tool to manage your builds.

```text
Chef Habitat Studio: Results/Directory
|-- results
|   |-- last_build.env
|   |-- MYORIGIN-PACKAGE_NAME-0.1.0-20200309174347-x86_64-linux.hart
```

```text
Origin-package_name-version-timestamp-platform.hart
PKG_ORIGIN-PKG_NAME-PKG_VERSION-TIMESTAMP-PLATFORM.hart
or
PKG_IDENT-platform.hart
or
PKG_ARTIFACT.hart
```

### Sourcing the Latest Build

To make it easy to work with your last build there are a number of environment variables stored in `results/last_build.env`. Sourcing this file makes it easier to type commands without having to manually figure out the timestamp of the latest build.

First, source the latest build:

```bash
source results/last_build.env
```

You can easily refer to the location of your Habitat Artifact using the $PKG_ARTIFACT variable, or use the $PKG_IDENT variable to examine the installed artifact.

## Auto-Installation

To verify your package results, let's take a look at where the Studio auto-installed the last successful build.

```bash
ls /hab/pkgs/$pkg_ident
```

Should output:

```text
DEPS  FILES  IDENT  MANIFEST  RUNTIME_ENVIRONMENT  RUNTIME_ENVIRONMENT_PROVENANCE  RUNTIME_PATH  TARGET  TDEPS  config  default.toml  hooks  sample.war  server.xml
```

Notice your `sample.war` file is installed at the root of the package. Well done!

There are a number of other things in the installed package directory. Which of these folders make sense to you so far? Do you understand the components of the `DEPS` and `TDEPS` folders? You'll learn more about config, hooks, and the `default.tom`l components as you go.

It should be made clear that the `/hab/pkgs/` directory is a "hands-free" zone for humans. for repeated, reliable packaging, only Chef Habitat should manage these contents. This automation makes your package "immutable", which means that a package built in the Studio doesn't change when it is deployed on another system.

### Load the Application

Although the Habitat Artifact was unpacked on disk under the `/hab/pkgs/` folder after the successful build, that doesn't mean the package was loaded as a running service using the Habitat Supervisor. Next you'll attempt to load the installed application inside the Studio.

#### Run the Supervisor

To test a package within the Habitat Studio you need to load it as a service. It's important to note that this is the exact same process that will be followed by production nodes running Chef Habitat code later on, whether packages are delivered as `.hart` files or exported to another format, such as a Docker container.

A Supervisor is a process manager, much like PID 1 in Linux.
The Supervisor is responsible for two things:

- Starting and monitoring the service that's defined in the Habitat package.
- Receiving and acting upon configuration changes from other Supervisors.

#### Load a Service

Let's see what happens when you load your package as a running service.

```bash
hab svc load $pkg_ident
```

Oh, no! The command returns somthing like:

```text
...
[Err: 0] Package is not runnable: myinitials_tryhab/sample/0.1.0/20200324174336
```

Even though the package built successfuly, it doesn't run! This scenario will feel familiar to anyone who has packaged up binaries or executables before, and it's why the Studio is a great environment for building and testing applications.

## Troubleshooting a Run Failure

To get a little more information about why the package won't run, you should check the Supervisor logs to see what went wrong.

View the Supervisor logs with:

```bash
sup-log
```

Your output should be similar to:

```text
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

Notice the line at the end of the output: `Can't start non-runnable service.`

Tomcat is responsible for running the `.war` file in your Java application. To allow Tomcat to run as a service, Chef Habitat will need to copy the installed dependency to its running service variable directory, usually located at `/hab/svc`.

After Tomcat is available, you'll then need to copy the `.war` file into Tomcat's `tc/webapps/` directory, where it can be automatically loaded. If you're unfamiliar with how Tomcat loads services you can learn more at https://tomcat.apache.org/tomcat-8.0-doc/ .

As you continue enhancing your build you can add more complexity that customizes where and how the application should be delivered. You can use components like runtime hooks, configuration variables and templating to create robust deployments. Next, you'll add a hook to ensure that Tomcat can deploy your `.war` file.
