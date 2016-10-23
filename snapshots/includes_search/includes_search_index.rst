.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A search index is a full-text list of objects that are stored on the Chef server, against which search queries can be made. The following search indexes are built:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Search Index Name
     - Description
   * - ``client``
     - API client
   * - ``DATA_BAG_NAME``
     - A data bag is a global variable that is stored as JSON data and is accessible from a Chef server. The name of the search index is the name of the data bag. For example, if the name of the data bag was "admins" then a corresponding search query might look something like ``search(:admins, "*:*")``.
   * - ``environment``
     - An environment is a way to map an organization's real-life workflow to what can be configured and managed when using Chef server.
   * - ``node``
     - A node is any server or virtual server that is configured to be maintained by a chef-client.
   * - ``role``
     - A role is a way to define certain patterns and processes that exist across nodes in an organization as belonging to a single job function.
