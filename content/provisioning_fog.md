+++
title = "Fog Driver Resources"
description = "DESCRIPTION"
draft = false




  
    
    
    
    
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/provisioning_fog.rst)

<meta name="robots" content="noindex">

{{% EOL_provisioning %}}

{{% provisioning_summary %}}

{{% resources_provisioning %}}

The following driver-specific resources are available for Fog and Chef
Provisioning:

-   `fog_key_pair`

fog_key_pair
==============

The `fog_key_pair` resource is a driver-specific resource used by Chef
Provisioning for use with Fog, a Ruby gem for interacting with various
cloud providers, such as Amazon EC2, CloudStack, DigitalOcean, Google
Cloud Platform, Joyent, OpenStack, Rackspace, SoftLayer, and vCloud Air.

Syntax
------

A `fog_key_pair` resource block typically declares a key pair for use
with Fog, a Ruby gem for interacting with various cloud providers. For
example:

``` ruby
fog_key_pair 'name' do
  private_key_options({
    :format => :pem,
    :type => :rsa,
    :regenerate_if_different => true
  })
  allow_overwrite true
end
```

The full syntax for all of the properties that are available to the
`fog_key_pair` resource is:

``` ruby
fog_key_pair 'name' do
  allow_overwrite         true, false
  driver                  Chef::Provisioning::Driver
  private_key_options     Hash
  private_key_path        String
  public_key_path         String
end
```

where

-   `fog_key_pair` is the resource
-   `name` is the name of the resource block and also the name of an
    instance in Amazon EC2
-   `allow_overwrite`, `driver`, `private_key_options`,
    `private_key_path`, and `public_key_path` are properties of this
    resource, with the Ruby type shown. See "Properties" section below
    for more information about all of the properties that may be used
    with this resource.

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
<td><p><code>allow_overwrite</code></p></td>
<td><p><strong>Ruby Type:</strong> true, false</p>
<p>Use to allow overwriting an existing key pair.</p></td>
</tr>
<tr class="even">
<td><p><code>driver</code></p></td>
<td><p><strong>Ruby Type:</strong> Chef::Provisioning::Driver</p>
<p>The Chef Provisioning driver.</p></td>
</tr>
<tr class="odd">
<td><p><code>private_key_options</code></p></td>
<td><p><strong>Ruby Type:</strong> Hash</p>
<p>A Hash that defines a list of parameters used when generating a private key.</p></td>
</tr>
<tr class="even">
<td><p><code>private_key_path</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the location from which the private key is generated. If this value is not specified, the private key will be generated.</p></td>
</tr>
<tr class="odd">
<td><p><code>public_key_path</code></p></td>
<td><p><strong>Ruby Type:</strong> String</p>
<p>Use to specify the location from which the public key is generated. If this value is not specified, the public key will be generated.</p></td>
</tr>
</tbody>
</table>

Examples
--------

None.
