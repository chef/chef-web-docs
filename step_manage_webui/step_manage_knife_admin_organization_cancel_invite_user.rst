.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Canceling a pending invite for a user can currently be completed using knife:

#. As a user that is a member of the Admins group, replace ORGNAME with your own ORGNAME and run

   .. code-block:: bash

       knife raw 'association_requests' -s https://api.opscode.com/organizations/ORGNAME
   
   You may see an empty list or you may see a populated list of invites. No invites looks like this
  
   .. code-block:: bash

       [

       ]

   A single invite looks like this
   
   .. code-block:: bash

       [
         {
            "id": "f6240e73d35b1e3ce3238ab8a5131ccb",
            "username": "testuser"
         }
       ]

#. To cancel the above pending invite you would run

   .. code-block:: bash
 
       knife raw -m DELETE 'association_requests/f6240e73d35b1e3ce3238ab8a5131ccb' -s https://api.opscode.com/organizations/ORGNAME
