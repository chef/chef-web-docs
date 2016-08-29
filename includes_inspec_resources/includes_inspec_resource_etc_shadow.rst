.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``shadow`` |inspec resource| to test the contents of ``/etc/shadow``, which contains password details that are only readable by the ``root`` user. The format for ``/etc/shadow`` includes:

* A username
* The password for that user (on newer systems passwords should be stored in ``/etc/shadow`` )
* The last time a password was changed
* The minimum number of days a password must exist, before it may be changed
* The maximum number of days after which a password must be changed
* The number of days a user is warned about an expiring password
* The number of days a user must be inactive before the user account is disabled
* The number of days a user account has been disabled

defined as a colon-delimited row in the file, one row per user:

.. code-block:: bash

   dannos:Gb7crrO5CDF.:10063:0:99999:7:::
