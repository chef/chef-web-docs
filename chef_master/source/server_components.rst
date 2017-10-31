=====================================================
Chef Server Components
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_components.rst>`__

.. tag chef_server

The Chef server acts as a hub for configuration data. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client. Nodes use the chef-client to ask the Chef server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef server). This scalable approach distributes the configuration effort throughout the organization.

.. end_tag

.. tag chef_server_component_erchef_background

The front-end for the Chef server is written using `Erlang <http://www.erlang.org/>`_, which is a programming language that `first appeared in 1986 <http://en.wikipedia.org/wiki/Erlang_%28programming_language%29>`_, was open sourced in 1998, and is excellent with critical enterprise concerns like concurrency, fault-tolerance, and distributed environments. The Chef server can scale to the size of any enterprise and is sometimes referred to as Erchef.

.. end_tag

Server Components
=====================================================
The following diagram shows the various components that are part of a Chef server deployment and how they relate to one another.

.. image:: ../../images/server_components.svg
   :width: 500px

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Clients
     - The Chef server is accessed primarily by nodes that are under management by Chef, as the chef-client runs occur. It is also accessed by individuals who maintain cookbooks and policy that is stored on the Chef server, typically from a workstation. And also by individual users with credentials to Chef server components, such as the Chef management console.
   * - Load Balancer
     - .. tag chef_server_component_nginx

       Nginx is an open-source HTTP and reverse proxy server that is used as the front-end load balancer for the Chef server. All requests to the Chef server API are routed through Nginx.

       .. end_tag

   * - Chef Manage
     - .. tag chef_server_component_webui

       chef-server-webui is a Ruby on Rails application that hosts the web interface for the Chef server.

       .. end_tag

       The Chef management console uses the Chef server API for all communication to the Chef server.
   * - Chef Server
     - .. tag chef_server_component_erchef

       Erchef is a complete rewrite of the core API for the Chef server, which allows it to be faster and more scalable than previous versions. The API itself is still compatible with the original Ruby-based Chef server, which means that cookbooks and recipes that were authored for the Ruby-based Chef server will continue to work on the Erlang-based Chef server. The chef-client is still written in Ruby.

       .. note:: Even though the Chef server is authored in Erlang, writing code in Erlang is NOT a requirement for using Chef.

       .. end_tag

   * - Bookshelf
     - .. tag chef_server_component_bookshelf

       Bookshelf is used to store cookbook content---files, templates, and so on---that have been uploaded to the Chef server as part of a cookbook version. Cookbook content is stored by content checksum. If two different cookbooks or different versions of the same cookbook include the same file or template, Bookshelf will store that file only once. The cookbook content managed by Bookshelf is stored in flat files and is separated from the Chef server and search index repositories.

       .. end_tag

       All cookbooks are stored in a dedicated repository.
   * - Message Queues
     - Messages are sent to the search index using the following components:

          #. .. tag chef_server_component_rabbitmq

             RabbitMQ is used as the message queue for the Chef server. All items that will be added to the search index repository are first added to a queue.

             .. end_tag

          #. .. tag chef_server_component_expander

             chef-expander is used to pull messages from the RabbitMQ queue, process them into the required format, and then post them to chef-solr for indexing.

             .. end_tag

          #. .. tag chef_server_component_solr

             chef-solr wraps Apache Solr and exposes its REST API for indexing and search.

             .. end_tag

       All messages are added to a dedicated search index repository.
   * - PostgreSQL
     - .. tag chef_server_component_postgresql

       PostgreSQL is the data storage repository for the Chef server.

       .. end_tag

Capacity Planning
=====================================================
This section provides guidance for capacity planning and how to choose the right configuration--standalone, high availability, or tiered--for the Chef server. This section provides guidance and not hard/fast rules. This is because some requests to the Chef server API are more computationally expensive than others. In general, it's better to start small and then scale the Chef server as needed. Premature optimization can hinder more than help because it may introduce unnecessary complexity.

Scaling the Chef Server
-----------------------------------------------------
The Chef server itself is highly scalable. A single virtual machine running the Chef server can handle requests for many thousands of nodes. As the scale increases, it's a straightforward process to expand into a tiered front-end, back-end architecture with horizontally scaled front-ends to relieve pressure on system bottlenecks.

That said, it's best to isolate failure domains with their own Chef server, rather than trying to run every node in an infrastructure from a single central, monolithic Chef server instance/cluster.

For instance, if there are West coast and East coast data centers, it is best to have one Chef server instance in each datacenter. Deploys to each Chef server can be synchronized upstream by CI software. The primary limiting bottleneck for Chef server installations is almost always input/output operations per second (IOPS) performance for the database filesystem.

CCRs/min
-----------------------------------------------------
The key unit of measure for scaling the Chef server is the number of chef-client runs per minute: CCRs/min. For example, 500 nodes set to check in every 30 minutes is equivalent to 16.66 CCRs/min.

