.. THIS PAGE DOCUMENTS Open Source Chef server version 11.1

=====================================================
Release Notes: Open Source Chef 11.1
=====================================================

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

What's New
=====================================================
The following items are new for Open Source Chef 11.1 and/or are changes from previous versions. The short version:

* **Support for IPv6** Support has been added to allow the Open Source Chef server and the chef-client to run in an IPv6 infrastructure.
* **Support for Custom Cookbook Storage Locations** Support has been added to allow the Open Source Chef server to point to a non-Bookshelf location for cookbook storage. For example, it is possible to offload cookbook storage to a different physical machine behind a firewall or to a proxy location that is hosted on Amazon Simple Storage Service (S3).
* **Gecode Depsolver** The Open Source Chef server switches back to using the Gecode depsolver. This resolves cookbook dependency issues that were seen by some users due to the less-robust nature of the Erlang-based dependency solver that was added in Open Source Chef 11.0.
* **RabbitMQ default port changes** The default port used by RabbitMQ is changed from 5672 to 8672. This resolves a conflict with the default port on the Red Hat 6 platform.
* **chef-server-ctl upgrade** A new subcommand is available for upgrading the Open Source Chef server in standalone topologies.

Support for IPv6
-----------------------------------------------------
The Open Source Chef server supports IPv6. Set the ``ip_version`` setting in the ``chef-server.rb`` file to ``ipv6`` to enable IPv6 mode. Once enabled, the Open Source Chef server will accept IPv6 connections internally and externally and will listen for both IPv4 and IPv6 connections for certain services. (The Open Source Chef server will continue to accept IPv4 connections as well.)

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ip_version``
     - Enable IPv6 and run Open Source Chef in "dual IPv4/IPv6 mode". When this setting is ``ipv6``, the Open Source Chef server uses IPv6 for all internal comunication and is able to accept external communications that are using IPv6 (via the Nginx load balancer). Default value: ``ipv4``. For example:
	   
	   .. code-block:: ruby
	   
	      ip_version ipv6
       
	   without an equals symbol (``=``).

       .. note:: Setting ``ip_version`` to ``ipv6`` will also set ``nginx['enable_ipv6']`` to ``true``.

Literal IPv6 Addresses
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If a URL is set to a literal IPv6 address (and not a hostname), the IPv6 address must be bracketed (``[ ]``) or the Open Source Chef server will not be able to recognize it as an IPv6 address. For example:

.. code-block:: ruby

   bookshelf['url'] "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]"

Nginx and IPv6
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following setting is used to configure Nginx support for IPv6 in Open Source Chef:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``nginx['enable_ipv6']``
     - Enable Internet Protocol version 6 (IPv6) addresses. Default value: ``false``. This setting is automatically set to true when ``ip_version`` is set to ``ipv6``.

New Listen Addresses
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The default values for the following settings were updated:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``bookshelf['listen']``
     - Previous default value: ``127.0.0.1``. New default value: ``0.0.0.0``.
   * - ``chef_solr['ip_address']``
     - Previous default value: ``127.0.0.1``. New default value: ``0.0.0.0``.
   * - ``postgresql['listen_address']``
     - Previous default value: ``localhost``. New default value: ``0.0.0.0``.
   * - ``rabbitmq['node_ip_address']``
     - Previous default value: ``127.0.0.1``. New default value: ``0.0.0.0``.

These changes may require updates to firewall rules for your organization.

Custom Cookbook Storage
-----------------------------------------------------
By defalt, Open Source Chef stores cookbooks in Bookshelf. Open Source Chef is designed for a standalone configuration, which means Bookshelf is located on the same physical machine. It is possible to offload cookbook storage, such as a different physical machine behind the firewall or to a proxy location that is hosted on Amazon Simple Storage Service (S3).

