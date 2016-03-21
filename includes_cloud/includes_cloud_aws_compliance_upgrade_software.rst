.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef compliance| |amazon ami| can perform in-place upgrades of all of the pre-bundled software. This makes it easy to stay up-to-date with the latest versions of |chef compliance| and |chef marketplace| while not requiring data to be migrated to the latest published |amazon ami|.
There are 3 options: upgrade |chef compliance|; upgrade |chef marketplace|; upgrade everything.

To upgrade, do one of the following:

* Upgrade the |chef compliance| package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -c

  .. note:: |chef compliance| will be unavailable while the software is updated.

* Upgrade the |chef marketplace| package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -m

* Upgrade all the installed packages by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -y
