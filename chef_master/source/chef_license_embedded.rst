=====================================================
Accepting the Chef License in embedded situations
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_license_embedded.rst>`__

TODO: SEO optimize this with as many of the license related error messages
as we can find. I would really like this to be easy to find on day one
of our Chef 15 rollout.
TODO: find out the versioning policies of vagrant and terraform; will
existing terraform configs break on day one of our license change?
Answer: in many cases they pull latest from stable. 



A number of tools, including test-kitchen, vagrant and terraform use
chef in an embedded form for provisioning. Starting in Chef 15 we
require you to accept the license when using chef products (TODO,
rephrase).

There are two basic strategies to adapt: Configure the tool to accept
the license, or pin to an older version of Chef.

Accept the license as part of the flow
----

There are two basic strategies to accept the license

#. Provide a command line flag. ``chef-client --chef-license=accept``

#. Set an environment variable.. ``CHEF_LICENSE=accept chef-client``.. Note that the product name needs to be specified in
the environment variable.


Pin to Chef 14
----
In the short term, pinning to Chef 14 may be the easiest workaround;
longer term this of course will hit issues around product end of life
and consequent lack
of updates.



test-kitchen
=====================

TODO Write up our t-k usage plan

Accept the license
----
TODO: figure out how to explicitly accept the license in a test kitchen

Pin to Chef 14
------

You can pin to a specific version of chef in your kitchen.yml::

    provisioner:
      name: chef_zero
      product_name: chef
      product_version: 14.12.3

Terraform
==================

Accept the license
---
TODO: Figure out how to do this.
AFAIK there isn't a way to set command line options or env-vars for chef in terraform. 

Pin to Chef 14
---

In your provisioner config::

    provisioner "chef" {
      ...
      version         = "14.12.3"
    }

See
https://www.terraform.io/docs/provisioners/chef.html#version-string-
for details

Vagrant
==================

If you see the following message when running vagrant
```chef-client cannot execute without accepting the license```
you'll need to modify your Vagrantfile to accept the license for you
or pin to Chef 14

Accept the license
---

This can be done via the arguments API::
     config.vm.provision "chef_zero" do |chef|
       chef.arguments = "--chef-license accept"
       ...
     end

See
https://www.vagrantup.com/docs/provisioning/chef_common.html#arguments
for details     

TODO: This is fragile in that it is not back compatible with Chef 14,
so figure out how to do this via environment variables


Pin to Chef 14
---
This can be done via the version API::
     config.vm.provision "chef_zero" do |chef|
       chef.version = "14.12.3"
       ...
     end

https://www.vagrantup.com/docs/provisioning/chef_common.html#version

  