Typically, the Chef server does not require a high availability or tiered topology until the
number of CCRs/min is higher than 333/min (approximately 10k nodes).

While synthetic benchmarks should be taken with a grain of salt, as they don't typically represent real-world performance, internal synthetic benchmarks at Chef have seen a standalone Chef server installed on a ``c3.2xlarge`` Amazon Web Services (AWS) instance handle more than 1,000 CCRs/min (30k nodes).

Assumptions
-----------------------------------------------------
Several factors may influence server scalability. All server sizing recommendations are based on these assumptions:

* chef-client runs are daemonized, and are not initiated by a cron job. Using cron to schedule runs can create "thundering herd" problems
* chef-client runs are set to a default 30-minute interval with a 5-minute splay
* Search and ``partial_search`` are utilized, but not heavily
* The number of cookbooks per organization, across all versions, on the Chef server is under 500. (Multiple organizations with fewer than 500 cookbooks each, that still add up to a total of more than 500 cookbooks server-wide, is fine.)
* The default maximum allowable size for a node object is 1MB, although it is rare for nodes to exceed 150KB. Though compressed, this data is replicated twice, once in Apache Solr, and once in PostgreSQL. In practice, allowing a conservative 2MB of storage on the disk partition per node should be sufficient
* Disk space estimates assume that the Reporting add-on is not installed

Host Specifications
-----------------------------------------------------
The following sections describe the host specifications for various sizes of CCRs/min and help show when to consider moving from a standalone topology to a high availability or tiered topology.

**UP TO 33 CCRs/Min (approx. 1,000 nodes):**

* Chef recommends a single virtual machine instance
* Start with 2 CPU cores and 8GB of RAM, which is equivalent to an Amazon EC2 ``m3.large`` instance
* Allocate 2MB of disk space on the data partition per managed node

**UP TO 167 CCRs/Min (approx. 5,000 nodes):**

* Chef recommends a single virtual machine instance
* Start with 4 CPU cores and 16GB of RAM, which is equivalent to an Amazon EC2 ``m3.xlarge`` instance

**UP TO 333 CCRs/Min (Approx. 10,000 nodes):**

* Chef recommends a single virtual machine instance
* Start with 8 CPU cores and 32GB of RAM, which is equivalent to an Amazon EC2 ``m3.2xlarge`` instance

**UP TO 667 CCRs/Min (Approx. 20,000 nodes):**

* Chef recommends two hosts, one front-end and one back-end
* The disk requirement for the front-end server is negligible
* Start with 8 CPU cores and 32GB of RAM for each host, which is equivalent to an Amazon EC2 ``m3.2xlarge`` instance

**Scaling beyond 20,000 nodes on a single cluster:**

* Additional capacity can be gained by placing the front-end node behind an HTTP load balancer, and then scaling front-end nodes horizontally
* Chef recommends that Chef professional services be engaged to help with capacity and architectural planning at this size

External Cookbooks
=====================================================
The following diagram highlights the specific changes that occur when cookbooks are stored at an external location, such as Amazon Simple Storage Service (S3).

.. image:: ../../images/server_components_s3.svg
   :width: 500px

The following table describes the components that are different from the default configuration of the Chef server when cookbooks are stored at an external location:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Clients
     - The Chef server will provide signed URLs for cookbook requests made by the various clients (individual users, knife requests, and from the chef-client that is installed on nodes under management by Chef).
   * - Load Balancer
     - The signed URLs for cookbooks are pointed here, and then routed to cookbook storage, as required.
   * - Chef Server
     - .. tag chef_server_component_erchef

       Erchef is a complete rewrite of the core API for the Chef server, which allows it to be faster and more scalable than previous versions. The API itself is still compatible with the original Ruby-based Chef server, which means that cookbooks and recipes that were authored for the Ruby-based Chef server will continue to work on the Erlang-based Chef server. The chef-client is still written in Ruby.

       .. note:: Even though the Chef server is authored in Erlang, writing code in Erlang is NOT a requirement for using Chef.

       .. end_tag

   * - Amazon Simple Storage Service (S3)
     - .. tag chef_server_component_bookshelf

       Bookshelf is used to store cookbook content---files, templates, and so on---that have been uploaded to the Chef server as part of a cookbook version. Cookbook content is stored by content checksum. If two different cookbooks or different versions of the same cookbook include the same file or template, Bookshelf will store that file only once. The cookbook content managed by Bookshelf is stored in flat files and is separated from the Chef server and search index repositories.

       .. end_tag

       This represents external cookbooks storage at Amazon Simple Storage Service (S3).

.. _external_bookshelf_settings:

AWS Settings
-----------------------------------------------------

