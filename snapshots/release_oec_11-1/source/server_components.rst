.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.1

=====================================================
Chef Server Components
=====================================================

The Chef server acts as a hub for configuration data. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client. Nodes use the chef-client to ask the Chef server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef server). This scalable approach distributes the configuration effort throughout the organization.

Starting with the release of Chef server 11, the front-end for the Chef server is written using `Erlang <http://www.erlang.org/>`_, which is a programming language that `first appeared in 1986 <http://en.wikipedia.org/wiki/Erlang_%28programming_language%29>`_, was open sourced in 1998, and is excellent with critical enterprise concerns like concurrency, fault-tolerance, and distributed environments. The Chef server can scale to the size of any enterprise and is sometimes referred to as Erchef.

The following diagram shows the various components that are part of a Chef server deployment and how they relate to one another.

.. image:: ../../images_old/server_components_oec.png

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Bookshelf
     - Bookshelf is used to store cookbook content---files, templates, and so on---that have been uploaded to the Chef server as part of a cookbook version. Cookbook content is stored by content checksum. If two different cookbooks or different versions of the same cookbook include the same file or template, Bookshelf will store that file only once. The cookbook content managed by Bookshelf is stored in flat files and is separated from the Chef server and search index repositories.

       All cookbooks are stored in a dedicated repository.
   * - WebUI
     - chef-server-webui is a Ruby on Rails 3.0 application that hosts the web interface for the Chef server.
   * - Erchef
     - Erchef is a complete rewrite of the core API for the Chef server, which allows it to be faster and more scalable than previous versions. The API itself is still compatible with the original Ruby-based Chef server, which means that cookbooks and recipes that were authored for the Ruby-based Chef server will continue to work on the Erlang-based Chef server. The chef-client is still written in Ruby.

       .. note:: Even though the Chef server is authored in Erlang, writing code in Erlang is NOT a requirement for using Chef.
   * - Message Queues
     - Messages are sent to the Search Index using the following components:
       
          #. RabbitMQ is used as the message queue for the Chef server. All items that will be added to the search index repository are first added to a queue.
          #. chef-expander is used to pull messages from the RabbitMQ queue, process them into the required format, and then post them to chef-solr for indexing.
          #. chef-solr wraps Apache Solr and exposes its REST API for indexing and search.

       All messages are added to a dedicated search index repository.
   * - Nginx
     - Nginx is an open-source HTTP and reverse proxy server that is used as the front-end load balancer for the Chef server. All requests to the Chef server API are routed through Nginx.
   * - PostgreSQL
     - PostgreSQL is the data storage repository for the Chef server.
