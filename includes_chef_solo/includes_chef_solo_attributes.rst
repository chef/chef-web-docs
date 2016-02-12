.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef solo| does not interact with the |chef server|. Consequently, node-specific attributes must be located in a |json| file on the target system, a remote location (such as |amazon s3|), or a web server on the local network.

The |json| file must also specify the recipes that are part of the run-list. For example:

.. code-block:: javascript

   {
     "resolver": {
       "nameservers": [ "10.0.0.1" ],
       "search":"int.example.com"
     },
     "run_list": [ "recipe[resolver]" ]
   }


