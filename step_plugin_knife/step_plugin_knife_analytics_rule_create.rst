.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To create a rule, run the following command:

.. code-block:: bash

   $ knife rule create FILE_NAME.json

where the ``FILE_NAME.json`` is similar to:

.. code-block:: javascript

   {
     "name": "Rule name.",
     "modified_by": "user_name",
     "with": {
       "priority": 0
     },
     "active":true,
     "rule":"rules 'Rule group 1'\n
       rule on action\n  
       when\n    
         true\n  
       then\n    
         noop()\n  
       end\n
     end"
   }
