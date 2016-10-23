.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following actions:

``:disable``
   Disable a service. This action is equivalent to a ``Disabled`` startup type on the Microsoft Windows platform. This action is not supported when using System Resource Controller (SRC) on the AIX platform because System Resource Controller (SRC) does not have a standard mechanism for enabling and disabling services on system boot.

``:enable``
   Enable a service at boot. This action is equivalent to an ``Automatic`` startup type on the Microsoft Windows platform. This action is not supported when using System Resource Controller (SRC) on the AIX platform because System Resource Controller (SRC) does not have a standard mechanism for enabling and disabling services on system boot.

``:nothing``
   Default. Do nothing with a service.

``:reload``
   Reload the configuration for this service.

``:restart``
   Restart a service.

``:start``
   Start a service, and keep it running until stopped or disabled.

``:stop``
   Stop a service.

.. note:: To mange a Microsoft Windows service with a ``Manual`` startup type, the **windows_service** resource must be used.

