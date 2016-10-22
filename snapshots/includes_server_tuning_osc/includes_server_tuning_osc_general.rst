.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following settings are typically added to the chef-server.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``api_fqdn``
     - The FQDN for the Chef server. This setting is not in the chef-server.rb file by default. When added, its value should be equal to the FQDN for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing Open Source Chef. For example: ``api_fqdn "chef.example.com"``.
   * - ``bookshelf['vip']``
     - The virtual IP address. Default value: ``node['fqdn']``. (This setting is related to the **bookshelf** service.)
   * - ``bootstrap``
     - Default value: ``true``.
   * - ``notification_email``
     - Default value: ``info@example.com``.
   * - ``topology``
     - Default value: ``standalone``.

 
