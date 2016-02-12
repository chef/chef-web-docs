.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Once this information has been identified, launch the |azure portal|, start the virtual machine creation workflow, and then bootstrap virtual machines with |chef|:

#. Sign in to the |azure portal_production| (|url azure_production|). Authenticate using your |azure| account credentials.

#. Choose **Virtual Machines** in the left pane of the portal.

#. Click the **New** option at the bottom of the portal.

#. Choose **Virtual Machine**, and then **From Gallery**.

#. Choose one of the following **Featured Images** (currently only |windows| images are supported): ``Windows Server 2012 R2 Datacenter`` or ``Windows Server 2012 Datacenter``.

#. Fill in the virtual machine configuration information, such as machine name, user name, and so on. When finished, click to the next page.

   .. note:: It's best to use a new computer name each time through this workflow. This will help to avoid conflicts with virtual machine names that may have been previously registered on the |chef server|.

#. Make the desired changes, if any, to the cloud service name, storage account, endpoints, etc., and then click to the next page.

#. Install |chef|. Click the checkbox next to **Chef** to configure virtual machines using with |chef|: 

   .. image:: ../../images/azure_portal.png
 
#. Click the **From Local** button next to the |client rb| text box, and then browse to upload the |client rb| file.

   .. note:: The |client rb| must be correctly configured to communicate to the |chef server|. Specifically, it must have valid values for the following two settings: ``chef_server_url`` and ``validaton_client_name``.

#. Use the **From Local** button next to the validation key text box to locate a local copy of the validation key. 

#. Optional. `Use a run-list <https://docs.chef.io/run_lists.html>`_ to specify what should be run when the virtual machine is provisioned, such as using the run-list to provision a virtual machine with |microsoft iis|. Use the ``iis`` cookbook and the default recipe to build a run-list. For example:
   
   .. code-block:: ruby
   
      iis
   
   or:
   
   .. code-block:: ruby
   
      iis::default
   
   or:
   
   .. code-block:: ruby
   
      recipe['iis']

   A run-list can also be built using a role. For example, if a role named ``backend_server`` is defined on the |chef server|, the run-list would look like:
   
   .. code-block:: ruby
   
      role['backend_server']

   Even without a run-list, the virtual machine will periodically check with the |chef server| to see if the configuration requirements change. This means that the run-list can be updated later, by editing the run-list to add the desired run-list items by using the |chef server| web user interface or by using the |knife| command line tool. 

   .. note:: A run-list may only refer to roles and/or recipes that have already been uploaded to the |chef server|.

#. Click the checkmark button to complete the page. Provisioning will begin and the application will return to the **Virtual Machines** page showing the list of available virtual machines.

   When the virtual machine has reached the status **starting**, click the virtual machine name to go to a page that contains more detail. Click **dashboard** to see more detailed status, and scroll down to the area that says **extensions**.

   Once the virtual machine has gone far enough in the ``running(provisioning)`` state, some entries should appear under status, like this:

   .. image:: ../../images/azure_portal_1.png

#. Once finished, something like the following will be shown:

   .. image:: ../../images/azure_portal_2.png

After the process is complete, the virtual machine will be registered with the |chef server| and it will have been provisioned with the configuration (applications, services, etc.) from the specified run-list. The |chef server| can now be used to perform all ongoing management of the virtual machine node.
