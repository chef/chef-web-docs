.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following properties are common to every resource:

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``provider``
   **Ruby Type:** Chef Class

   Optional. The |chef client| will attempt to determine the correct provider during the |chef client| run, and then choose the best/correct provider based on configuration data collected at the start of the |chef client| run. In general, a provider does not need to be specified.

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``sensitive``
   **Ruby Types:** TrueClass, FalseClass

   |sensitive| Default value: ``false``. This property only applies to the |resource execute|, |resource file| and |resource template| resources.

``supports``
   **Ruby Type:** Hash

   |supports resources| This property is only used by a small number of providers, including |resource user| and |resource service|.
