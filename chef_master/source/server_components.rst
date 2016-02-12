=====================================================
About the |chef server_title|
=====================================================

.. include:: ../../includes_chef_server/includes_chef_server.rst

.. include:: ../../includes_chef_server/includes_chef_server_component_erchef_background.rst

The following diagram shows the various components that are part of a |chef server| deployment and how they relate to one another.

.. image:: ../../images/server_components.svg
   :width: 500px

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Clients
     - The |chef server| is accessed primarily by nodes that are under management by |chef|, as the |chef client| runs occur. It is also accessed by individuals who maintain cookbooks and policy that is stored on the |chef server|, typically from a workstation. And also by individual users with credentials to |chef server| components, such as the |chef manage|.
   * - Load Balancer
     - .. include:: ../../includes_chef_server/includes_chef_server_component_nginx.rst
   * - |chef manage_title|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_webui.rst

       The |chef manage| uses the |api chef server| for all communication to the |chef server|.
   * - |chef server_title|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_erchef.rst
   * - |chef bookshelf|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_bookshelf.rst

       All cookbooks are stored in a dedicated repository.
   * - Message Queues
     - Messages are sent to the search index using the following components:
       
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_rabbitmq.rst
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_expander.rst
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_solr.rst

       All messages are added to a dedicated search index repository.
   * - |postgresql|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_postgresql.rst


Capacity Planning
=====================================================
This section provides guidance for capacity planning and how to choose the right configuration--standalone, high availability, or tiered--for the |chef server|. This section provides guidance and not hard/fast rules. This is because some requests to the |api chef server| are more computationally expensive than others. In general, it's better to start small and then scale the |chef server| as needed. Premature optimization can hinder more than help because it may introduce unnecessary complexity.

Scaling the Chef Server
-----------------------------------------------------
The |chef server| itself is highly scalable. A single virtual machine running the |chef server| can handle requests for many thousands of nodes. As the scale increases, it's a straightforward process to expand into a tiered front-end, back-end architecture with horizontally scaled front-ends to relieve pressure on system bottlenecks.

That said, it's best to isolate failure domains with their own |chef server|, rather than trying to run every node in an infrastructure from a single central, monolithic |chef server| instance/cluster.

For instance, if there are West coast and East coast data centers, it is best to have one |chef server| instance in each datacenter. Deploys to each |chef server| can be synchronized upstream by CI software. The primary limiting bottleneck for |chef server| installations is almost always input/output operations per second (IOPS) performance for the database filesystem.

CCRs/min
-----------------------------------------------------
The key unit of measure for scaling the |chef server| is the number of |chef client| runs per minute: CCRs/min. For example, 500 nodes set to check in every 30 minutes is equivalent to 16.66 CCRs/min.

Typically, the |chef server| does not require a high availability or tiered topology until the 
number of CCRs/min is higher than 333/min (approximately 10k nodes).

While synthetic benchmarks should be taken with a grain of salt, as they don't typically represent real-world performance, internal synthetic benchmarks at |company_name| have seen a standalone |chef server| installed on a ``c3.2xlarge`` |amazon aws| instance handle more than 1,000 CCRs/min (30k nodes).

Assumptions
-----------------------------------------------------
Several factors may influence server scalability. All server sizing recommendations are based on these assumptions:

* |chef client| runs are daemonized, and are not initiated by a |cron| job. Using |cron| to schedule runs can create "thundering herd" problems
* |chef client| runs are set to a default 30-minute interval with a 5-minute splay
* Search and ``partial_search`` are utilized, but not heavily
* The number of cookbooks per organization, across all versions, on the |chef server| is under 500. (Multiple organizations with fewer than 500 cookbooks each, that still add up to a total of more than 500 cookbooks server-wide, is fine.)
* The default maximum allowable size for a node object is 1MB, although it is rare for nodes to exceed 150KB. Though compressed, this data is replicated twice, once in |apache solr|, and once in |postgresql|. In practice, allowing a conservative 2MB of storage on the disk partition per node should be sufficient
* Disk space estimates assume that the |reporting| add-on is not installed

Host Specifications
-----------------------------------------------------
The following sections describe the host specifications for various sizes of CCRs/min and help show when to consider moving from a standalone topology to a high availability or tiered topology.

**UP TO 33 CCRs/Min (approx. 1,000 nodes):**

* |company_name| recommends a single virtual machine instance
* Start with 2 CPU cores and 8GB of RAM, which is equivalent to an |amazon ec2| ``m3.large`` instance
* Allocate 2MB of disk space on the data partition per managed node

**UP TO 167 CCRs/Min (approx. 5,000 nodes):**

* |company_name| recommends a single virtual machine instance
* Start with 4 CPU cores and 16GB of RAM, which is equivalent to an |amazon ec2| ``m3.xlarge`` instance

**UP TO 333 CCRs/Min (Approx. 10,000 nodes):**

* |company_name| recommends a single virtual machine instance
* Start with 8 CPU cores and 32GB of RAM, which is equivalent to an |amazon ec2| ``m3.2xlarge`` instance

**UP TO 667 CCRs/Min (Approx. 20,000 nodes):**

* |company_name| recommends two hosts, one front-end and one back-end
* The disk requirement for the front-end server is negligible
* Start with 8 CPU cores and 32GB of RAM for each host, which is equivalent to an |amazon ec2| ``m3.2xlarge`` instance

**Scaling beyond 20,000 nodes on a single cluster:**

* Additional capacity can be gained by placing the front-end node behind an HTTP load balancer, and then scaling front-end nodes horizontally
* |company_name| recommends that |company_name| professional services be engaged to help with capacity and architectural planning at this size




External Cookbooks
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_external_cookbooks_aws.rst

AWS Settings
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_external_cookbooks_aws_settings.rst


.. DO NOT CHANGE THE FOLLOWING TITLE BECAUSE IT IS LINKED FROM THE ERROR MESSAGES IN THE CODE FOR THESE SETTINGS.

External |postgresql|
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql.rst

.. DO NOT CHANGE THE FOLLOWING TITLE BECAUSE IT IS LINKED FROM THE ERROR MESSAGES IN THE CODE FOR THESE SETTINGS.

|postgresql| Settings
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql_settings.rst

.. note:: See https://docs.chef.io/error_messages#external-postgresql for information about error messages may be present when configuring the |chef server| to use a remote |postgresql| server.