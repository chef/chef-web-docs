+++
title = "App Delivery Guide"
description = "Learn the Chef App Delivery process using a demo Java application."
draft = false

[menu]
  [menu.app_delivery]
    title = "Introduction and Requirements"
    identifier = "app_delivery/app_guide/app_requirements"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 30
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_requirements.md)

The Chef App Delivery Guide demonstrates the process of defining, packaging, and delivering applications using a demo Java application. This guide uses an iterative development cycle, much like what you would experience in the real world. You'll start by getting up and running with Chef Habitat, then you'll start out with failed app build, which you'll troubleshoot and refine until you have a successful app deployment.

This guide is divided into five parts:

* Install Chef Habitat
* Set Up Chef Habitat and the demo app
* Define the Application Manifest
* Package a Chef Habitat Artifact
* Deliver an Application with the Chef Habitat Supervisor

## Chef Habitat Key Components

To deliver an application using Chef Habitat you will need to define, package and deploy the following three components.

Chef Habitat Studio
: The Studio is a self-contained, minimal environment that is free from any upstream operating system requirements. You'll use the Studio to define, package, and [TODO: deploy-- what does the guide do??] your App. Chef Habitat installs only the dependencies needed to run your application into the Studio when you build your package. This economy of content minimizes unwanted dependencies, reduces security gaps, and eliminates the time-honored reasoning that "it worked on my machine". The Habitat Studio ensures that the package you built in development is the exact package loaded in production.

The Chef Habitat Application Manifest
: The Application Manifest provides contains "everything" the application needs to be built, deployed, and managed in a single directory.

A Chef Habitat Artifact(.hart)
: The .hart is created using the Habitat Application Manifest. This artifact includes a single package that includes "everything" the application needs to be built, deployed and managed.  your
Application needs throughout it's full lifecycle.

Chef Habitat Supervisor
: The Supervisor is a light-weight intelligent agent that will unpack the Habitat Artifact(.hart) and execute other commands programmed during the definition phase.

## System Requirements

This guide assumes that you're using:

* Centos 8.1 workstation
* 64-bit processor

For other Linux systems:

* 64-bit processor
* kernel 2.6.32 or later

## Required Software

You will install and set up Chef Habitat in the [Setup]({{ relref "app_setup.md }}) step. For now, you'll need an editor, Git, and Docker to use Chef Habitat on your system.

Start by provisioning your Centos workstation with:

* Your favorite editor
* Git
* Docker Community Edition

For example, to install a vim editor, git, and the Docker Community Edition with with the yum package manager, run:

```bash
sudo yum install -y vim-enhanced git
sudo yum install docker-ce docker-ce-cli containerd.io
```

## Access Requirements

* A GitHub account and access to the account
* Access to an internet connection
* Access to the [bldr.habitat.sh](https://bldr.habitat.sh/#/origins) domain
