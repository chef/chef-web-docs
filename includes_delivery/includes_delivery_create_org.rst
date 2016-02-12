.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|company_name| suggests creating a sandbox organization in which a test project can be run for verification and testing purposes. Additionally, it is recommended that each organization created corresponds to a working directory within which projects for that organization are managed. 

To create an organization, do the following:

#. Log into the |chef delivery| web UI as an **Admin**; use this command (run in your ``delivery-cluster`` directory) to find the credentials:

   .. code-block:: bash

      $ rake info:delivery_creds

#. Select **Organizations** from the drop-down menu on the upper right. The organizations list page opens.
#. Click the plus sign (**+**) next to **Add a New Organization**.
#. Enter an organization name in the text area, and then click **Save & Close**. 