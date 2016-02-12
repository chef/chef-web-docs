.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Log files are available from within the |azure portal|:

#. Select **Virtual Machines** in the left pane of the |azure portal|.

#. Select the virtual machine that has the error status.

#. Click the **Connect** button at the bottom of the portal to launch a |windows remote desktop| session, and then log in to the virtual machine.

#. Start up a |windows powershell| command shell.

   .. code-block:: bash

      $ cd c:\windowsazure\logs
        ls –r chef*.log

#. This should display the log files, including the |chef client| log file.
