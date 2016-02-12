.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef server| |amazon ami| can perform in-place upgrades of all of the pre-bundled software. This makes it easy to stay up-to-date with the latest version of the |chef server|, the |chef manage|, |reporting| and other |amazon aws marketplace| add-ons, while not requiring data to be migrated to the latest published |amazon ami|.

There are four options: upgrade the |chef server|, the |chef manage|, and |reporting|; upgrade |chef analytics|; upgrade the |chef server| (only, without add-ons); upgrade everything.

To upgrade, do one of the following:

* Upgrade the |chef server|, the |chef manage| and |reporting| marketplace instances by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -s

  .. note:: The |chef server| will be unavailable while the software is updated.

* Upgrade |chef analytics| marketplace instance by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -a

  .. note:: |chef analytics| will be unavailable while the software is updated.

* Upgrade the |chef server| marketplace instance by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -m

* Upgrade all the installed packages by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -y
