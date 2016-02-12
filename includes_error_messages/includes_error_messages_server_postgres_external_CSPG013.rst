.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Reason**

The ``db_superuser`` account has incorrect permissions.

**Possible Causes**

* The ``db_superuser`` account has not been granted ``SUPERUSER`` access
* The ``db_superuser`` account has not been granted ``CREATE DATABASE`` and ``CREATE ROLE`` privileges

  .. code-block:: bash

     ALTER ROLE "$your_db_superuser_name" WITH SUPERUSER

  or:

  .. code-block:: bash

     ALTER ROLE "$your_db_superuser_name"  WITH CREATEDB CREATEROLE
