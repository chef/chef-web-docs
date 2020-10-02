+++
title = "service resource"
draft = false
platform = "os"

[menu]
  [menu.inspec]
    title = "service"
    identifier = "inspec/resources/os/service.md service resource"
    parent = "inspec/resources/os"
+++

[\[edit on GitHub\]](https://github.com/inspec/inspec/blob/master/docs-chef-io/content/inspec/resources/service.md)

Use the `service` Chef InSpec audit resource to test if the named service is installed, running and/or enabled.

Under some circumstances, it may be necessary to specify the service manager by using one of the following service manager-specific resources: `bsd_service`, `launchd_service`, `runit_service`, `systemd_service`, `sysv_service`, or `upstart_service`. These resources are based on the `service` resource.

## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `service` resource block declares the name of a service and then one (or more) matchers to test the state of the service:

    describe service('service_name') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end

where

- `('service_name')` must specify a service name
- `be_installed`, `be_enabled`, and `be_running` are valid matchers for this resource

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test if the postgresql service is both running and enabled

    describe service('postgresql') do
      it { should be_enabled }
      it { should be_running }
    end

### Test if the mysql service is both running and enabled

    describe service('mysqld') do
      it { should be_enabled }
      it { should be_running }
    end

### Test if ClamAV (an antivirus engine) is installed and running

    describe package('clamav') do
      it { should be_installed }
      its('version') { should eq '0.98.7' }
    end

    describe service('clamd') do
      it { should_not be_enabled }
      it { should_not be_installed }
      it { should_not be_running }
    end

### Test Unix System V run levels

On targets that are using SystemV services, the existing run levels can also be checked:

    describe service('sshd').runlevels do
      its('keys') { should include(2) }
    end

    describe service('sshd').runlevels(2,4) do
      it { should be_enabled }
    end

### Override the service manager

Under some circumstances, it may be required to override the logic in place to select the right service manager. For example, to check a service managed by Upstart:

    describe upstart_service('service') do
      it { should_not be_enabled }
      it { should be_installed }
      it { should be_running }
    end

This is also possible with `systemd_service`, `runit_service`, `sysv_service`, `bsd_service`, and `launchd_service`. Provide the control command when it is not to be found at the default location. For example, if the `sv` command for services managed by runit is not in the `PATH`:

    describe runit_service('service', '/opt/chef/embedded/sbin/sv') do
      it { should be_enabled }
      it { should be_installed }
      it { should be_running }
    end

### Verify that IIS is running

    describe service('W3SVC') do
      it { should be_installed }
      it { should be_running }
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](/inspec/matchers/).

### be_enabled

The `be_enabled` matcher tests if the named service is enabled:

    it { should be_enabled }

### be_installed

The `be_installed` matcher tests if the named service is installed:

    it { should be_installed }

### be_running

The `be_running` matcher tests if the named service is running:

    it { should be_running }
