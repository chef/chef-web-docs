.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

Periodic maintenance tasks are performed on the |chef server| servers via |cron| and the ``/etc/cron.d`` directory. With certain |centos| 6 configurations, an additional step is required to install |crontab|:

.. code-block:: bash

   $ yum install crontabs
