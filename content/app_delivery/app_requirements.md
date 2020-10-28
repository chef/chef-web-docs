+++
title = "App Delivery Guide"
description = "Build and Deliver your first Chef App"
draft = false

[menu]
  [menu.app_delivery]
    title = "Requirements"
    identifier = "app_delivery/app_guide/app_requirements"
    parent = "app_delivery/app_guide"
    categories = ["app_delivery"]
    weight = 30
+++

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/app_delivery/app_requirements.md)

This Guide walks you through the Chef App Delivery process using a demo Java application. You'll move through an iterative development cycle, much like what you would experience in the real world. You'll start with a running app with failed build and then iterate on your package to learn how to troubleshoot and refine your deployment.

This guide is divided into five parts, to show you how to:

* Install Chef Habitat
* Set Up Chef Habitat and the demo app
* Define the Application Manifest
* Package a Chef Habitat Artifact
* Deliver an Application with the Chef Habitat Supervisor

## System Requirements

This guide assumes that you're using:

* Centos 8.1 workstation
* 64-bit processor

For other Linux systems:

* 64-bit processor
* kernel 2.6.32 or later

## Additional Software

* Your favorite editor
* Git
* Docker Community Edition

For example, to install these tools with the yum package manager:

```bash
sudo yum install -y vim-enhanced git
sudo yum install docker-ce docker-ce-cli containerd.io
```
