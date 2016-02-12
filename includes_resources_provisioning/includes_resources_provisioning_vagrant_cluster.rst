.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``vagrant_cluster`` resource is a driver-specific resource used by |chef provisioning|. Use the ``vagrant_cluster`` resource to build a group of boxes in |vagrant| using a single |vagrantfile| that defines each of the boxes in the group. The ``vagrant list`` command will show all of the boxes that are configured with the |vagrantfile|.
