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

Everything you need to get started packaging applications is included with the Chef Habitat Command-Line Interface (CLI). This will include a clean-room environment to build packages and test them in an isolated fashion, ensuring that what you build in a development environment will exactly match what gets deployed in production, including runtime dependencies.

{{< note >}}
Start by provisioning your Centos workstation by following the App Deployment Guide [Requirements]({{ relref "app_requirements.md" }})
{{< /note >}}

## Install Chef Habitat

The Chef Habitat installer CLI is supported on Linux, Mac, and Windows, but this guide will support Linux workstations. To learn more about installing, check out the [Chef Habitat docs](https://www.habitat.sh/docs/install-habitat/):

```bash
curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash
```

This command downloads and installs the Chef Habitat in a single command. You can also download the rpm using wet or curl directly, and then install the package. The installation docs linked above link other installation options.

### Accept the License

Once the package has been installed, to run any command you will need to accept the End User-License Agreement (EULA). You can review the EULA here, but the important piece to keep in mind is whether Chef Habitat is being used for commercial purposes. If you are installing and using the software for learning purposes, such as completing the exercises in this guide or Learn Chef Rally tutorials, then you fall within the acceptable use guidelines for the EULA. However if you begin using the software commercially you will need to have a license agreement with Chef Software Inc.

You can run the following command to accept the EULA and view the installed version of Chef Habitat:

```bash
hab --version
```

## Creating an Origin Keypair

Next, you will need to setup your system by generating or defining a set of origin keys. To do this, run the following command and answer the questions that are asked. Either select the answers you recommend at this time, or input your own origin keys if you know what you're doing (you can re-run hab setup at any time). For the default origin name, use your initials, first name, or preferred handle. This name will be a public origin near the end of the guide.

```basy
export HAB_ORIGIN='myinitials_tryhab'
hab origin key generate
```

returns something like:

```bash
Generating origin key for myinitials_tryhab
Generated origin key pair myinitials_tryhab-20200521200652.
```

These keys are stored inside of `~/.hab/cache/keys` . They are used to sign packages that you will build later on. Keep in mind that you'll need access to these keys later to run your packages!

### Key Concepts: Origin Keys -  What are they and why do you need them?
https://www.habitat.sh/docs/glossary/#glossary-keys

Every package that you build with Chef Habitat belongs to an origin and is cryptographically signed with that origin's private key. This ensures that the packages you build are safe to run, and are exactly the same packages that were built and tested in your development environment.

Each origin has a public and private keypair. The public key is used to verify the integrity of downloaded artifacts before installing them, and can be distributed freely to systems that will run your application. The private key is used to sign packages during the build process that you will run shortly.

## Clone the Demo App from GitHub

In this guide you will work with a common Java sample application that is packaged up as a war file and deployed with Tomcat.

You'll be working out of the home directory `/home/centos/ `for the duration of this guide, unless otherwise indicated. You can always get back home by running `cd ~`, and you can check your current directory by running `pwd` .

Clone the sample application to your local machine:

```bash
git clone https://github.com/chef-training/java-sample
```

If you were to unpack the application with the command `jar -xvf sample.war`, you would see the following contents:

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

Generally, to deploy this application you would need to install Java SE and Tomcat on your target machine, download and move the `.war` file to the `CATALINA_HOME/webapps` directory and then start the Tomcat service to deploy the application on port 8080, by default.

In the Habitat paradigm, you package up the `.war` file in a Habitat Artifact (.HART) that contains instructions for how the application should be deployed and managed. This creates a "no-touch" zone for the application, where the Habitat Supervisor is doing the work without human intervention. When a new version of the application is deployed, a new .HART file is handed off to the supervisor.
