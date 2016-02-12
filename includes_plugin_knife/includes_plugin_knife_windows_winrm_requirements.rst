.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This subcommand requires |windows remote management| to be installed, and then configured correctly, including ensuring the correct ports are open. For more information, see: http://msdn.microsoft.com/en-us/library/aa384372(v=vs.85).aspx and/or http://support.microsoft.com/kb/968930. Use the quick configuration option in |windows remote management| to allow outside connections and the entire network path from |knife| (and the workstation):

.. code-block:: bash

   $ winrm quickconfig -q

The following |windows remote management| configuration settings should be updated:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``MaxMemoryPerShellMB``
     - |winrm_max_memory_per_shell_mb|
   * - ``MaxTimeoutms``
     - |winrm_max_timeouts|
   * - ``AllowUnencrypted``
     - |winrm_allow_unencrypted|
   * - ``Basic``
     - |winrm_basic|

To update these settings, run the following commands:

.. code-block:: bash

   $ winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'

and:

.. code-block:: bash

   $ winrm set winrm/config '@{MaxTimeoutms="1800000"}'

and:

.. code-block:: bash

   $ winrm set winrm/config/service '@{AllowUnencrypted="true"}'

and then:

.. code-block:: bash

   $ winrm set winrm/config/service/auth '@{Basic="true"}'

Ensure that the |windows firewall| is configured to allow |windows remote management| connections between the workstation and the |chef server|. For example:

.. code-block:: bash

   $ netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" profile=public protocol=tcp localport=5985 remoteip=localsubnet new remoteip=any
