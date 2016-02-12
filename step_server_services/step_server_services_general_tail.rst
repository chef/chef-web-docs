.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Another common approach to tailing the log files for a service is to use the system utility ``tail``. For example:

.. code-block:: bash

   $ tail -50f /var/log/opscode/opscode-chef/current