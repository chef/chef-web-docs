.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **systemd_unit** resource describes the configuration behavior for systemd units. For example:

.. code-block:: ruby

   systemd_unit 'sysstat-collect.timer' do
     enabled true
     content '[Unit]\nDescription=Run system activity accounting tool every 10 minutes\n\n[Timer]\nOnCalendar=*:00/10\n\n[Install]\nWantedBy=sysstat.service'
   end

The full syntax for all of the properties that are available to the **systemd_unit** resource is:

.. code-block:: ruby

   systemd_unit 'name' do
     enabled                Boolean
     active                 Boolean
     masked                 Boolean
     static                 Boolean
     user                   String
     content                String or Hash
     triggers_reload        Boolean
   end

where 

* ``name`` is the name of the unit 
* ``active`` specifies if the service unit type should be started
* ``user`` is the user account that systemd units run under. If not specified, systemd units will run under the system account.
* ``content`` describes the behavior of the unit
