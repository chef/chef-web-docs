=====================================================
About Knife Cloud Plugins
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/plugin_knife.rst>`__

.. tag plugin_knife_summary

A knife plugin is a set of one (or more) subcommands that can be added to knife to support additional functionality that is not built-in to the base set of knife subcommands. Many of the knife plugins are built by members of the Chef community and several of them are built and maintained by Chef.

.. end_tag

* The same :doc:`common options </knife_common_options>` used by knife subcommands can also be used by knife plug-ins
* A knife plugin can make authenticated API requests to the Chef server

Build a :doc:`custom plugin </plugin_knife_custom>` or use one of the following plugins that are maintained by Chef:

The following knife plug-ins are maintained by Chef:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Subcommand
     - Description
   * - `knife-azure <https://github.com/chef/knife-azure>`__
     - .. tag plugin_knife_azure

       Microsoft Azure is a cloud hosting platform from Microsoft that provides virtual machines for Linux and Windows Server, cloud and database services, and more. The ``knife azure`` subcommand is used to manage API-driven cloud servers that are hosted by Microsoft Azure.

       .. end_tag

   * - `knife-bluebox <https://github.com/chef/knife-bluebox>`__
     - Blue Box provides on-demand computing that is backed by a proprietary cloud operating system. The ``knife bluebox`` subcommand is used to manage API-driven cloud servers that are hosted by Blue Box.
   * - `knife-ec2 <https://github.com/chef/knife-ec2>`__
     - Amazon EC2 is a web service that provides resizable compute capacity in the cloud, based on preconfigured operating systems and virtual application software using Amazon Machine Images (AMI). The ``knife ec2`` subcommand is used to manage API-driven cloud servers that are hosted by Amazon EC2.
   * - `knife-eucalyptus <https://github.com/chef/knife-eucalyptus>`__
     - Eucalyptus is an infrastructure as a service (IaaS) platform that supports hybrid-IaaS configurations that allow data to move between hosted and on-premise data centers. The ``knife eucalyptus`` subcommand is used to manage API-driven cloud servers that are hosted by Eucalyptus.
   * - `knife-google <https://github.com/chef/knife-google>`__
     - Google Compute Engine is a cloud hosting platform that offers scalable and flexible virtual machine computing. The ``knife google`` subcommand is used to manage API-driven cloud servers that are hosted by Google Compute Engine.
   * - `knife-linode <https://github.com/chef/knife-linode>`__
     - Linode is a cloud hosting platform that provides virtual private server hosting with full root access and the ability to use your own kernel. The ``knife linode`` subcommand is used to manage API-driven cloud servers that are hosted by Linode.
   * - `knife-openstack <https://github.com/chef/knife-openstack>`__
     - The ``knife openstack`` subcommand is used to manage API-driven cloud servers that are hosted by OpenStack.
   * - `knife-rackspace <https://github.com/chef/knife-rackspace>`__
     - Rackspace is a cloud-driven platform of virtualized servers that provide services for storage and data, platform and networking, and cloud computing. The ``knife rackspace`` subcommand is used to manage API-driven cloud servers that are hosted by Rackspace cloud services.
   * - `knife-terremark <https://github.com/chef/knife-terremark>`__
     - Terremark is a cloud hosting platform that provides cloud, IT infrastructure, and managed hosting services. The ``knife terremark`` subcommand is used to manage API-driven cloud servers that are hosted by Terremark.
   * - `knife-vcloud <https://github.com/chef/knife-vcloud>`__
     - .. tag plugin_knife_windows_summary

       The ``knife windows`` subcommand is used to configure and interact with nodes that exist on server and/or desktop machines that are running Microsoft Windows. Nodes are configured using WinRM, which allows native objects---batch scripts, Windows PowerShell scripts, or scripting library variables---to be called by external applications. The ``knife windows`` subcommand supports NTLM and Kerberos methods of authentication.

       .. end_tag
