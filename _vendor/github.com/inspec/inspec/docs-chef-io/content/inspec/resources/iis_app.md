+++
title = "iis_app resource"
draft = false
platform = "windows"

[menu]
  [menu.inspec]
    title = "iis_app"
    identifier = "inspec/resources/os/iis_app.md iis_app resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/iis_app.md)

Use the `iis_app` Chef InSpec audit resource to test the state of IIS on Windows Server 2012 (and later).

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.28.0 of InSpec.

## Syntax

An `iis_app` resource block declares details about the named site:

    describe iis_app('application_path', 'site_name') do
      it { should exist }
      it { should have_application_pool('application_pool') }
      it { should have_protocol('protocol') }
      it { should have_site_name('site') }
      it { should have_physical_path('physical_path') }
      it { should have_path('application_path') }
    end

where

- `'application_path'` is the path to the application, such as `'/myapp'`
- `'site_name'` is the name of the site, such as `'Default Web Site'`
- `('application_pool')` is the name of the application pool in which the site's root application is run, such as `'DefaultAppPool'`
- `('protocols')` is a binding for the site, such as `'http'`. A site may have multiple bindings; therefore, use a `have_protocol` matcher for each site protocol to be tested
- `('physical_path')` is the physical path to the application, such as `'C:\\inetpub\\wwwroot\\myapp'`

For example:

    describe iis_app('/myapp', 'Default Web Site') do
      it { should exist }
      it { should have_application_pool('MyAppPool') }
      it { should have_protocol('http') }
      it { should have_site_name('Default Web Site') }
      it { should have_physical_path('C:\\inetpub\\wwwroot\\myapp') }
      it { should have_path('\\My Application') }
    end

## Properties

application_pool, path, physical_path, protocols, site_name

## Resource Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a default IIS web application

    describe iis_app('Default Web Site') do
      it { should exist }
      it { should be_running }
      it { should have_app_pool('DefaultAppPool') }
      it { should have_binding('http *:80:') }
      it { should have_path('%SystemDrive%\\inetpub\\wwwroot') }
    end

### Test if IIS service is running

    describe service('W3SVC') do
      it { should be_installed }
      it { should be_running }
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

### exist

The `exist` matcher tests if the site exists:

    it { should exist }

### have_application_pool

The `have_application_pool` matcher tests if the named application pool exists for the web application:

    it { should have_application_pool('DefaultAppPool') }

### have_protocol

The `have_protocol` matcher tests if the specified protocol exists for the web application:

    it { should have_protocol('http') }

or:

    it { should have_protocol('https') }

A web application may have multiple bindings; use a `have_protocol` matcher for each unique web application binding to be tested.

##### Protocol Attributes

The `have_protocol` matcher can also test attributes that are defined for a web application enabledProtocols.

    it { should have_protocol('http') }

For example, testing a site that doesn't have https enabled:

    it { should_not have_protocol('https') }
    it { should have_protocol('http') }

Testing a web application with https enabled and http enabled:

    it { should have_protocol('https') }
    it { should have_protocol('http') }

### have_physical_path

The `have_physical_path` matcher tests if the named path is defined for the web application:

    it { should have_physical_path('C:\\inetpub\\wwwroot') }
