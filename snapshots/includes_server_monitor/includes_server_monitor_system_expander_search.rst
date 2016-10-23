.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the search indexes are not being updated properly, first ensure that the **opscode-expander** service is running on the backend machine:

.. code-block:: bash

   $ chef-server-ctl status opscode-expander

and then (if it is not running), start the service:

.. code-block:: bash

   $ chef-server-ctl start opscode-expander

If the **opscode-expander** does not start correctly, then take a look at the ``/var/log/opscode/opscode-expander/current`` log file for error messages. 

If the **opscode-expander** is running, check the queue length:

.. code-block:: bash

   $ watch -n1 sudo -E bin/opscode-expanderctl queue-depth

If the number of total messages continues to increase, increase the number of workers available to the **opscode-expander** service.

