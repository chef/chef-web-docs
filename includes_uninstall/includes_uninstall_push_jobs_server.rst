.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


To uninstall |push jobs|, do the following:

#. Shut down the |push jobs| service.
#. Uninstall the |push jobs| package.
#. Run the following command:

   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

.. note:: This will leave some data in |postgresql| that is not used by any other |chef| application or service.
