+++
title = "Chef Infra Language: Checking Clouds"
draft = false

gh_repo = "chef-web-docs"

[menu]
  [menu.infra]
    title = "Checking Clouds"
    identifier = "chef_infra/cookbook_reference/infra_language/checking_clouds.md Checking Clouds"
    parent = "chef_infra/cookbook_reference/infra_language"
    weight = 37
+++

Chef Infra Client 15.8 and later include a number of helper methods for checking if a node is running in a public or private cloud.

### cloud?

Determine if the current node is running a known public or private cloud.

### ec2?

Determine if the current node is running in AWS EC2.

### gce?

Determine if the current node is running in Google Compute Engine (GCE)

### rackspace?

Determine if the current node is running in Rackspace.

### eucalyptus?

Determine if the current node is running in Eucalyptus.

### linode?

Determine if the current node is running in Linode.

### openstack?

Determine if the current node is running in OpenStack.

### azure?

Determine if the current node is running in Microsoft Azure.

### digital_ocean?

Determine if the current node is running in DigitalOcean.

### softlayer?

Determine if the current node is running in SoftLayer (IBM Cloud).
