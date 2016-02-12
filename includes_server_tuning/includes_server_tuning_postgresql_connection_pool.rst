.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If there are more than two front end machines in a cluster, the ``postgresql['max_connections']`` setting should be increased. The increased value depends on the number of machines in the front end, but also the number of services that are running on each of these machines.

* Each front end machine always runs the |service bifrost| and |service erchef| services.
* The |reporting| add-on adds the |service reporting| service.
* The |push jobs| service adds the |service push_jobs| service.

Each of these services requires 25 connections, above the default value.

Use the following formula to help determine what the increased value should be:

.. code-block:: ruby

   new_value = current_value + [
               (# of front end machines - 2) * (25 * # of services)
			   ]

For example, if the current value is 350, there are four front end machines, and all add-ons are installed, then the formula looks like:

.. code-block:: ruby

   550 = 350 + [(4 - 2) * (25 * 4)]
