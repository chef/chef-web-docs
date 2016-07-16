.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|kitchen| can configure a transport with the following settings for either ``ssh`` or ``winrm`` transports:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``connection_retries``
     - Maximum number of times to retry after a failed attempt to open a connection. The default is 5.
   * - ``connection_retry_sleep``
     - Number of seconds to wait until attempting to make another connection after a failure.
   * - ``max_wait_until_ready``
     - Maximum number of attempts to determine if the test instance is ready to accept commands. This defaults to 600.
   * - ``password``
     - The password used for authenticating to the test instance.
   * - ``port``
     - The port used to connect to the test instance. This defaults to ``22`` for the ``ssh`` transport and ``5985`` or ``5986`` for ``winrm`` using ``http`` or ``https`` respectively.
   * - ``username``
     - The username used for authenticating to the test instance. This defaults to ``administrator`` for the ``winrm`` transport and ``root`` for the ``ssh`` transport. Some drivers may change this default.

These settings may be added to the ``transport`` section of the |kitchen yml| file when the transport is |ssh|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``compression``
     - Wether or not to use compression. The default is ``false``.
   * - ``compression_level``
     - The default is 6 if ``compression`` is ``true``.
   * - ``connection_timeout``
     - Defaults to 15.
   * - ``keepalive``
     - Defaults to ``true``.
   * - ``keepalive_interval``
     - Defaults to 60.
   * - ``max_ssh_sessions``
     - Maximum number of parallel ssh sessions.
   * - ``ssh_key``
     - Path to an ssh key identity file.

These settings may be added to the ``transport`` section of the |kitchen yml| file when the transport is |winrm|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``elevated``
     - When ``true``, all commands are executed via a scheduled task. This may eliminate access denied errors related to double hop authentication, interacting with windows updates and installing some MSIs such as sql server and .net runtimes. Defaults to ``false``.
   * - ``elevated_password``
     - The password used by the identity running the scheduled task. This may be ``null`` in the case of service accounts. Defaults to ``password``.
   * - ``elevated_username``
     - The identity that the task runs under. This may also be set to service accounts such as ``System``. This defaults to ``username``.
   * - ``rdp_port``
     - Port used making ``rdp`` connections for ``kitchen login`` commands. Defaults to 3389.
   * - ``winrm_transport``
     - The transport type used by winrm as explained `here <https://github.com/WinRb/WinRM>`__. The default is ``negotiate``. ``ssl`` and ``plaintext`` are also acceptable values.
