.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The chef-validator is allowed to do the following at the start of a chef-client run. After the chef-client is registered with Chef server, that chef-client is added to the ``clients`` group:

.. list-table::
   :widths: 160 100 100 100 100
   :header-rows: 1

   * - Object
     - Create
     - Delete
     - Read
     - Update
   * - clients
     - yes
     - no
     - no
     - no
