.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following diagram highlights the specific changes that occur when cookbooks are stored at an external location, such as |amazon s3|.

.. image:: ../../images/server_components_s3.svg
   :width: 500px

The following table describes the components that are different from the default configuration of the |chef server| when cookbooks are stored at an external location:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Clients
     - The |chef server| will provide signed URLs for cookbook requests made by the various clients (individual users, |knife| requests, and from the |chef client| that is installed on nodes under management by |chef|).
   * - Load Balancer
     - The signed URLs for cookbooks are pointed here, and then routed to cookbook storage, as required.
   * - |chef server_title|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_erchef.rst
   * - |amazon s3|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_bookshelf.rst

       This represents external cookbooks storage at |amazon s3|.
