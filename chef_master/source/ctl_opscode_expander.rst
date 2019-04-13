=====================================================
opscode-expander-ctl (executable)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_opscode_expander.rst>`__

.. tag ctl_opscode_expander_summary

The ``opscode-expander-ctl`` executable can be used to generate status information for the **opscode-expander** service. The ``opscode-expander-ctl`` executable is run as a command-line tool from the master backend machine.

.. end_tag

Options
=====================================================
.. tag ctl_opscode_expander_options

This tool has the following syntax::

   opscode-expander-ctl COMMAND

Where ``COMMAND`` can be any of the following:

``log-level``
   Use to show the log level for all nodes in the cluster.

``node-status``
   Use to show the status for all nodes in the cluster.

``queue-depth``
   Use to display the aggregate queue backlog.

``queue-status``
   Use to show the backlog and consumer counts for each vnode queue.

.. end_tag

Examples
=====================================================
.. tag ctl_opscode_expander_example

For example, to view the aggregate queue backlog, enter the following:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/opscode-expander/
   $ export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
   $ bin/opscode-expander-ctl queue-depth

to return something similar to:

.. code-block:: bash

       total messages:       0
       average queue depth:  0.0
       max queue depth:      0
       min queue depth:      0

.. end_tag

