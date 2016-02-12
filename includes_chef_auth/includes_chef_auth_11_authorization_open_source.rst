.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The open source |chef server| has a single tenant access control model. All objects---roles, nodes, cookbooks, data bags, search indexes, and so on---are stored in the same virtual space and are accessible to any API request (as long as the request can be authorized). All users are granted ``admin``, ``normal``, or ``validator`` rights:

* ``admin`` rights allow tasks such as create, read, update, or delete for all nodes
* ``normal`` rights are only actionable only on per-node basis

The following tables list the various API requests that may be made to the open source |chef server|. Any requests that are not listed can be done as long the API requests is authenticated properly.

The following API requests require admin privileges:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Request
     - Equivalent Knife Command
   * - Client Index
     - ``knife client list``
   * - Client Update
     - ``knife client edit NAME``
   * - Client Destroy
     - ``knife client delete NAME``
   * - Cookbook Update
     - ``knife cookbook upload COOKBOOK``
   * - Cookbook Destroy
     - ``knife cookbook delete COOKBOOK``
   * - Data Bag Create
     - ``knife data bag create BAG_NAME``
   * - Data Bag Destroy
     - ``knife data bag delete BAG_NAME``
   * - Data Bag Item Create
     - ``knife data bag create BAG_NAME ITEM_NAME``
   * - Data Bag Item Update
     - ``knife data bag edit BAG_NAME ITEM_NAME``
   * - Data Bag Item Destroy
     - ``knife data bag delete BAG_NAME ITEM_NAME``
   * - Environment Create
     - ``knife environment create ENV_NAME``
   * - Environment Update
     - ``knife environment edit ENV_NAME``
   * - Environment Destroy
     - ``knife environment delete ENV_NAME``
   * - Role Create
     - ``knife role create ROLE_NAME``
   * - Role Update
     - ``knife role edit ROLE_NAME``
   * - Role Destroy
     - ``knife role delete ROLE_NAME``
   * - Search Reindex
     - None.
   * - User Create
     - None.
   * - User Update
     - None.
   * - User Destroy
     - None.

The following API requests require admin privileges or are done by the |chef validator| during the initial |chef client| run:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Request
     - Equivalent Knife Command
   * - Client Create
     - ``knife client create``

The following API requests require admin privileges or for the action to be taken against the location from which the request originated. For example, a node may request that it be deleted, even if the node does not have admin privileges.
	
.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Request
     - Equivalent Knife Command
   * - Client Show
     - ``knife client show NAME``
   * - Node Update
     - ``knife node edit NAME``
   * - Node Destroy
     - ``knife node delete NAME``
   * - Node Cookbooks
     - None.