The following settings may be changed to support the storing of cookbooks in a non-default location: 

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``bookshelf['external_url']``
     - The URL from which the chef-client is to download cookbooks. By default, this is the ``Host:`` header provided by the chef-client when it contacts the Chef server. When cookbook storage is located behind a firewall and/or when the ``Host:`` header is not used, this value must be a URL that is accessible to the chef-client. Default value: ``:host_header``.
   * - ``bookshelf['url']``
     - The URL at which cookbooks are stored.
	 
In addition, these settings may be necessary when configuring the storing of cookbooks in a non-default location: 

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``bookshelf['s3_access_key_id']``
     - The access key identifier.
   * - ``bookshelf['s3_secret_key_id']``
     - The secret key.	 
   * - ``erchef['s3_bucket']``
     - The bucket name. Default value: ``bookshelf``.	 

New ``upgrade`` Subcommand
-----------------------------------------------------
.. warning:: This section applies only to upgrading standalone configurations of the Open Source Chef server.

The upgrade process for a standalone configuration Open Source Chef server has been simplified (starting with upgrades from version 11.0.4 to the current version). This process allows an in-place upgrade of the server components and applies all of the necessary SQL changes and updates without having to reinstall any components and without having to re-import data.

.. warning:: Back up the server data before running the ``upgrade`` command. Even though it's not a requirement (because it's an in-place upgrade) and even though there is no step for "restoring data" as part of the upgrade process, in the event something unexpected does happen, it's important to be able to restore this data to the server.


chef-server-ctl upgrade
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``chef-server-ctl`` command has a new subcommand: ``upgrade``:

``upgrade``
   Use for in-place upgrades of the Open Source Chef server, version 11.0.4 (or higher). This subcommand will apply the necessary SQL changes without having to back up data and install the server from scratch. (Data should still be backed up before performing the upgrade, just to ensure that it is available, should it be needed.)
   
   .. note:: This subcommand may only be used when the Open Source Chef server is configured for a standalone topology and it assumes that all services used by Open Source Chef are enabled.

Upgrade Process
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. warning:: This section applies only to upgrading standalone configurations of the Open Source Chef server.

The new upgrade process is simpler. Update the package on the system, and then run the ``upgrade`` subcommand:

#. After all of the services have shut down, update the package (using the appropriate package manager for the system on which the server is running):
   
   .. code-block:: bash
   
      $ dpkg -i package.deb

#. Upgrade the server itself:
   
   .. code-block:: bash
   
      $ chef-server-ctl upgrade
   
   .. note:: The following error may be present in the logs for PostgreSQL during the upgrade process: ``ERROR: duplicate key value violates unique constraint "checksums_pkey"``. This error does not represent an issue with the upgrade process and can be safely ignored.

#. Check the status of everything:
   
   .. code-block:: bash
   
      $ chef-server-ctl status



What's Fixed
=====================================================
The following bugs were fixed:

