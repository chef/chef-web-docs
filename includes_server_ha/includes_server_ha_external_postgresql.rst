.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.



The following diagram highlights the specific changes that occur when |postgresql| is configured and managed independently of the |chef server| configuration.

.. image:: ../../images/server_components_postgresql.svg
   :width: 500px

The following table describes the components in an external |postgresql| configuration that are different from the default configuration of the |chef server|:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - |chef server_title|
     - The |chef server| configuration file is updated to point to an independently configured set of servers for |postgresql|.
   * - |postgresql|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_postgresql.rst

       This represents the independently configured set of servers that are running |postgresql| and are configured to act as the data store for the |chef server|.
