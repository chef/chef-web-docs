+++
title = "Chef for Junos OS"
draft = false

aliases = "/junos.html"

[menu]
  [menu.docs]
    title = "Install on Junos OS"
    identifier = "chef_infra/setup/nodes/junos.md Install on Junos OS"
    parent = "chef_infra/setup/nodes"
    weight = 30
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/junos.rst)

Juniper Networks is a leading provider of network routing, switching and
security solutions for enterprises and service providers. Juniper
Networks routers and switches help solve some of the most difficult
problems in the data center. Junos OS is the operating system that runs
on Juniper Networks routers and switches.

![image](/images/overview_junos.png)

Chef for Junos OS allows hardware running Junos OS to be managed by the
Chef Infra Server. The `netdev` cookbook is an open source cookbook
(maintained by Chef) that contains a collection of resources that can be
used to build recipes that extend the node management capabilities of
the Chef Infra Server to include Juniper Networks network devices.

For more information about Chef for Junos OS, including information
about installing and configuring Chef Infra Client on a Junos OS device,
see the Juniper Networks Chef for Junos OS
[documentation](https://www.juniper.net/documentation/en_US/release-independent/junos-chef/information-products/pathway-pages/index.html).

The netdev Custom Resources
===========================

The `netdev` cookbook is used to install and configure network
interfaces and Layer 2 switching.

The `netdev` cookbook contains the following custom resources:
`netdev_interface`, `netdev_l2_interface`, `netdev_lag`, and
`netdev_vlan`.

{{< info >}}

These custom resources are part of the `netdev` cookbook
(<https://github.com/chef-cookbooks/netdev>).

{{< /info >}}

netdev_interface
-----------------

The `netdev_interface` custom resource is used to model the properties
and to manage the configuration of a physical interface.

### Actions

This custom resource has the following actions:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Action</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>:create</code></td>
<td>Default. Use to create a physical interface.</td>
</tr>
<tr class="even">
<td><code>:delete</code></td>
<td>Use to delete a physical interface.</td>
</tr>
</tbody>
</table>

### Properties

This custom resource has the following properties:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>description</code></td>
<td>The description of the interface.</td>
</tr>
<tr class="even">
<td><code>duplex</code></td>
<td>The duplex mode for the interface. Possible values: <code>auto</code>, <code>half</code>, or <code>full</code>. Default value: <code>auto</code>.</td>
</tr>
<tr class="odd">
<td><code>enable</code></td>
<td>Activate the interface. Default value: <code>true</code>.</td>
</tr>
<tr class="even">
<td><code>mtu</code></td>
<td>The maximum transmission unit (MTU) for the network interface.</td>
</tr>
<tr class="odd">
<td><code>name</code></td>
<td>The name of the interface.</td>
</tr>
<tr class="even">
<td><code>speed</code></td>
<td>The speed for the interface. Possible values: <code>auto</code>, <code>100m</code>, <code>1g</code>, <code>10g</code>, <code>40g</code>, <code>56g</code>, or <code>100g</code>. Default value: <code>auto</code>. Setting the speed attribute to the default value of <code>auto</code> causes the device to use the existing configuration for the speed statement and does not explicitly configure anything for the interface speed.</td>
</tr>
</tbody>
</table>

### Examples

``` ruby
netdev_interface "ge-0/0/0" do
  description "description"
  speed "1g"
  duplex "full"
  action :create
end
```

netdev_l2_interface
---------------------

The `netdev_l2_interface` custom resource is used to model the
properties and to manage the configuration of Layer 2 networking
features on both physical and virtual interfaces.

### Actions

This custom resource has the following actions:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Action</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>:create</code></td>
<td>Default. Use to create Layer 2 networking.</td>
</tr>
<tr class="even">
<td><code>:delete</code></td>
<td>Use to delete Layer 2 networking.</td>
</tr>
</tbody>
</table>

#### Properties

This custom resource has the following properties:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>description</code></td>
<td>The description of the interface.</td>
</tr>
<tr class="even">
<td><code>name</code></td>
<td>The name of the interface.</td>
</tr>
<tr class="odd">
<td><code>tagged_vlans</code></td>
<td>An array of VLANs that carry traffic on a trunk interface.</td>
</tr>
<tr class="even">
<td><code>untagged_vlan</code></td>
<td>The native VLAN on an interface.</td>
</tr>
<tr class="odd">
<td><code>vlan_tagging</code></td>
<td>Specify that a port is in access or trunk mode. Default value: <code>true</code> (trunk mode).</td>
</tr>
</tbody>
</table>

### Examples

``` ruby
netdev_l2_interface "ge-0/0/0" do
  description "description"
  tagged_vlans %w{ foobar }
  vlan_tagging true
  action :create
end
```

netdev_lag
-----------

The `netdev_lag` custom resource is used to to model the properties and
to manage the configuration of a link aggregation group (LAG). This is
referred to as an aggregated Ethernet bundle in Junos OS.

{{< info >}}

The number of supported aggregated Ethernet interfaces on a switch must
be manually configured before this resource can be used to create LAGs.
Use the
[aggregated-devices](https://www.juniper.net/documentation/en_US/junos13.2/topics/reference/configuration-statement/device-count-chassis-qfx-series.html)
command to configure the number of supported interfaces:

``` bash
$ set chassis aggregated-devices ethernet device-count <count-value>
```

{{< /info >}}

### Actions

This custom resource has the following actions:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Action</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>:create</code></td>
<td>Default. Use to create a link aggregation group (LAG).</td>
</tr>
<tr class="even">
<td><code>:delete</code></td>
<td>Use to delete a link aggregation group (LAG).</td>
</tr>
</tbody>
</table>

### Properties

This custom resource has the following properties:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>lacp</code></td>
<td>The Link Aggregation Control Protocol (LACP) mode. Possible values: <code>active</code> (active mode), <code>disable</code> (not used), or <code>passive</code> (passive mode). Default value: <code>disable</code>.</td>
</tr>
<tr class="even">
<td><p><code>links</code></p></td>
<td><p>Required. An array of interfaces to be configured as members of a link aggregation group (LAG).</p>
{{< info >}}
<p>If a <code>netdev_lag</code> resource is deleted, interfaces that are defined by this property are also deleted, unless they have been configured elsewhere.</p>
{{< /info >}}</td>
</tr>
<tr class="odd">
<td><code>minimum_links</code></td>
<td>The minimum number of physical links that are required to ensure the availability of the link aggregation group (LAG).</td>
</tr>
<tr class="even">
<td><code>name</code></td>
<td>The name of the link aggregation group (LAG).</td>
</tr>
</tbody>
</table>

### Examples

``` ruby
netdev_lag "ae0" do
  links %w{ ge-0/0/1 ge-0/0/2 }
  minimum_links 1
  lacp "disable"
  action :create
end
```

netdev_vlan
------------

The `netdev_vlan` custom resource is used to model the properties and to
manage the configuration of VLANs.

### Actions

This custom resource has the following actions:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Action</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>:create</code></td>
<td>Default. Use to create a VLAN.</td>
</tr>
<tr class="even">
<td><code>:delete</code></td>
<td>Use to delete a VLAN.</td>
</tr>
</tbody>
</table>

### Properties

This custom resource has the following properties:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>description</code></td>
<td>The description of the VLAN.</td>
</tr>
<tr class="even">
<td><code>name</code></td>
<td>The name of the VLAN.</td>
</tr>
<tr class="odd">
<td><code>vlan_id</code></td>
<td>Required. The identifier for the VLAN.</td>
</tr>
</tbody>
</table>

### Examples

``` ruby
netdev_vlan "name" do
  vlan_id 2
  description "description"
  action :create
end
```
