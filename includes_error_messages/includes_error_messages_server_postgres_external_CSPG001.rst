.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Reason**

The value of ``postgresql['external']`` has been changed. 

**Possible Causes**

* This setting must be set before running ``chef-server-ctl reconfigure``, and may not be changed after

.. warning:: Upgrading is not supported at this time.

**Resolution**

* Back up the data using ``knife ec backup``, create a new backend instance, and then restore the data
* Re-point front end machines at the new backend instance **or** assign the new backend instance the name/VIP of the old backend instance (including certificates, keys, and so on)
