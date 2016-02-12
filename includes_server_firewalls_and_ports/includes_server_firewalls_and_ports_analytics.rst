.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For communication between |chef analytics| and the |chef server|, ensure that ports marked as external (``yes``) are open and accessible via any firewalls that are in use:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service
     - External
   * - 80
     - |service nginx|
     - yes
   * - 443
     - |service nginx|
     - yes
   * - 5672
     - |service rabbitmq|

       .. note:: The |rabbitmq| port on the |chef server| must alow inbound traffic from |chef analytics|.
     - no
   * - 10011
     - actions
     - no
   * - 10012
     - actions_messages
     - no
   * - 10013
     - notifier_config
     - no

