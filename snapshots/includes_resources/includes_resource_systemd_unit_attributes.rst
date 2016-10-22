.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``enabled``
   **Ruby Types:** TrueClass, FalseClass

   Specifies whether the unit is enabled or disabled.
   
``active``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether the unit is started or stopped.
   
``masked``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether the unit is masked or not.

``static``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether the unit is static or not. Static units cannot be enabled or disabled.
   
``user``
   **Ruby Type:** String

   The user account that the systemd unit process is run under. The path to the unit for that user would be something like 
   ``/etc/systemd/user/sshd.service``. If no user account is specified, the systemd unit will run under a ``system`` account, with the path to the unit being something like ``/etc/systemd/system/sshd.service``.
   
``content``
   **Ruby Type:** String, Hash

   A string or hash that contains a systemd `unit file <https://www.freedesktop.org/software/systemd/man/systemd.unit.html>`_ definition that describes the properties of systemd-managed entities, such as services, sockets, devices, and so on.
   
``triggers_reload``
   **Ruby Type:** TrueClass, FalseClass

   Specifies whether to trigger a daemon reload when creating or deleting a unit. Default is true.
   