To configure external cookbook storage using Amazon Simple Storage
Service (S3) set the following configuration settings in the
chef-server.rb file and run ``chef-server-ctl reconfigure``:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``bookshelf['access_key_id']``
     - The access key identifier. Default value: generated by default. Specifying this directly in the configuration file is discouraged. Please use ``chef-server-ctl set-secret bookshelf access_key_id`` from the :ref:`ctl_chef_server_secrets_management` commands.
   * - ``bookshelf['secret_access_key']``
     - The secret key. Default value: generated by default.  Specifying this directly in the configuration file is discouraged. Please use ``chef-server-ctl set-secret bookshelf secret_access_key`` from the :ref:`ctl_chef_server_secrets_management` commands.
   * - ``opscode_erchef['s3_bucket']``
     - The name of the Amazon Simple Storage Service (S3) bucket. Default value: ``bookshelf``.
   * - ``bookshelf['vip']``
     - The virtual IP address or host name of the Amazon Simple Service (S3) API. Default value: ``127.0.0.1``.

The following optional settings are also available and may require
modification when using an external S3 provider:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_erchef['nginx_bookshelf_caching']``
     - Whether Nginx is used to cache cookbooks. When ``:on``, Nginx serves up the cached content instead of forwarding the request. Default value: ``:off``.
   * - ``opscode_erchef['s3_parallel_ops_fanout']``
     - Default value: ``20``.
   * - ``opscode_erchef['s3_parallel_ops_timeout']``
     - Default value: ``5000``.
   * - ``opscode_erchef['s3_url_expiry_window_size']``
     - The frequency at which unique URLs are generated. This value may be a specific amount of time, i.e. ``15m`` (fifteen minutes) or a percentage of the value of ``s3_url_ttl``, i.e. ``10%``. Default value: ``:off``.
   * - ``opscode_erchef['s3_url_ttl']``
     - The amount of time (in seconds) before connections to the server expire. If node bootstraps are timing out, increase this setting. Default value: ``28800``.

.. DO NOT CHANGE THE FOLLOWING TITLE BECAUSE IT IS LINKED FROM THE ERROR MESSAGES IN THE CODE FOR THESE SETTINGS.

External PostgreSQL
=====================================================
.. tag server_ha_external_postgresql

The following diagram highlights the specific changes that occur when PostgreSQL is configured and managed independently of the Chef server configuration.

.. image:: ../../images/server_components_postgresql.svg
   :width: 500px

The following table describes the components in an external PostgreSQL configuration that are different from the default configuration of the Chef server:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Chef Server
     - The Chef server configuration file is updated to point to an independently configured set of servers for PostgreSQL.
   * - PostgreSQL
     - .. tag chef_server_component_postgresql

       PostgreSQL is the data storage repository for the Chef server.

       .. end_tag

       This represents the independently configured set of servers that are running PostgreSQL and are configured to act as the data store for the Chef server.

.. end_tag

.. DO NOT CHANGE THE FOLLOWING TITLE BECAUSE IT IS LINKED FROM THE ERROR MESSAGES IN THE CODE FOR THESE SETTINGS.

PostgreSQL Settings
-----------------------------------------------------
.. tag server_ha_external_postgresql_settings

Use the following configuration settings in the chef-server.rb file to configure PostgreSQL for use with the Chef server:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``postgresql['db_superuser']``
     - Required when ``postgresql['external']`` is set to ``true``. The PostgreSQL user name. This user must be granted either the ``CREATE ROLE`` and ``CREATE DATABASE`` permissions in PostgreSQL or be granted ``SUPERUSER`` permission. This user must also have an entry in the host-based authentication configuration file used by PostgreSQL (traditionally named ``pg_hba.conf``). Default value: ``'superuser_userid'``.
   * - ``postgresql['db_superuser_password']``
     - The password for the user specified by ``postgresql['db_superuser']``.  Required when ``postgresql['external']`` is set to ``true``.

       The db_superuser_password can also be set using ``chef-server-ctl set-db-superuser-password`` from the :ref:`ctl_chef_server_secrets_management` commands.
   * - ``postgresql['external']``
     - Required. Set to ``true`` to run PostgreSQL external to the Chef server. Must be set once only on a new installation of the Chef server before the first ``chef-server-ctl reconfigure`` command is run. If this is set after a reconfigure or set to ``false``, any reconfigure of the Chef server will return an error. Default value: ``false``.
   * - ``postgresql['port']``
     - Optional when ``postgresql['external']`` is set to ``true``. The port on which the service is to listen. The port used by PostgreSQL if that port is **not** 5432. Default value: ``5432``.
   * - ``postgresql['vip']``
     - Required when ``postgresql['external']`` is set to ``true``. The virtual IP address. The host for this IP address must be online and reachable from the Chef server via the port specified by ``postgresql['port']``. Set this value to the IP address or hostname for the machine on which external PostgreSQL is located when ``postgresql['external']`` is set to ``true``.

.. end_tag

.. note:: See the list of `error messages that may be present </error_messages.html#external-postgresql>`_ when configuring the Chef server to use a remote PostgreSQL server.

Bookshelf Settings
-----------------------------------------------------
In instances that require cookbooks to be stored within a SQL backend, such as in a high availability setup, you must set the ``storage_type`` to ``:sql``:

   .. code-block:: ruby

      bookshelf['storage_type'] = :sql
