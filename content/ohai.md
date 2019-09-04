+++
title = "About Ohai"
draft = false

aliases = "/ohai.html"

[menu]
  [menu.docs]
    title = "About Ohai"
    identifier = "chef_infra/chefdk/ohai/ohai.md About Ohai"
    parent = "chef_infra/chefdk/ohai"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ohai.rst)

{{% ohai_summary %}}

Ohai collects data for many platforms, including AIX, Darwin, Linux,
FreeBSD, OpenBSD, NetBSD, Solaris, and any Microsoft Windows operating
systems.

View the [release notes](/release_notes_ohai/) for the latest
information on Ohai.

Automatic Attributes
====================

{{% ohai_automatic_attribute %}}

**Get a list of automatic attributes for a node**

{{% ohai_attribute_list %}}

{{< info >}}

{{% notes_see_attributes_overview %}}

{{< /info >}}

Blacklist Attributes
--------------------

{{% node_attribute_blacklist %}}

Whitelist Attributes
--------------------

{{% node_attribute_whitelist %}}

Default Plugins
===============

The following list shows the type of plugins that are included with
Ohai. See the `ohai/lib/ohai/plugins` directory in the version of Ohai
installed on your system for the full list:

``` ruby
aix
  cpu.rb
  filesystem.rb
  kernel.rb
  memory.rb
  network.rb
  os.rb
  platform.rb
  uptime.rb
  virtualization.rb
azure.rb
bsd
 filesystem.rb
 virtualization.rb
c.rb
chef.rb
cloud.rb
command.rb
darwin
  cpu.rb
  filesystem.rb
  hardware.rb
  memory.rb
  network.rb
  platform.rb
  system_profiler.rb
  virtualization.rb
digital_ocean.rb
dmi.rb
docker.rb
dragonflybsd
 cpu.rb
 memory.rb
 network.rb
 os.rb
 platform.rb
ec2.rb
elixir.rb
erlang.rb
eucalyptus.rb
freebsd
  cpu.rb
  memory.rb
  network.rb
  os.rb
  platform.rb
gce.rb
go.rb
groovy.rb
haskell.rb
hostname.rb
init_package.rb
java.rb
joyent.rb
kernel.rb
keys.rb
languages.rb
libvirt.rb
linode.rb
linux
  block_device.rb
  cpu.rb
  filesystem.rb
  fips.rb
  hostnamectl.rb
  lsb.rb
  machineid.rb
  mdadm.rb
  memory.rb
  network.rb
  platform.rb
  sessons.rb
  virtualization.rb
lua.rb
mono.rb
netbsd
  cpu.rb
  memory.rb
  network.rb
  platform.rb
network.rb
nodejs.rb
ohai.rb
ohai_time.rb
openbsd
  cpu.rb
  memory.rb
  network.rb
  platform.rb
openstack.rb
os.rb
packages.rb
passwd.rb
perl.rb
php.rb
platform.rb
powershell.rb
ps.rb
python.rb
rackspace.rb
root_group.rb
ruby.rb
rust.rb
scala.rb
scaleway.rb
scsi.rb
shard.rb
shells.rb
softlayer.rb
solaris2
  cpu.rb
  dmi.rb
  filesystem.rb
  memory.rb
  network.rb
  platform.rb
  virtualization.rb
ssh_host_key.rb
sysconf.rb
timezone.rb
uptime.rb
virtualbox.rb
vmware.rb
windows
  cpu.rb
  drivers.rb
  filesystem.rb
  fips.rb
  memory.rb
  network.rb
  platform.rb
  system_enclosure.rb
  virtualization.rb
zpools.rb
```

Custom Plugins
==============

Custom Ohai plugins can be written to collect additional information
from systems as necessary. See the [Ohai Custom
Plugins](/ohai_custom/) docs for more information.

Hints
=====

Ohai hints are used to tell Ohai something about the system that it is
running on that it would not be able to discover itself. An Ohai hint
exists if a JSON file exists in the hint directory with the same name as
the hint. For example, calling `hint?('antarctica')` in an Ohai plugin
would return an empty hash if the file `antarctica.json` existed in the
hints directory, and return nil if the file does not exist.

If the hint file contains JSON content, it will be returned as a hash
from the call to `hint?`.

``` javascript
{
  "snow": true,
  "penguins": "many"
}
```

``` ruby
antarctica_hint = hint?('antarctica')
if antarctica_hint['snow']
  "There are #{antarctica_hint['penguins']} penguins here."
else
  'There is no snow here, and penguins like snow.'
end
```

Hint files are located in the `/etc/chef/ohai/hints/` directory by
default. Use the `Ohai.config[:hints_path]` setting in the `client.rb`
file to customize this location.

ohai Resource
=============

{{% resources_common_generic %}}

{{% resource_ohai_summary %}}

Syntax
------

A **ohai** resource block reloads the Ohai configuration on a node:

``` ruby
ohai 'reload' do
  action :reload
end
```

The full syntax for all of the properties that are available to the
**ohai** resource is:

``` ruby
ohai 'name' do
  name                       String
  notifies                   # see description
  plugin                     String
  subscribes                 # see description
  action                     Symbol # defaults to :reload if not specified
end
```

where

-   `ohai` is the resource
-   `name` is the name of the resource block
-   `action` identifies the steps Chef Infra Client will take to bring
    the node into the desired state
-   `name` and `plugin` are properties of this resource, with the Ruby
    type shown. See "Properties" section below for more information
    about all of the properties that may be used with this resource.

Actions
-------

{{% resource_ohai_actions %}}

Properties
----------

{{% resource_ohai_properties %}}

Providers
---------

This resource has the following providers:

`Chef::Provider::Ohai`, `ohai`

:   The default provider for all platforms.

Examples
--------

The following examples demonstrate various approaches for using
resources in recipes:

**Reload Ohai**

{{% resource_ohai_reload %}}

**Reload Ohai after a new user is created**

{{% resource_ohai_reload_after_create_user %}}

ohai Command Line Tool
======================

{{% ctl_ohai_summary %}}

Options
-------

{{% ctl_ohai_options %}}

Ohai Settings in client.rb
==========================

{{% config_rb_ohai %}}

{{% config_rb_ohai_settings %}}
