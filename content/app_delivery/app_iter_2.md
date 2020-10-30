+++
title = "Define Runtime Instructions"
draft = true

[menu]
  [menu.app_delivery]
    title = "Runtime"
    identifier = "app_delivery/app_guide/app_iter_2"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 60
+++
[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_iter_2.md)

In this iteration you'll focus on getting the application running under the Chef Habitat Supervisor. You've been able to build the application successfully, but how do you configure Tomcat properly once the service has been loaded?

While your application is now packaged and your dependencies are installed, you still have to run your `.war` file with Tomcat. Another way to think of this would be that the application needs to be initialized, and then run.

## Tomcat Background

To initialize Tomcat the service must be installed to the Chef Habitat running service variable directory, usually `/hab/svc`/ on disk. All services that should be managed need to be located here. Additionally, your `.war` file needs to be copied into the tomcat webapps directory, which will in turn be located under `/hab/svc/tc/webapps/`.

After these pieces are in the appropriate place on-disk Catalina can be run by starting the script located at `/hab/svc/tc/bin/catalina.sh`.

As an expert in your application, you need to understand the steps needed to set up and run your app. From Chef Habitat's point of view, you need to have those pieces located on-disk in the correct places, but otherwise the steps for running the application are the same.

You can write these instructions using Application Lifecycle hooks, which describe how the application should be initialized and run. Many other hooks exist, such as health checks.

## Application Lifecycle hooks

_Application Lifecycle hooks_ (referred to as "hooks") are event handlers that you use to perform specific actions during a service's runtime. These are scripts that are called when an event is triggered. You can access any of Chef Habitat's runtime settings within a hook.

hooks use a templating language called Handlebars to access variables and user-defined configurations. For example, you can access the running service variable directory `/hab/svc/` with the variable `pkg.svc_var_path`. You can reference these variables in a hook by surrounding them with two sets of curly brackets:

```handlebars
{{pkg.svc_var_path}}
```

This variable resolves to `/hab/svc/` within a hook anywhere it is used. Any runtime configuration setting can be used here to easily reference Chef Habitat internals, such as `{{pkg.origin}}`, `{{pkg.name}}`, and `{{pkg.path}}`.

You start by parsing the steps needed to initialize the app, and how those steps can be described between different applications you manage with Chef Habitat. You'll first use these runtime configuration variables to set up a hook to manage the application's initialization phase.

### init hook

`init` hooks are instructions that the Supervior executes first when it starts loading your service. If the service is unloaded, then the Supervisor runs the instructions first the next time it starts the service.

To get Tomcat running, you need to add three files to the running service directory, `/hab/var/`, also known as `{{pkg.svc_var_path}}`, with an `init` hook:

1. Copy the tomcat8 package to `/hab/svc/`
1. Copy the `sample.war` file to `/hab/svc/tc/webapps/`
1. Link the templatized `server.xml` to `/hab/svc/tc/conf/server.xml`

Within the `habitat/hooks/` directory, create a new file called `init`, without a file extension. Your directory structure should now look like this:

```text
|-- habitat
|   |-- README.md
|   |-- config
|        |-- server.xml
|   |-- default.toml
|   |-- hooks
|   |   -- init
|   -- plan.sh
|-- results
|   |-- last_build.env
|   -- myinitials_tryhab-sample-0.1.0-20200324174336-x86_64-linux.hart
-- sample.war
```

The new `init` file is simply a shell script, so you'll start with a shebang. Add these three lines to the file:

```bash
# #!/bin/bash -x

# Copy Tomcat directory from core/tomcat to /hab/svc/
cp -a {{pkgPathFor "core/tomcat8"}}/tc {{pkg.svc_var_path}}/

# Copy sample.war to /hab/svc/tc/webapps/
cp {{pkg.path}}/*.war {{pkg.svc_var_path}}/tc/webapps
```

Let's break this script down line-by-line.

1. The first line is simply a bash shebang, with an `-x` that instructs bash to print the output of all actions and commands that are run, which is useful for debugging hooks.
1. The first command copies the installed Tomcat8 package to the service variable path.
1. The second command copies the package to the service varable path.

This script makes use of two new concepts:

### Plan Helpers

`pkgPathFor` is a plan helper. These are simple functions that you can use in a plan file or hook. Plan helpers can be simple, such as`toLowercase` or `toUppercase` for string manipulation. Some plan helpers are complex, such as `pkgPathFor`, which returns the absolute filepath to the package directory, in this case `/hab/svc/sample/var`.

#### Template Data

`{{pkg.svc_var_path}}` is a template data value. These values let you reference paths that might be relative when you need to compare two different apps that you are packaging with Chef Habitat. In this example, `{{pkg.svc_var_path}}` references the target location for copying the Tomcat service directory, which will be `/hab/svc/sample/var/tc/` on disk.

In the second command the `{{pkg.path}}` directory corresponds to the location of the local package, which is `/hab/pkgs/myinitials_tryhab/sample/0.1.0/20200324170256/`. Using `{{pkg.path}}` makes it easy to identify this path for any build. This line copies the `sample.war` file into `/hab/svc/sample/var/tc/webapps/` directory.

### run hook

Now that Tomcat and the `sample.war` file have been copied into the running service variable directory `/hab/svc`, you can start Tomcat with a run hook.

