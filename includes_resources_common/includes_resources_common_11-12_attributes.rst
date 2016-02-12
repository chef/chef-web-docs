.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following properties are common to every resource:

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``provider``
   **Ruby Type:** Chef Class

   Optional.. |provider resource_parameter|

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``sensitive``
   **Ruby Types:** TrueClass, FalseClass

   |sensitive| Default value: ``false``. This property only applies to the |resource file| and |resource template| resources.

``supports``
   **Ruby Type:** Hash

   |supports resources| This property is only used by a small number of providers, including |resource user| and |resource service|.
