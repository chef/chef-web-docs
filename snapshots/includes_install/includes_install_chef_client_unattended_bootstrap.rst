.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The chef-client can be installed using an unattended bootstrap. This allows the chef-client to be installed from itself, without using SSH. For example, machines are often created using environments like AWS Auto Scaling, AWS CloudFormation, Rackspace Auto Scale, and PXE. In this scenario, using tooling for attended, single-machine installs like ``knife bootstrap`` or ``knife CLOUD_PLUGIN create`` is not practical because the machines are created automatically and someone cannot always be on-hand to initiate the bootstrap process.

When the chef-client is installed using an unattended bootstrap, remember that the chef-client:

* Must be able to authenticate to the Chef server
* Must be able to configure a run-list
* May require custom attributes, depending on the cookbooks that are being used
* Must be able to access the chef-validator.pem so that it may create a new identity on the Chef server
* Must have a unique node name; the chef-client will use the FQDN for the host system by default

When the chef-client is installed using an unattended bootstrap, it is typically built into an image that starts the chef-client on boot. The type of image used depends on the platform on which the unattended bootstrap will take place.

Use settings in the `client.rb file <https://docs.chef.io/config_rb_client.html>`_---``chef_server_url``, ``http_proxy``, and so on---to ensure that configuration details are built into the unattended bootstrap process.

