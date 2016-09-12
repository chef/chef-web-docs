.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


The following options may be used with any of the |inspec cli| subcommands:

``-b BACKEND``, ``--backend BACKEND``
   Specify the backend. Possible values: ``docker``, ``local``, ``ssh``, or ``winrm``.

``--diagnose``
   Use to show diagnostics information.

``--disable_sudo``
   Use to prevent remote scanning via sudo. Default value: ``false``.

``--format FORMAT``
   The format for log output.

``--host``
   The remote host to be tested.

``--json-config PATH``
   Use to read all tests specified by ``PATH``, and then generate a summary in |json| format.

``--key-files``
   The login key or certificate file required for remote scanning.

``-l LEVEL``, ``--log-level LEVEL``
   Use to specify the log level. Possible values: ``debug``, ``error``, ``info`` (default), or ``warn``.

``--log-location``
   Use to specify the location to which log messages are sent. Possible values: ``STDOUT`` (default) and ``STDERR``.

``--password PASSWORD``
   The login password for remote scanning.

``--path PATH``
   The login path used to connect to |windows remote management| targets.

``-p PORT``, ``--port PORT``
   The port over which remote scanning will occur.

``--self_signed``
   Use to allow remote scanning with self-signed certificates for |windows remote management| targets.  Default value: ``false``.

``--ssl``
   Use to require transport-layer encryption via SSL for |windows remote management| targets. Default value: ``false``.

``--sudo-command COMMAND``
   Alternate command for sudo.

``--sudo-options OPTIONS``
   Additional options that may be required by the sudo password for remote scanning. Default value: ``''``.

``--sudo-password SUDO_PASSWORD``
   The sudo password, if required.

``-t TARGET``, ``--target TARGET``
   The URI for the target of a remote scan, preceded by the target's backend: ``backend://user:pass@host:port``, where ``backend`` is one of ``docker``, ``local``, ``ssh``, or ``winrm``. For example:

   .. code-block:: bash

      $ inspec shell -t ssh://root@192.168.64.2:11022

   .. code-block:: bash

      $ inspec shell -t ssh://user@hostname:1234 -i /path/to/user_key

   .. code-block:: bash

      $ inspec shell -t winrm://UserName:Password@windowsmachine:1234

   .. code-block:: bash

      $ inspec shell -t docker://container_id

``--user``
   The login user for remote scanning.
