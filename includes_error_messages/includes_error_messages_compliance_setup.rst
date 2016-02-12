.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Reason**

For security purposes the |chef compliance| setup wizard has a one hour timeout.

**Resolution**

#. Login using |ssh| to access the |chef compliance| instance.

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem <user>@<instance IP address>

#. Reconfigure |chef compliance| to restart the 60 minute setup timer.

   .. code-block:: bash

      $ chef-compliance-ctl reconfigure
