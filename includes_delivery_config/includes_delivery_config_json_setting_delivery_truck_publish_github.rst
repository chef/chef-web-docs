.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To publish cookbooks to a |github| repository:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "github": "chef/chef-web-docs"
     }
   }

where ``"chef/chef-web-docs"`` represents the organization/repository to which the ``build-cookbook`` belongs.

This publishing option requires the ``github`` deploy key for that repository to be available from a data bag on the |chef server| that is part of this |delivery| configuration.
