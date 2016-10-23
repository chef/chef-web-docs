.. THIS PAGE IS IDENTICAL TO docs.chef.io/plugin_community.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
Community Plugins
=====================================================

This page lists plugins for knife, Ohai, handlers, and the chef-client that are developed and maintained by the Chef community.


Knife
=====================================================
.. include:: ../../includes_knife/includes_knife.rst

knife plugins for cloud hosting platforms--- `knife azure <https://docs.chef.io/plugin_knife_azure.html>`_, `knife bluebox <https://docs.chef.io/plugin_knife_bluebox.html>`_, `knife ec2 <https://docs.chef.io/plugin_knife_ec2.html>`_, `knife eucalyptus <https://docs.chef.io/plugin_knife_eucalyptus.html>`_, `knife google <https://docs.chef.io/plugin_knife_google.html>`_, `knife linode <https://docs.chef.io/plugin_knife_linode.html>`_, `knife openstack <https://docs.chef.io/plugin_knife_openstack.html>`_, `knife rackspace <https://docs.chef.io/plugin_knife_rackspace.html>`_, and `knife terremark <https://docs.chef.io/plugin_knife_terremark.html>`_ ---are built and maintained by Chef. 

The following table lists knife plugins built by the Chef community.

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Plugin
     - Description
   * - `knife-audit <https://github.com/jbz/knife-audit>`_
     - Adds the ability to see how many (and which) nodes have a cookbook in its run-list.
   * - `knife-baremetalcloud <https://github.com/baremetalcloud/knife-baremetalcloud>`_
     - Adds the ability to manage compute nodes in baremetalcloud.
   * - `knife-batch <https://github.com/imeyer/knife-batch>`_
     - Adds the ability to execute commands like ``knife ssh``, but in groups of N with a sleep between execution iterations.
   * - `knife-block <https://github.com/greenandsecure/knife-block>`_
     - Adds the ability to create and manage multiple knife.rb files for working with many servers.
   * - `knife-brightbox <https://github.com/rubiojr/knife-brightbox>`_
     - Adds the ability to create, bootstrap, and manage instances in the brightbox cloud.
   * - `knife-bulk-change-environment <https://github.com/jonlives/knife-bulkchangeenvironment>`_
     - Adds the ability to move nodes from one environment to another.
   * - `knife-canon <https://github.com/lnxchk/Canon>`_
     - Adds the ability to compare command output across hosts.
   * - `knife-cfn <https://github.com/neillturner/knife-cfn>`_
     - Adds the ability to validate, create, describe, and delete stacks in AWS CloudFormation.
   * - `knife-cisco_asa <https://github.com/bflad/knife-cisco_asa>`_
     - Adds the ability to manage Cisco ASA devices.
   * - `knife-cleanup <https://github.com/mdxp/knife-cleanup>`_
     - Adds the ability to remove unused versions of cookbooks that are hosted on the Chef server. (Cookbook versions that are removed are backed-up prior to deletion.)
   * - `knife-cloudstack-fog <https://github.com/fifthecho/knife-cloudstack-fog>`_
     - Adds the ability to create, bootstrap, and manage instances in CloudStack using Fog, a Ruby gem for interacting with various cloud providers.
   * - `knife-cloudstack <https://github.com/CloudStack-extras/knife-cloudstack>`_
     - Adds the ability to create, bootstrap, and manage CloudStack instances.
   * - `knife-community <https://github.com/miketheman/knife-community>`_
     - Adds the ability to assist with deploying completed cookbooks to the community web site.
   * - `knife-crawl <https://github.com/jgoulah/knife-crawl>`_
     - Adds the ability to display the roles that are included recursively within a role and (optionally) all of the roles that include it.
   * - `knife-digital_ocean <https://github.com/rmoriz/knife-digital_ocean>`_
     - Adds the ability to create, bootstrap, and manage instances in DigitalOcean.
   * - `knife-ec2-amis-ubuntu <https://rubygems.org/gems/ubuntu_ami>`_
     - Adds the ability to retrieve a list of released Ubuntu Amazon Machine Images (AMI).
   * - `knife-elb <https://github.com/ranjib/knife-elb>`_
     - Adds the ability to add and remove instances from existing enterprise load balancers, enlist them, and then show them. (This does not add the ability to create or delete enterprise load balancers.)
   * - `knife-env-diff <https://github.com/jgoulah/knife-env-diff>`_
     - Adds the ability to diff the cookbook versions for two (or more) environments.
   * - `knife-esx <https://github.com/rubiojr/knife-esx>`_
     - Adds support for VMware.
   * - `knife-file <https://github.com/cparedes/knife-file>`_
     - Adds utilities that help manipulate files in a chef-repo.
   * - `knife-flip <https://github.com/jonlives/knife-flip>`_
     - Adds improvements to ``knife-set-environment`` with added functionality and failsafes.
   * - `knife-gandi <https://rubygems.org/gems/knife-gandi>`_
     - Adds the ability to create, bootstrap, and manage servers on the gandi.net hosting platform.
   * - `knife-gather <https://github.com/lnxchk/Gather>`_
     - Adds the ability to collate multi-line output from parallel ``knife ssh`` outputs into one section per host.
   * - `knife-github-cookbooks <https://github.com/websterclay/knife-github-cookbooks>`_
     - Adds the ability to create vendor branches automatically from any GitHub cookbook.
   * - `knife-glesys <https://github.com/smgt/knife-glesys>`_
     - Adds the ability to create, delete, list, and bootstrap servers on GleSYS.
   * - `knife-ipmi <https://github.com/Afterglow/knife-ipmi>`_
     - Adds simple power control of nodes using IPMI.
   * - `knife-kvm <https://github.com/rubiojr/knife-kvm>`_
     - Adds Linux support for KVM.
   * - `knife-lastrun <https://github.com/jgoulah/knife-lastrun>`_
     - Adds key metrics from the last chef-client run on a given node.
   * - `knife-ohno <https://github.com/lnxchk/Ohno>`_
     - Adds the ability to view nodes that haven't checked into the platform for N hours.
   * - `knife-oktawave <https://github.com/marek-siemdaj/knife-oktawave>`_
     - Adds the ability to manage Oktawave Cloud Instances.
   * - `knife-onehai <https://github.com/lnxchk/Knife-OneHai>`_
     - Adds the ability to get the last seen time of a single node.
   * - `knife-playground <https://github.com/rubiojr/knife-playground>`_
     - Adds miscellaneous tools for knife.
   * - `knife-plugins <https://github.com/danielsdeleo/knife-plugins>`_
     - Adds a set of plugins that help manage data bags.
   * - `knife-pocket <https://github.com/lnxchk/Pocket>`_
     - Adds the ability to save a knife search query for later use, such as when using ``knife ssh``.
   * - `knife-preflight <https://github.com/jonlives/knife-preflight>`_
     - Adds the ability to check which nodes and roles use a cookbook. This is helpful when making changes to a cookbook.
   * - `knife-profitbricks <https://github.com/profitbricks/knife-profitbricks>`_
     - Adds the ability to create, bootstrap, and manage instances in the ProfitBricks IaaS.
   * - `knife-rhn <https://github.com/bflad/knife-rhn>`_
     - Adds the ability to manage the Red Hat network.
   * - `knife-rightscale <https://github.com/caryp/knife-rightscale>`_
     - Adds the ability to provision servers on clouds managed by the RightScale platform.
   * - `knife-role_copy <https://github.com/benjaminws/knife_role_copy>`_
     - Adds the ability to get data from a role, and then set up a new role using that data (as long as the new role doesn't have the same name as an existing role).
   * - `knife-rvc <https://github.com/dougm/rvc-knife>`_
     - Integrates a subset of knife functionality with Ruby vSphere Console.
   * - `knife-santoku <https://github.com/knuckolls/knife-santoku>`_
     - Adds the ability to build processes around the chef-client.
   * - `knife-select <https://github.com/hpcloud/knife-select>`_
     - Adds the ability for selecting the chef server or organisation to interact with.
   * - `knife-server <https://github.com/fnichol/knife-server>`_
     - Adds the ability to manage a Chef server, including bootstrapping a Chef server on Amazon EC2 or a standalone server and backing up and/or restoring node, role, data bag, and environment data.
   * - `knife-set-environment <https://gist.github.com/961827>`_
     - Adds the ability to set a node environment.
   * - `knife-skeleton <https://github.com/Numergy/knife-skeleton>`_
     - Adds the ability to create skeleton integrating chefspec, rubocop, foodcritic, knife test and kitchen.
   * - `knife-softlayer <https://github.com/softlayer/knife-softlayer>`_
     - Adds the ability to launch and bootstrap instances in the IBM SoftLayer cloud.
   * - `knife-solo <https://rubygems.org/gems/knife-solo>`_
     - Adds support for bootstrapping and running chef-solo, search, and data bags.
   * - `knife-slapchop <https://github.com/kryptek/knife-slapchop>`_
     - Adds the ability create and tag clusters of Amazon EC2 nodes with a multi-threading bootstrap process.
   * - `knife-spork <https://github.com/jonlives/knife-spork>`_
     - Adds a simple environment workflow so that teams can more easily work together on the same cookbooks and environments.
   * - `knife-ssh_cheto <https://github.com/demonccc/chef-repo/tree/master/plugins/knife/ssh_cheto>`_
     - Adds extra features to be used with SSH.
   * - `knife-ucs <https://github.com/velankanisys/knife-ucs>`_
     - Adds the ability to provision, list, and manage Cisco UCS servers.
   * - `knife-voxel <https://github.com/warwickp/knife-voxel>`_
     - Adds the ability to provision instances in the Voxel cloud.
   * - `knife-whisk <https://github.com/Banno/knife-whisk>`_
     - Adds the ability to create new servers in a team environment.
   * - `knife-xapi <https://github.com/spheromak/knife-xapi>`_
     - Adds support for Citrix XenServer.


Ohai
=====================================================
.. include:: ../../includes_ohai/includes_ohai.rst

The following Ohai plugins are available from the open source community:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Plugin
     - Description
   * - `chef-ohai-mdadm <https://github.com/tas50/chef-ohai-mdadm>`_
     - Adds output for mdadm software RAID volumes.
   * - `dell.rb <https://github.com/demonccc/chef-ohai-plugins/blob/master/dell.rb>`_
     - Adds some useful Dell server information to Ohai. For example: service tag, express service code, storage info, RAC info, and so on. To use this plugin, OMSA and SMBIOS applications need to be installed.
   * - `dpkg.rb <https://github.com/demonccc/chef-ohai-plugins/blob/master/linux/dpkg.rb>`_
     - Adds dpkg info to Ohai so that information about the status of Debian packages and various installed packages can be collected.
   * - `ipmi.rb <https://bitbucket.org/retr0h/ohai>`_
     - Adds a MAC address and an IP address to Ohai, where available.
   * - `kvm_extensions.rb <https://github.com/albertsj1/ohai-plugins/blob/master/kvm_extensions.rb>`_
     - Adds extensions for virtualization attributes to provide additional host and guest information for KVM.
   * - `ladvd.rb <https://github.com/demonccc/chef-ohai-plugins/blob/master/linux/ladvd.rb>`_
     - Adds ladvd information to Ohai, when it exists.
   * - `lxc_virtualization.rb <https://github.com/jespada/ohai-plugins/blob/master/lxc_virtualization.rb>`_
     - Adds extensions for virtualization attributes to provide host and guest information for Linux containers.
   * - `network_addr.rb <https://gist.github.com/1040543>`_
     - Adds extensions for network attributes with additional ``ipaddrtype_iface`` attributes to make it semantically easier to retrieve addresses.
   * - `network_ports.rb <https://github.com/agoddard/ohai-plugins/blob/master/plugins/network_ports.rb>`_
     - Adds extensions for network attributes so that Ohai can detect to which interfaces TCP and UDP ports are bound.
   * - `parse_host_plugin.rb <https://github.com/sbates/Chef-odds-n-ends/blob/master/ohai/parse_host_plugin.rb>`_
     - Adds the ability to parse a host name using three top-level attribute and five nested attributes.
   * - `r.rb <https://github.com/stevendanna/ohai-plugins/blob/master/plugins/r.rb>`_
     - Adds the ability to collect basic information about the R Project.
   * - `sysctl.rb <https://github.com/spheromak/cookbooks/blob/master/ohai/files/default/sysctl.rb>`_
     - Adds sysctl information to Ohai.
   * - `vserver.rb <https://github.com/albertsj1/ohai-plugins/blob/master/vserver.rb>`_
     - Adds extensions for virtualization attributes to allow a Linux virtual server host and guest information to be used by Ohai.
   * - `wtf.rb <https://github.com/cloudant/ohai_plugins/blob/master/wtf.rb>`_
     - Adds the irreverent wtfismyip.com service so that Ohai can determine a machine's external IPv4 address and geographical location.
   * - `xenserver.rb <https://github.com/spheromak/cookbooks/blob/master/ohai/files/default/xenserver.rb>`_
     - Adds extensions for virtualization attributes to load up Citrix XenServer host and guest information.
   * - `win32_software.rb <https://github.com/timops/ohai-plugins/blob/master/win32_software.rb>`_
     - Adds the ability for Ohai to use Windows Management Instrumentation (WMI) to discover useful information about software that is installed on any node that is running Microsoft Windows.
   * - `win32_svc.rb <https://github.com/timops/ohai-plugins/blob/master/win32_svc.rb>`_
     - Adds the ability for Ohai to query using Windows Management Instrumentation (WMI) to get information about all services that are registered on a node that is running Microsoft Windows.


Handlers
=====================================================
.. include:: ../../includes_handler/includes_handler.rst

.. include:: ../../includes_handler/includes_handler_community_handlers.rst


chef-client
=====================================================
The following plugins are available for the chef-client:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Plugin
     - Description
   * - `chef-deploy <https://github.com/ezmobius/chef-deploy>`_
     - Adds a gem that contains resources and providers for deploying Ruby web applications from recipes.
   * - `chef-gelf <https://github.com/jellybob/chef-gelf>`_
     - Adds a handler that reports run status, including changes made to a Graylog2 server.
   * - `chef-handler-twitter <https://github.com/dje/chef-handler-twitter>`_
     - Adds a handler that tweets.
   * - `chef-handler-librato <https://github.com/bscott/chef-handler-librato>`_
     - Adds a handler that sends metrics to Librato's Metrics.
   * - `chef-hatch-repo <https://github.com/xdissent/chef-hatch-repo>`_
     - Adds a knife plugin and a Vagrant provisioner that can launch a self-managed Chef server in a virtual machine or Amazon EC2.
   * - `chef-irc-snitch <https://rubygems.org/gems/chef-irc-snitch>`_
     - Adds an exception handler for chef-client runs.
   * - `chef-jenkins <https://github.com/adamhjk/chef-jenkins>`_
     - Adds the ability to use Jenkins to drive continuous deployment and synchronization of environments from a git repository.
   * - `chef-rundeck <http://rubygems.org/gems/chef-rundeck>`_
     - Adds a resource endpoint for Rundeck.
   * - `chef-solo-search <https://github.com/edelight/chef-solo-search>`_
     - Adds a cookbook library that enables searching of data bags when using chef-solo.
   * - `chef-trac-hacks <http://trac-hacks.org/wiki/CloudPlugin>`_
     - Adds the ability to fill a coordination gap between Amazon Web Services (AWS) and the chef-client.
   * - `chef-vim <https://github.com/t9md/vim-chef>`_
     - Adds a plugin that makes cookbook navigation quick and easy.
   * - `chef-vpc-toolkit <https://github.com/rackerlabs/chef_vpc_toolkit>`_
     - Adds a set of Rake tasks that provide a framework that helps automate the creation and configuration of identical virtual server groups in the cloud.
   * - `ironfan <https://github.com/infochimps-labs/ironfan>`_
     - Adds the ability to orchestrate complete clusters of machines using an expressive toolset that helps construct scalable and resilient architectures.
   * - `jclouds-chef <https://github.com/jclouds/jclouds-chef>`_
     - Adds Java and Clojure components to the Chef server API REST API.
   * - `kitchenplan <https://github.com/kitchenplan/kitchenplan>`_
     - A utility for automating the installation and configuration of a workstation on Mac OS X.
   * - `stove <https://github.com/sethvargo/stove>`_
     - A utility for releasing and managing cookbooks.
