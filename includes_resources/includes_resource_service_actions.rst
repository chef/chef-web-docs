.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following actions:

``:disable``
   Disable a service. |windows service_type_disabled| |ibm_aix_src not_supported|

``:enable``
   Enable a service at boot. |windows service_type_automatic| |ibm_aix_src not_supported|

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

.. note:: To mange a |windows| service with a ``Manual`` startup type, the |resource service_windows| resource must be used.

