.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Reason**

One (or more) of the |postgresql| databases already exists.

**Possible Causes**

* The ``opscode_chef``, ``oc_id``, and/or ``bifrost`` databases already exist on the remote machine
* The |postgresql| database exists for another application

**Resolution**

* Verify that the ``opscode_chef``, ``oc_id``, and/or ``bifrost`` databases exist, and then verify that they are not being used by another internal application
* Back up the |postgresql| data, remove the existing databases, and reconfigure the |chef server|
