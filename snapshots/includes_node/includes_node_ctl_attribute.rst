.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file documents specifc behavior related to the -j option in the chef-client, chef-solo, and chef-shell executables.

Any other attribute type that is contained in this JSON file will be treated as a ``normal`` attribute. For example, attempting to update ``override`` attributes using the ``-j`` option:

.. code-block:: javascript

   { 
     "name": "dev-99",
     "description": "Install some stuff",
     "override_attributes": {
       "apptastic": {
         "enable_apptastic": "false",
         "apptastic_tier_name": "dev-99.bomb.com"
       }  
     }  
   }

will result in a node object similar to:

.. code-block:: javascript

   { 
     "name": "maybe-dev-99",
     "normal": {
     "name": "dev-99",
       "description": "Install some stuff",
       "override_attributes": {
         "apptastic": {
           "enable_apptastic": "false",
           "apptastic_tier_name": "dev-99.bomb.com"
         }  
       }  
     }
   }
