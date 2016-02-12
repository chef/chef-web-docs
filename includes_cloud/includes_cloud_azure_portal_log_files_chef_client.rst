.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef client| can be run interactively by using |windows remote desktop| to connect to the virtual machine, and then running the |chef client|:

#. Log into the virtual machine.

#. Start up a |windows powershell| command shell.

#. Run the following command:
   
   .. code-block:: bash
   
      $ chef-client -l debug

#. View the logs.
