.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To uninstall the |chef manage|, do the following:

#. Run the following command:

   .. code-block:: bash
      
      $ chef-manage-ctl cleanse

#. Use the package manager for the platform on which the |chef manage| is installed, and then uninstall the package named ``chef-manage``.

.. note:: This package used to be named ``opscode-manage`` and the command line tool used to be named ``opscode-manage-ctl``.
