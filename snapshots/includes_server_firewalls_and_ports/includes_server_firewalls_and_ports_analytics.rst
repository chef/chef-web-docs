.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For communication between Chef Analytics and the Chef server, ensure that ports marked as external (``yes``) are open and accessible via any firewalls that are in use:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service
     - External
   * - 80
     - **nginx**
     - yes
   * - 443
     - **nginx**
     - yes
   * - 5672
     - **rabbitmq**

       .. note:: The RabbitMQ port on the Chef server must alow inbound traffic from Chef Analytics.
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