To specify how the application should run you create a completely separate shell script. Add a new file called run to your `habitat/hooks/` directory right alongside your `init` hook.

A `run` hook is executed if any of these events occur:

A service is loaded, after the `init` hook has been called.
When a package is updated, after the `init` hook has been called.
When the package config changes, after the `init` hook has been called

Within any run hook a command should be called using `exec` instead of running the command directly to ensure it's run within the same process as the hook and that services will restart correctly if a configuration change is applied.

Within this file add the following to run Catalina and start Tomcat:

```bash
#!/bin/bash

# Redirect stderr to stdout
exec 2>&1

# Run Tomcat
exec {{pkg.svc_var_path}}/tc/bin/catalina.sh run
```

A common practice within the run hook is to redirect the standard error output (`stderr`) to the standard output (`stdout`). This means that your application's specific logs and error reporting won't get lost within the Supervisor's output, and you can view out application's native output using commands like `sup-log`. Without this you may miss out on important debugging information that comes directly from the application running under Chef Habitat, so include it at the start of any run hook you create.

After saving this file you're ready to rebuild the application and see if the service loads.

## Re-Package the Application

Here you attempt to rebuild the application and check if your changes are applied:

```
build
```

The build should complete, and you'll notice a new Chef Habitat artifact (`.hart `file) in your `results/` directory.

## Troubleshooting a Build

Iterating on your application build is the heart of delivering your `.hart`. Learning how to skillfully debug is a crucial part of being effective with Chef Habitat, and this will take practice.

The two most common places you'll be debugging are:

- During the build process within the Habitat Studio
- Executing hooks when the Supervisor loads a service

Check out the appendix to see examples of techniques used for debugging in the context of the sample application.

#### Attach

Attach is your friend

When you execute Habitat Build, you'll run through all the steps you define in order and perform any defined actions. You'll also run through some internal things like the generated metadata and signing the package.

Attach is a utility in BASH that let's is break the execution in place and investigate what's going on.

Let's take the do_install step from earlier, maybe I saw a failure and I'm not sure if I have the right path or the right variable name. You can stop the execution of a build right before your do_install step will take place, like so:

```bash
do_install() {
  attach
  cp ${pkg_name}.war ${PREFIX}/
}
```

Now that you're inline with the execution let's checkout the value of your variable when running build within the Studio:

```bash
build
```

### Attaching to debugging session

From: `/src/habitat/plan.sh` @ line 18 :

```bash
    8:
    9: do_unpack() {
    10:   return 0
    11: }
    12:
    13: do_build() {
    14:   return 0
    15: }
    16:
    17: do_install() {
 => 18:   attach
    19:   cp ${pkg_name}.war ${PREFIX}/
    20: }

[1] sample(do_install)>
```

With attach you have essentially paused the build process, allowing you to check out the current state. Type help at anytime to see what commands are available within this prompt:

```bash
[1] sample(do_install)> help
```

You have the ability to query the available variables and functions within the context of a current build:

```bash
[2] sample(do_install)> echo $pkg_name
sample
[3] sample(do_install)> echo $HAB_PKG_PATH
/hab/pkgs
[4] sample(do_install)> echo $PLAN_CONTEXT
/src/habitat
```
You can also checkout out current path:

```bash
[5] sample(do_install)> pwd
/src
```

Let's also check what's in your directory:

```bash
[6] sample(do_install)> ls
habitat  results  sample.war
```

Just like within the Studio's normal context, you can do things like install packages and use them while in an attached state.

If you want to cancel the current build you can use exit-program. Or if you want to continue the build and generate an artifact you can use exit to move up out of the context of the current function, which in this case will finish the build:

```bash
[7] sample(do_install)> exit
...
   sample: I love it when a plan.sh comes together.
   sample:
   sample: Build time: 17m50s
```

## Intermediate Studio Logic

<<<need a transition here or is this a note>>>

Remember that after a successful build the artifact is auto-installed, however the Supervisor will not automatically load the new service (this can be changed).

To load the latest package on-disk you need to unload and load the service:

```bash
hab svc unload myinitials_tryhab/sample
hab svc load myinitials_tryhab/sample
```

When checking the supervisor logs, you should now see that Catalina started successfully:

```bash
sup-log

...

sample.default(E): 30-Mar-2020 20:43:32.957 INFO [main] org.apache.catalina.startup.Catalina.start Server startup in 1018 ms
```

Now you're in business! Let's check to see what's hosted on port 8080, the default for the sample app:

```bash
curl localhost:8080/sample
bash: curl: command not found
```

Remember, the Chef Habitat Studio is a minimal clean-room environment, and only the packages you need get installed. It doesn't even come with `curl` or `wget`!

To obtain these you could install them from some binary and move them to the Studio's `/bin/` directory, or you can simply grab from the core Habitat packages:

```bash
hab pkg install core/curl
```

You will now notice that `curl` is available under `/hab/pkgs/curl`, and you could call the executable from there. But if you simply want to use curl as a utility, you'll need to bin-link the package to the `/bin/` directory. You can do this in a single step with the `-b` option for `hab pkg install`:

```bash
hab pkg install core/curl -b
```

Now you will see curl and curl-config located in the /bin/ directory, and you'll be able to use the curl utility directly:

```bash
curl localhost:8080/sample
```

You should now see the request is processed, even though no output is returned. Well done! The application is being served by Tomcat.
