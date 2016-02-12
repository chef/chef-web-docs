.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following ``knife bootstrap`` settings can be added to the |knife rb| file:

``knife[:bootstrap_proxy]``
   Use to add the ``--bootstrap-proxy`` option.

``knife[:bootstrap_version]``
   Use to add the ``--bootstrap-version`` option.

``knife[:distro]``
   Use to add the ``--distro`` option.

``knife[:run_list]``
   Use to add the ``--run-list`` option.

``knife[:template_file]``
   Use to add the ``--template-file`` option.

``knife[:use_sudo]``
   Use to add the ``--sudo`` option.

.. note:: The ``knife bootstrap`` subcommand relies on a number of |ssh|-related settings that are handled by the ``knife ssh`` subcommand.
