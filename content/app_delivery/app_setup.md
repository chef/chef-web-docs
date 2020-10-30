+++
title = "Setup your app"
draft = false

[menu]
  [menu.app_delivery]
    title = "Setup"
    identifier = "app_delivery/app_guide/app_setup"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 20
+++
[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_setup.md)

Everything you need to get started packaging applications is included with the Chef Habitat Command-Line Interface (CLI), including the Chef Habitat Studio. The Studio is a clean-room environment where you build packages and test them in an isolated environment. This ensures that the app you build in your development environment is exactly the same app that you deploy in production, including runtime dependencies.

## Home Directory

You'll work out of the home directory `/home/centos/`, unless otherwise indicated.

* Return to the home directory with `cd ~`
* Check your current directory with `pwd`

## Install Chef Habitat

Chef Habitat runs on Linux, Mac, and Windows, but for the purposes of this guide, you will need a Linux workstation.

Install Chef Habitat with:

```bash
curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash
```

This command downloads and installs the Chef Habitat in a single command. You can also download the `rpm` using `wget` or `curl` directly, and then install the package. See the [Chef Habitat docs](https://www.habitat.sh/docs/install-habitat/) for other installation methods.

### Accept the License

Once the installation finishes, you need to accept the End User-License Agreement (EULA) by entering `Y` on the command line before you can run any commands.

You can review the [EULA](https://www.chef.io/end-user-license-agreement/), but the important part is the difference between learning and commercial uses. If you are installing and using the software for learning purposes, such as completing the exercises in this guide or Learn Chef Rally tutorials, then you fall within the acceptable use guidelines for the EULA. However, if you start using the software commercially, then you'll need to have a license agreement with Chef Software Inc.

You can run the following command to accept the EULA and view the installed version of Chef Habitat:

```bash
Y
hab --version
```

### Create an Origin and Origin Keys

Chef Habitat stores your application packages inside of an origin, which you get to name. It uses origin keys to validate your application packages.

This command defines an origin and saves it as an environment variable:

```bash
export HAB_ORIGIN='myinitials_tryhab'
```

Finish setting up your system by generating origin keys or by adding an existing set of origin keys. For this guide, you should use the system defaults. For the default origin name, use your initials, first name, or preferred handle, for example "HC_tryhab". If you have existing origin keys, enter those when prompten. By the end of the guide, you'll have a public origin on Chef Habitat Builder under this name.

To generate your origin keys, enter the following command and answer the questions on the command line:

```bash
hab origin key generate
```

At the end, you should see something like:

```bash
Generating origin key for myinitials_tryhab
Generated origin key pair myinitials_tryhab-20200521200652.
```

Chef Habitat stores you origin keys in `~/.hab/cache/keys`. It uses these keys to sign packages that you will build later on. Keep in mind that you'll need access to these keys later to run your packages!

For more information, see the Chef Habitat [Keys](https://www.habitat.sh/docs/using-builder/#origin-keys) documentation.

## Clone the Demo App

You'll use a common Java sample application from a Chef GitHub repository for this guide. The app is packaged up as a `.war` file and deployed with Tomcat.

Clone the sample application to your local machine:

```bash
git clone https://github.com/chef-training/java-sample
```

### Demo App Contents

If you were to unpack the java application with the `jar -xvf sample.war` command, you would see the following contents:

```text
|-- META-INF
|   `-- MANIFEST.MF
|-- WEB-INF
|   |-- classes
|   |   -- mypackage
|   |   `-- Hello.class
|   |-- lib
|   |   `-- web.xml
|-- hello.jsp
|-- images
|   -- tomcat.gif
-- index.html
```

### Initialize the Demo App

Let's get started defining the instructions for how Chef Habitat should handle installing and deploying the Java application by defining a Habitat Manifest.

To get started, let's add a Habitat Manifest to your existing application that you cloned down. Make sure you're running this command within the application folder.

```bash
cd java-sample/
hab plan init
```

The `hab plan init` command adds a Chef Habitat Manifest Directory to the root of your application. A generic Manifest Directory for a packaged application has three parts: a `config.toml` file, the `habitat/` directory, and the `results/` directory. Your application won't have the `results` directory yet and it has two additional files: `sample.war` and `server.xml`.

#### Generic Manifest Directory Structure

The contents of the Manifest Directory will vary according to your application requirements. For example, a minimal manifest may not require any hooks or configuration templates at all, and these could be omitted.

```text
|-- config.toml
|-- habitat
|   |-- README.md
|   |-- config
|   |-- default.toml
|   |-- hooks
|   |-- plan.sh
|-- results
```

### Demo App Manifest Directory Structure

Your `java-sample` Manifest Directory should appear:

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
