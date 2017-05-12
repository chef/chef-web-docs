=====================================================
ohai (executable)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_ohai.rst>`__

.. tag ctl_ohai_summary

ohai is the command-line interface for Ohai, a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run.

.. end_tag

Options
=====================================================
.. tag ctl_ohai_options

This command has the following syntax:

.. code-block:: bash

   $ ohai OPTION

This tool has the following options:

``ATTRIBUTE_NAME ATTRIBUTE NAME ...``
   Use to have Ohai show only output for named attributes.

``-d PATH``, ``--directory PATH``
   The directory in which Ohai plugins are located. For example: ``/etc/ohai/plugins``.

``-h``, ``--help``
   Show help for the command.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-L LOGLOCATION``, ``--logfile c``
   The location of the log file.

``-v``, ``--version``
   The version of Ohai.

.. end_tag

Examples
=====================================================
The following examples show how to use the Ohai command-line tool:

**Run a plugin independently of a chef-client run**

An Ohai plugin can be run independently of a chef-client run. First, ensure that the plugin is located in the ``/plugins`` directory and then use the ``-f`` option when running Ohai from the command line. For example, a plugin named ``sl_installed`` may look like the following:

.. code-block:: ruby

   Ohai.plugin(:Sl) do
     provides "sl"

     collect_data(:default) do
       sl Mash.new

       if ::File.exist?("/usr/games/sl")
         sl[:installed] = true
       else
         sl[:installed] = false
       end

       # sl[:installed] = ::File.exist?("/usr/games/sl")

     end
   end

To run that plugin from the command line, use the following command:

.. code-block:: bash

   $ ohai --directory /path/to/directory sl

The command will return something similar to:

.. code-block:: javascript

   {
     "sl": {
       "installed": true
     }
   }
