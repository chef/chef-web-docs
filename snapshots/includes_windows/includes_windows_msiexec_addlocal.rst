.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``ADDLOCAL`` parameter adds two setup options that are specific to the chef-client. These options can be passed along with an Msiexec.exe command:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Option
     - Description
   * - ``ChefClientFeature``
     - Use to install the chef-client.
   * - ``ChefServiceFeature``
     - Use to configure the chef-client as a service in Microsoft Windows.
   * - ``ChefPSModuleFeature``
     - Used to install the chef PowerShell module. This will enable chef command line utilities within PowerShell.

First install the chef-client, and then enable it to run as a service. For example:

.. code-block:: bash

   $ msiexec /qn /i C:\inst\chef-client-12.4.3-1.windows.msi ADDLOCAL="ChefClientFeature,ChefServiceFeature,ChefPSModuleFeature"
