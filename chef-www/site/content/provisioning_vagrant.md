+++
title = "Vagrant Driver Resources"
description = "DESCRIPTION"
draft = false




  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/provisioning_vagrant.rst)

{{% EOL_provisioning %}}

<div class="warning" markdown="1">

<div class="admonition-title" markdown="1">

Warning

</div>

The Vagrant driver for Chef Provisioning has been deprecated and is no
longer supported or recommended for use.

</div>

{{% provisioning_summary %}}

{{% resources_provisioning %}}

The following driver-specific resources are available for Vagrant and
Chef Provisioning:

-   `vagrant_box`
-   `vagrant_cluster`

vagrant_box
============

The `vagrant_box` resource is a driver-specific resource used by Chef
Provisioning. Use the `vagrant_box` resource to add and remove machines
that are running in Vagrant and using VirtualBox by default.

Syntax
------

A `vagrant_box` resource block typically declares a box to be created
using Vagrant. For example:

``` ruby
vagrant_box 'opscode-centos-6.4' do
  url 'http://bento.s3.amazonaws.com/vagrant/vmware/centos-6.4.box'
  vagrant_provider 'vmware_desktop'
end
```

The full syntax for all of the properties that are available to the
`vagrant_box` resource is:

``` ruby
vagrant_box 'name' do
  driver_options          Hash
  vagrant_provider        String
  url                     String
end
```

where

-   `vagrant_box` is the resource
-   `name` is the name of the resource block and also the name of an
    instance in Amazon EC2
-   `driver_options`, `vagrant_provider`, and `url` are properties of
    this resource, with the Ruby type shown. See "Properties" section
    below for more information about all of the properties that may be
    used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>driver_options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>Use to specify driver options.</p></td>
</tr>
<tr class="even">
<td><p><code>name</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the Vagrant box.</p></td>
</tr>
<tr class="odd">
<td><p><code>vagrant_provider</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The name of the provider for Vagrant. Default value: <code>virtualbox</code>.</p></td>
</tr>
<tr class="even">
<td><p><code>url</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The URL from which the Vagrant box is downloaded.</p></td>
</tr>
</tbody>
</table>

Examples
--------

None.

vagrant_cluster
================

The `vagrant_cluster` resource is a driver-specific resource used by
Chef Provisioning. Use the `vagrant_cluster` resource to build a group
of boxes in Vagrant using a single Vagrantfile that defines each of the
boxes in the group. The `vagrant list` command will show all of the
boxes that are configured with the Vagrantfile.

Syntax
------

A `vagrant_cluster` resource block typically declares a cluster to be
created or deleted. For example:

``` ruby
```

``` ruby
vagrant_cluster '/path/to/cluster' do
  action :delete
end
```

The full syntax for all of the properties that are available to the
`vagrant_cluster` resource is:

``` ruby
vagrant_cluster 'name' do
  path                    String
end
```

where

-   `vagrant_cluster` is the resource
-   `name` is the name of the resource block and also the name of a
    cluster
-   `path` is a property of this resource, with the Ruby type shown. See
    "Properties" section below for more information about all of the
    properties that may be used with this resource.

Properties
----------

This Chef Provisioning driver-specific resource has the following
properties:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 75%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>path</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>The path to the Vagrant cluster.</p></td>
</tr>
</tbody>
</table>

Examples
--------

None.
