.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax:

.. code-block:: bash

   $ chef-client OPTION VALUE OPTION VALUE ...

This command has the following options specific to |windows|:

``-A``, ``--fatal-windows-admin-check``
   |fatal_windows_admin_check|

``-d``, ``--daemonize``
   |daemonize| This option is only available on machines that run in |unix| or |linux| environments. For machines that are running |windows| that require similar functionality, use the ``chef-client::service`` recipe in the |cookbook chef_client| cookbook: http://community.opscode.com/cookbooks/chef-client. This will install a |chef client| service under |windows| using the |windows service wrapper|.
