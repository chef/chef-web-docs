.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


There are three ways to accept the master license:

#. When running ``chef-<PRODUCT-NAME>-ctl reconfigure`` the master license is printed. Type ``yes`` to accept it. Anything other than typing ``yes`` rejects the license and the upgrade process will exit.

#. Run the ``chef-<PRODUCT-NAME>-ctl reconfigure`` command using the ``--accept-license`` option. This automatically types ``yes`` and skips printing the master license.

#. Add a ``.license.accepted`` file to the ``/var/opt/<PRODUCT-NAME>/`` directory. The contents of this file do not matter. The presense of this file in the correct directory means the master license is accepted.
