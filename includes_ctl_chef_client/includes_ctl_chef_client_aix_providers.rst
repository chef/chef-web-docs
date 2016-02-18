.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |resource service| resource has the following providers to support the |ibm aix| platform:

.. list-table::
   :widths: 150 80 320
   :header-rows: 1

   * - Long name
     - Short name
     - Notes
   * - ``Chef::Provider::Service::Aix``
     - ``service``
     - The provider that is used with the |ibm aix| platforms. Use the ``service`` short name to start, stop, and restart services with |ibm aix_src|.
   * - ``Chef::Provider::Service::AixInit``
     - ``service``
     -  The provider that is used to manage |berkeley os|-based init services on |ibm aix|.
