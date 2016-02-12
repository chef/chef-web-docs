.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.1

=====================================================
Chef Server Components
=====================================================

The |chef server| acts as a hub for configuration data. The |chef server| stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the |chef client|. Nodes use the |chef client| to ask the |chef server| for configuration details, such as recipes, templates, and file distributions. The |chef client| then does as much of the configuration work as possible on the nodes themselves (and not on the |chef server|). This scalable approach distributes the configuration effort throughout the organization.

Starting with the release of |chef server| 11, the front-end for the |chef server| is written using `Erlang <http://www.erlang.org/>`_, which is a programming language that `first appeared in 1986 <http://en.wikipedia.org/wiki/Erlang_%28programming_language%29>`_, was open sourced in 1998, and is excellent with critical enterprise concerns like concurrency, fault-tolerance, and distributed environments. The |chef server| can scale to the size of any enterprise and is sometimes referred to as |erchef|.

The following diagram shows the various components that are part of a |chef server| deployment and how they relate to one another.

.. image:: ../../images_old/server_components_oec.png

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Bookshelf
     - |chef bookshelf| is used to store cookbook content---files, templates, and so on---that have been uploaded to the |chef server| as part of a cookbook version. Cookbook content is stored by content checksum. If two different cookbooks or different versions of the same cookbook include the same file or template, |chef bookshelf| will store that file only once. The cookbook content managed by |chef bookshelf| is stored in flat files and is separated from the |chef server| and search index repositories.

       All cookbooks are stored in a dedicated repository.
   * - WebUI
     - |chef server webui| is a |ruby on rails| 3.0 application that hosts the web interface for the |chef server|.
   * - Erchef
     - |erchef| is a complete rewrite of the core API for the |chef server|, which allows it to be faster and more scalable than previous versions. The API itself is still compatible with the original |ruby|-based |chef server|, which means that cookbooks and recipes that were authored for the |ruby|-based |chef server| will continue to work on the |erlang|-based |chef server|. The |chef client| is still written in |ruby|.

       .. note:: Even though the |chef server| is authored in |erlang|, writing code in |erlang| is NOT a requirement for using |chef|.
   * - Message Queues
     - Messages are sent to the Search Index using the following components:
       
          #. |rabbitmq| is used as the message queue for the |chef server|. All items that will be added to the search index repository are first added to a queue.
          #. |chef expander| is used to pull messages from the |rabbitmq| queue, process them into the required format, and then post them to |chef solr| for indexing.
          #. |chef solr| wraps |apache solr| and exposes its REST API for indexing and search.

       All messages are added to a dedicated search index repository.
   * - Nginx
     - |nginx| is an open-source HTTP and reverse proxy server that is used as the front-end load balancer for the |chef server|. All requests to the |api chef server| are routed through |nginx|.
   * - PostgreSQL
     - |postgresql| is the data storage repository for the |chef server|.