* `CHEF-5038 <http://tickets.opscode.com/browse/CHEF-5038>`_  --- Setting NGINX logs to non-standard dir in chef-server doesn't work
* `CHEF-5031 <http://tickets.opscode.com/browse/CHEF-5031>`_  --- chef-server-ctl reconfigure breaks if chef_pedant or estatsd settings are in chef-server.rb
* `CHEF-4576 <http://tickets.opscode.com/browse/CHEF-4576>`_  --- Chef Server nginx should be compiled with ipv6 support
* `CHEF-4511 <http://tickets.opscode.com/browse/CHEF-4511>`_  --- Error in chef_wm/rebar.config
* `CHEF-4504 <http://tickets.opscode.com/browse/CHEF-4504>`_  --- knife upload interupts with "500 Internal Server Error"
* `CHEF-4382 <http://tickets.opscode.com/browse/CHEF-4382>`_  --- using a non-default postgresql['port'] in chef-server.rb breaks "chef-server-ctl reconfigure"
* `CHEF-4346 <http://tickets.opscode.com/browse/CHEF-4346>`_  --- Default Rabbitmq port should be changed to avoid collision with qpidd
* `CHEF-4235 <http://tickets.opscode.com/browse/CHEF-4235>`_  --- Chef Omnibus cannot be configured with non-default postgres port
* `CHEF-4188 <http://tickets.opscode.com/browse/CHEF-4188>`_  --- runit embedded in chef-server /etc/inittab entry conflicts with user-installed runit
* `CHEF-4086 <http://tickets.opscode.com/browse/CHEF-4086>`_  --- getting a latest cookbook list from erchef over split horizon DNS results in great vengeance and furious anger
* `CHEF-3991 <http://tickets.opscode.com/browse/CHEF-3991>`_  --- Dialyzer fix for estatsd
* `CHEF-3976 <http://tickets.opscode.com/browse/CHEF-3976>`_  --- chef_objects rejects "provides 'service[foo]'"" in metadata
* `CHEF-3975 <http://tickets.opscode.com/browse/CHEF-3975>`_  --- Searching for compound attributes in data bags will not yield results
* `CHEF-3921 <http://tickets.opscode.com/browse/CHEF-3921>`_  --- Missing Dependency causes chef server to consume all the CPU
* `CHEF-3838 <http://tickets.opscode.com/browse/CHEF-3838>`_  --- RabbitMQ does not start on Oracle or Amazon Linux
* `CHEF-2380 <http://tickets.opscode.com/browse/CHEF-2380>`_  --- Clients Should be Able to Upload Their Own Public Keys to Chef-Server
* `CHEF-2245 <http://tickets.opscode.com/browse/CHEF-2245>`_  --- chef-solr jetty request logs go into /var/chef/solr-jetty/logs instead of /var/log/chef

For the Open Source Chef web user interface, the following bugs were fixed:

* `CHEF-5284 <http://tickets.opscode.com/browse/CHEF-5284>`_  --- Upgrade Rails to 3.2.18
* `CHEF-5242 <http://tickets.opscode.com/browse/CHEF-5242>`_  --- Fix Extra Apostrophe in webui JSON editor
* `CHEF-5056 <http://tickets.opscode.com/browse/CHEF-5056>`_  --- Upgrade Rails to 3.2.17
* `CHEF-4858 <http://tickets.opscode.com/browse/CHEF-4858>`_  --- Upgrade chef-server-webui Rails to 3.2.16
* `CHEF-4757 <http://tickets.opscode.com/browse/CHEF-4757>`_  --- ruby cookbook file in web UI shows up as "Binary file not shown"
* `CHEF-4403 <http://tickets.opscode.com/browse/CHEF-4403>`_  --- Environment edit screen: Stop json being escaped as html
* `CHEF-4040 <http://tickets.opscode.com/browse/CHEF-4040>`_  --- Environment existing settings are not displayed correctly when editing environments or nodes via the WebUI
* `CHEF-4004 <http://tickets.opscode.com/browse/CHEF-4004>`_  --- Select to Close Existing Environment Run List Uses Incorrect Rails Helper
* `CHEF-3952 <http://tickets.opscode.com/browse/CHEF-3952>`_  --- Cookbook view reports ERROR: undefined method 'close!' for nil:NilClass
* `CHEF-3951 <http://tickets.opscode.com/browse/CHEF-3951>`_  --- databag item creation not possible
* `CHEF-3883 <http://tickets.opscode.com/browse/CHEF-3883>`_  --- Chef 11 status page does not list all nodes
* `CHEF-3267 <http://tickets.opscode.com/browse/CHEF-3267>`_  --- webui status page doesn't respect environment selection
* `CHEF-2060 <http://tickets.opscode.com/browse/CHEF-2060>`_  --- Auto-complete is enabled in Chef html - /users/login_exec
 
.. What's Improved
.. =====================================================
.. The following improvements were made:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. 
.. New Features
.. =====================================================
.. The following features were added:
.. 
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
.. * `CHEF-xxxxx <http://tickets.opscode.com/browse/CHEF-xxxxx>`_  --- xxxxx
