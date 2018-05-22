*****************************************************
Runbook
*****************************************************
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/runbook.rst>`__

.. tag chef_server

The Chef server acts as a hub for configuration data. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client. Nodes use the chef-client to ask the Chef server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef server). This scalable approach distributes the configuration effort throughout the organization.

.. end_tag

.. tag chef_server_component_erchef_background

The front-end for the Chef server is written using `Erlang <http://www.erlang.org/>`_, which is a programming language that `first appeared in 1986 <http://en.wikipedia.org/wiki/Erlang_%28programming_language%29>`_, was open sourced in 1998, and is excellent with critical enterprise concerns like concurrency, fault-tolerance, and distributed environments. The Chef server can scale to the size of any enterprise and is sometimes referred to as Erchef.

.. end_tag

The following diagram shows the various components that are part of a Chef server deployment and how they relate to one another.

.. image:: ../../images/server_components.svg
   :width: 500px

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Bookshelf
     - .. tag chef_server_component_bookshelf

       Bookshelf is used to store cookbook content---files, templates, and so on---that have been uploaded to the Chef server as part of a cookbook version. Cookbook content is stored by content checksum. If two different cookbooks or different versions of the same cookbook include the same file or template, Bookshelf will store that file only once. The cookbook content managed by Bookshelf is stored in flat files and is separated from the Chef server and search index repositories.

       .. end_tag

       All cookbooks are stored in a dedicated repository.
   * - WebUI
     - .. tag chef_server_component_webui

       chef-server-webui is a Ruby on Rails application that hosts the web interface for the Chef server.

       .. end_tag

   * - Erchef
     - .. tag chef_server_component_erchef

       Erchef is a complete rewrite of the core API for the Chef server, which allows it to be faster and more scalable than previous versions. The API itself is still compatible with the original Ruby-based Chef server, which means that cookbooks and recipes that were authored for the Ruby-based Chef server will continue to work on the Erlang-based Chef server. The chef-client is still written in Ruby.

       .. note:: Even though the Chef server is authored in Erlang, writing code in Erlang is NOT a requirement for using Chef.

       .. end_tag

   * - Message Queues
     - Messages are sent to the Search Index using the following components:

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
   * - Nginx
     - .. tag chef_server_component_nginx

       Nginx is an open-source HTTP and reverse proxy server that is used as the front-end load balancer for the Chef server. All requests to the Chef server API are routed through Nginx.

       .. end_tag

   * - PostgreSQL
     - .. tag chef_server_component_postgresql

       PostgreSQL is the data storage repository for the Chef server.

       .. end_tag

The following sections detail how to monitor the server, manage log files, manage services, manage firewalls and ports, configure SSL, tune server configuration settings, and backup and restore data.

.. include:: server_monitor.rst

.. include:: server_logs.rst

.. include:: server_firewalls_and_ports.rst

.. include:: server_services.rst

.. include:: server_security.rst

.. include:: server_tuning.rst

.. include:: server_backup_restore.rst

