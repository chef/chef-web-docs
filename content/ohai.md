+++
title = "About Ohai"
draft = false

aliases = ["/ohai.html"]

[menu]
  [menu.infra]
    title = "About Ohai"
    identifier = "chef_infra/features/ohai/ohai.md About Ohai"
    parent = "chef_infra/features/ohai"
    weight = 10
+++    

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/ohai.md)

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

{{< note >}}

{{% notes_see_attributes_overview %}}

{{< /note >}}

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

General Purpose Plugins
-----------------------

``` ruby
azure.rb
c.rb
chef.rb
cloud.rb
command.rb
cpu.rb
digital_ocean.rb
dmi.rb
docker.rb
ec2.rb
elixir.rb
erlang.rb
eucalyptus.rb
filesystem.rb
freebsd
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
lua.rb
mono.rb
network.rb
nodejs.rb
ohai_time.rb
ohai.rb
memory.rb
network.rb
platform.rb
openstack.rb
os.rb
packages.rb
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
shard.rb
shells.rb
softlayer.rb
ssh_host_key.rb
timezone.rb
uptime.rb
virtualbox.rb
vmware.rb
zpools.rb
```

Platform Specific Plugins
-------------------------

``` ruby
aix
  kernel.rb
  memory.rb
  network.rb
  platform.rb
  uptime.rb
  virtualization.rb
bsd
 virtualization.rb
darwin
  cpu.rb
  filesystem.rb
  hardware.rb
  memory.rb
  network.rb
  platform.rb
  system_profiler.rb
  virtualization.rb
dragonflybsd
 cpu.rb
 memory.rb
 network.rb
 os.rb
 platform.rb
freebsd
  cpu.rb
  memory.rb
  network.rb
  os.rb
  platform.rb
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
netbsd
  cpu.rb
  memory.rb
  network.rb
  platform.rb
openbsd
  cpu.rb
  memory.rb
  network.rb
  platform.rb
solaris2
  cpu.rb
  dmi.rb
  filesystem.rb
  memory.rb
  network.rb
  platform.rb
  virtualization.rb
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
```

Optional Plugins
================

Ohai ships several plugins that are considered optional and can be
enabled in the [client.rb configuration file](/config_rb_client/).

-   <span class="title-ref">:Lspci</span> - PCI device information on
    Linux hosts.
-   <span class="title-ref">:Lsscsi</span> - SCSI device information on
    Linux hosts.
-   <span class="title-ref">:Passwd</span> - User and Group information
    on non-Windows hosts. This plugin can result in very large node
    sizes if a system connects to Active Directory or LDAP.
-   <span class="title-ref">:Sessions</span> - Sessions data from
    loginctl on Linux hosts.
-   <span class="title-ref">:Sysctl</span> - All sysctl values on Linux
    hosts.

Enabling Optional Plugins
-------------------------

Optional plugins can be enabled in the [client.rb configuration
file](/config_rb_client/):

``` ruby
ohai.optional_plugins = [
  :Sessions,
  :Lspci
]
```

{{< note >}}

The Ohai optional_plugins config array must contain an array of plugin
names as Symbols not Strings.

{{< /note >}}

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
default. Use the `Ohai.config[:hints_path]` setting in the [client.rb
configuration file](/config_rb_client/) to customize this location.

ohai Resource
=============

A [resource](/resource/) defines the desired state for a single
configuration item present on a node that is under management by Chef
Infra. A resource collection---one (or more) individual
resources---defines the desired state for the entire node. During a
[Chef Infra Client run](/chef_client/#the-chef-client-run.html), the
current state of each resource is tested, after which Chef Infra Client
will take any steps that are necessary to repair the node and bring it
back into the desired state.

Use the **ohai** resource to reload the Ohai configuration on a node.
This allows recipes that change system attributes (like a recipe that
adds a user) to refer to those attributes later on during a Chef Infra
Client run.

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
