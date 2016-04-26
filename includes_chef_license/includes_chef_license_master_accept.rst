.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


There are three ways to accept the |chef license|:

#. When running ``chef-<PRODUCT-NAME>-ctl reconfigure`` the |chef license| is printed. Type ``yes`` to accept it. Anything other than typing ``yes`` rejects the |chef license| and the upgrade process will exit. Typing ``yes`` adds a ``.license.accepted`` file to the ``/var/opt/<PRODUCT-NAME>/`` directory. As long as this file exists in this directory, the |chef license| is accepted and the reconfigure process will not prompt for ``yes``.

#. Run the ``chef-<PRODUCT-NAME>-ctl reconfigure`` command using the ``--accept-license`` option. This automatically types ``yes`` and skips printing the |chef license|.

#. Add a ``.license.accepted`` file to the ``/var/opt/<PRODUCT-NAME>/`` directory. The contents of this file do not matter. As long as this file exists in this directory, the |chef license| is accepted and the reconfigure process will not prompt for ``yes``.
