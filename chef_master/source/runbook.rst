*****************************************************
Runbook
*****************************************************
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/runbook.rst>`__

.. tag chef_server

The Chef Infra Server acts as a hub for configuration data. The Chef Infra Server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the Chef Infra Client. Nodes use the Chef Infra Client to ask the Chef Infra Server for configuration details, such as recipes, templates, and file distributions. The Chef Infra Client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef Infra Server). This scalable approach distributes the configuration effort throughout the organization.

.. end_tag

.. tag chef_server_component_erchef_background

The front-end for the Chef Infra Server is written using `Erlang <http://www.erlang.org/>`_, which is a programming language that `first appeared in 1986 <http://en.wikipedia.org/wiki/Erlang_%28programming_language%29>`_, was open sourced in 1998, and is excellent with critical enterprise concerns like concurrency, fault-tolerance, and distributed environments. The Chef Infra Server can scale to the size of any enterprise and is sometimes referred to as Erchef.

.. end_tag

The following diagram shows the various components that are part of a Chef Infra Server deployment and how they relate to one another.

.. image:: ../../images/server_components.svg
   :width: 500px

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Bookshelf
     - .. tag chef_server_component_bookshelf

       Bookshelf is used to store cookbook content---files, templates, and so on---that have been uploaded to the Chef Infra Server as part of a cookbook version. Cookbook content is stored by content checksum. If two different cookbooks or different versions of the same cookbook include the same file or template, Bookshelf will store that file only once. The cookbook content managed by Bookshelf is stored in flat files and is separated from the Chef Infra Server and search index repositories.

       .. end_tag

       All cookbooks are stored in a dedicated repository.

   * - Erchef
     - .. tag chef_server_component_erchef

       Erchef is a complete rewrite of the core API for the Chef Infra Server, which allows it to be faster and more scalable than previous versions. The API itself is still compatible with the original Ruby-based Chef Infra Server, which means that cookbooks and recipes that were authored for the Ruby-based Chef Infra Server will continue to work on the Erlang-based Chef Infra Server. The Chef Infra Client is still written in Ruby.

       .. note:: Even though the Chef Infra Server is authored in Erlang, writing code in Erlang is NOT a requirement for using Chef.

       .. end_tag

   * - Message Queues
     - Messages are sent to the Search Index using the following components:

          #. .. tag chef_server_component_rabbitmq

             RabbitMQ is used as the message queue for the Chef Infra Server. All items that will be added to the search index repository are first added to a queue.

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

       Nginx is an open-source HTTP and reverse proxy server that is used as the front-end load balancer for the Chef Infra Server. All requests to the Chef Infra Server API are routed through Nginx.

       .. end_tag

   * - PostgreSQL
     - .. tag chef_server_component_postgresql

       PostgreSQL is the data storage repository for the Chef Infra Server.

       .. end_tag

The following sections detail how to monitor the server, manage log files, manage services, manage firewalls and ports, configure SSL, tune server configuration settings, and backup and restore data.

.. include:: server_monitor.rst

.. include:: server_logs.rst

.. include:: server_firewalls_and_ports.rst

.. include:: server_services.rst

.. include:: server_security.rst

.. include:: server_tuning.rst

.. include:: server_backup_restore.rst
