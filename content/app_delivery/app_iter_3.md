+++
title = "Define Application Configuration"
draft = false

[menu]
  [menu.app_delivery]
    title = "Configure"
    identifier = "app_delivery/app_guide/app_iter_3"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 70
+++
[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_iter_3.md)

Iteration 3: Defining Configurations
While you want to get the application up and running quickly, you should also consider what tunables will be important for future behavior modifications. For example changing the port Tomcat hosts the application on is a value that should be easily configured.

## Configuration Templates

Templates for your application's native configuration files are easy to add to your Chef Habitat Manifest. This provides tunable configuration elements to your application or service that can be used at buildtime during the generation of a Habitat Artifact, or consumed by Hooks to make runtime configuration changes on the fly.

The goal of this section is to configure Tomcat to serve up your application, and set up your application to receive build and runtime configuration changes.

First, you should understand that the tc/conf/server.xml file is the configuration file for the Tomcat service and describes what should be hosted. You need to create a template for this file that you can configure on the fly.

This generic file is available in the java-sample-master/ directory you cloned down at the beginning of this guide, next to your .war file. You will move this file into your Chef Habitat Manifest, and then update the file to accept a configuration change.

### Defining Configurations: Configuration Templates
Templates are stored in the Manifest's config/ directory. All files located here can have template variables added to them if desired. After a build these files are rendered to a config directory, /hab/svc/<pkg_name>/config/ for the running service, and are re-written when a template value changes.

To start, move the provided server.xml template into the config directory:

[default:/src:0]# mv server.xml habitat/config/

Within this file you can find the configuration value for the port on line 67:

    <Connector port="{{cfg.server.port}}" protocol="HTTP/1.1"

Normally this file has the Connector port value hard-coded, but Chef Habitat can use Handlebars syntax within templates to declare configuration elements. This syntax uses double-curly braces to declare elements, and then each element is pre-fixed with cfg.

These values can be tuned by a user at runtime, or at buildtime using the default.toml file.

### Defining Configurations: default.toml

All cfg values referenced by templates can have their values pre-defined for buildtime in the default.toml file. This file uses a simple syntax to declare key-value pairs that are accessed in templates using dot syntax. Looking at the predefined template value above:

Key = server
Value = port

Open the default.toml file, and add the following to declare a key-value pair:

```bash
[server]
port = "8000"
```

This value will be rendered as any values in this file are rendered within templates as {{cfg.key.value}}, which is where the {{cfg.server.port}} comes from on line 67 of habitat/config/server.xml.

You've successfully added your first template value to your Manifest!

## Defining Configurations: Template Variables

### Defining Configurations: Updating the init Hook

Now that you have a template being generated for server.xml, you need to copy the config file into the tomcat service directory tc/conf/ to replace it's default configuration. This should be done as a part of the initialization phase for your app in your init Hook. But rather than copying the file when the hook runs you can simply link it to the generated template. This way if you want to regenerate the template while the service is loaded your changes can be applied without having to re-run the hook and copy the file.

Add this line to your init Hook:

```bash
ln -vsf {{pkg.svc_config_path}}/server.xml {{pkg.svc_var_path}}/tc/conf/server.xml
```

This command sets up the Tomcat service using the `server.xml` file. The `pkg.svc_config_path` is where all files from the `habitat/config/ directory` are rendered, and will be `/hab/svc/sample/config/` on disk. This allows us to link your rendered templates to where they belong for the Tomcat service, `/hab/svc/sample/var/tc/conf/server.xml`. You're using a link instead of copying the file so that configuration updates can be made on the fly.

Now let's go ahead and rebuild the package and load the service, but this time you'll take a different approach and load the package outside the Studio in a new format.

## Re-Packaging the Application

Rebuild the package in the Studio and test that it works by unloading and reloading the sample service. If you need help here refer back to the second iteration. You should see the app being hosted on the new port you defined in the default.toml file if you check the Supervisor logs.

In addition to packaging your application in the standard Habitat Artifact (.hart) format, you can export your packages to a number of formats for use in different scenarios. While your production loads will likely be using the Supervisor to apply update strategies across your application servers, sometimes you may want packages to be available in other formats like a tarball or docker image.

## Additional Topics

### Chef Habitat Artifact Export Formats

This section is optional, depending on whether you have the capability of installing Docker into your test environment. Refer back to the installation guide at the beginning of the document if you'd like to install Docker-CE and follow along.

You can export to a number of formats, and you'll will see the required core packages being downloaded to enable the export. Let's try exporting to a Docker container:

```bash
[default:/src:0]# source results/last_build.env
[default:/src:0]# hab pkg export docker results/$pkg_artifact
...
Successfully built db5922196682
Successfully tagged tryhabitat/sample:0.1.0-20200331211504
Successfully tagged tryhabitat/sample:0.1.0
Successfully tagged tryhabitat/sample:latest
☒ Deleting temporary files
★ Docker image 'tryhabitat/sample' created with tags: 0.1.0-20200331211504, 0.1.0, latest
```

Now you can exit the studio and test out the new Docker image.

```bash
[default:/src:0]# exit
logout

java-sample$ docker images
REPOSITORY                            TAG                    IMAGE ID            CREATED             SIZE
myinitials_tryhab/sample                     0.1.0                  db5922196682        17 minutes ago      493MB
myinitials_tryhab/sample                     0.1.0-20200331211504   db5922196682        17 minutes ago      493MB
myinitials_tryhab/sample                     latest                 db5922196682        17 minutes ago      493MB
habitat/default-studio-x86_64-linux   1.5.71                 4059cb64c913        2 weeks ago         434MB
```

