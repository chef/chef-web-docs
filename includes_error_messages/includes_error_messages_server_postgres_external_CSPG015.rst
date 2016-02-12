.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Reason**

The database template ``template1`` does not exist.

**Possible Causes**

* The ``template1`` database template has been removed from the remote server

**Resolution**

* Run the following command (as a superuser):

  .. code-block:: bash

     CREATE DATABASE template1 TEMPLATE template0

  or:

  .. code-block:: bash

     createdb -T template0 template1
