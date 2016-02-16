.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

By default, |chef shell| loads in standalone mode and does not connect to the |chef server|. The |chef shell| can be run as a |chef client| to verify functionality that is only available when the |chef client| connects to the |chef server|, such as search functionality or accessing data stored in data bags.

|chef shell| can use the same credentials as |knife| when connecting to a |chef server|. Make sure that the settings in |chef_shell rb| are the same as those in |knife rb|, and then use the ``-z`` option as part of the command. For example:

.. code-block:: bash

   $ chef-shell -z