Notice that the `myinitials_tryhab/sample` image is listed three times and refers to the same Image ID, just with different tags.

You can run this container and see that it performs as expected:

```bash
java-sample$ docker run -it myinitials_tryhab/sample
```

You will be prompted to accept the license agreement for Chef Habitat again, and after answering "yes" you should see the service being loaded as expected.

### Loading Packages Outside The Studio

While package exports are useful under certain circumstances, usually you'll be loading Habitat Artifacts on production systems using the Supervisor, but outside of the Studio clean room.

To accomplish this you simply need to ensure Chef Habitat is installed on the target system and that the Supervisor components are available. Habitat Artifacts can then be loaded and managed just like when in the Studio, expect using root privileges. Let's give this a shot.

First, ensure you are outside of the Studio. Then when the Supervisor is called the necessary components will be downloaded:

```bash
java-sample$ source results/last_build.env
java-sample$ sudo hab sup run results/$pkg_artifact
...
★ Install of core/hab-launcher/13606/20200420202330 complete with 1 new packages installed.
Logging configuration file '/hab/sup/default/config/log.yml' not found; using default logging configuration
hab-sup(MR): core/hab-sup (core/hab-sup/1.6.0/20200420202331)
hab-sup(MR): Supervisor Member-ID 052a215221b24be9a38db72aa730819a
» Installing results/rab-tryhab-sample-0.1.0-20200427214706-x86_64-linux.hart
☛ Verifying rab-tryhab/sample/0.1.0/20200427214706
↓ Downloading rab-tryhab-20200427214647 public origin key
[404 Not Found]
[2020-04-27T21:58:55Z ERROR hab_launch] Launcher exiting with code 86
```

Although the package installation executes correctly, notice that you get an error corresponding to your public origin key, stating that it cannot be found. This may be a little counterintuitive since your keys were generated long ago with hab origin key generate, but notice that you are running the Habitat Supervisor as root with sudo hab sup run. This is necessary for the Supervisor to manage loading services and installing components as needed. But this also means that the Supervisor is attempting to load keys from the /hab/cache/keys/ directory, and not ~/.hab/cache/keys/ where the keys were generated.

You can easily fix this by copying your keys to the root location:

```bash
java-sample$ sudo cp -r ~/.hab/cache/keys/* /hab/cache/keys/
```

Because most services run as the hab user by default, you'll also need to create a user called hab to run your service, and add it to the hab group.

```bash
java-sample$ sudo groupadd hab
java-sample$ sudo useradd -g hab hab
```

Now you can attempt to load the tryhab sample app again:

```bash
java-sample$ sudo hab sup run results/$pkg_artifact
```

Now you should be able to open a new terminal window and check that tomcat is running on the default port defined in the default.toml (probably 8000) and that the /sample endpoint doesn't return a 404:

```bash
java-sample$ curl localhost:8000/sample
```

### Runtime Configuration Updates

One of Chef Habitat's features is the ability to dynamically update a service's configuration at runtime, even though you are building immutable packages within the Studio. Default configurations can always be overwritten if the service variables have been declared using Handlebars syntax.

Default values are usually declared in the user.toml file. These can be overwritten when the service is started by providing an updated value to the hab svc load or hab run commands. However you can also update a service that's already running under the Supervisor.

To change a configuration value on the fly, define an environment variable and pass it to the Supervisor with hab config apply. With the service already loaded outside of the Studio, let's attempt to change the Tomcat port:

```bash
java-sample$ echo 'port = 9001' | sudo hab config apply
error: The following required arguments were not provided:
    <SERVICE_GROUP>
    <VERSION_NUMBER>
```

Because the Supervisor is capable of running multiple services at once it sets a loaded service into a "group". When applying configuration updates to a running service the Supervisor needs to know what Service Group the update applies to.

You also need to give your update a "version". This is incremental, and intended to ensure outdated configurations are not set. Although any number greater than the previous version can be used (like 1, then 2, then 3, etc), the simplest way to ensure a new configuration is applied properly is to use a timestamp as the version.

Let's grab the service group by checking the status of the Supervisor:

```bash
$ java-sample$ sudo hab sup status
package     type        desired  state  elapsed (s)  pid   group
$pkg_ident  standalone  up       up     447          7200  sample.default
```

With the group as sample.default, you know how to apply your configuration changes. Let's do this and use the same timestamp format you use for package naming as the version for your update:

```bash
$ java-sample$ echo 'server.port = 9001' | sudo hab config apply sample.default $(date +'%Y%m%d%H%M%S')

» Setting new configuration version 20200427225542 for sample.default
Ω Creating service configuration
↑ Applying via peer 127.0.0.1:9632
★ Applied configuration
```

If all goes well, you should now be able to check for the sample app on the new port:

```bash
java-sample$ curl localhost:9001/java-sample
```

If you were to switch back to the other terminal you would see the Supervisor output as it updated the running service:

```bash
hab-sup(CMD): Setting new configuration version 20200427225542 for sample.default
```
You can also check the Supervisor logs ourselves outside of the Studio by looking at journalctl:

```bash
java-sample$ sudo journalctl -u sample.default
```
