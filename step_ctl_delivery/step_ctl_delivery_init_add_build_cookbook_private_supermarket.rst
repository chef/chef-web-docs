.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to add a build cookbook after the initialization process

.. code-block:: bash

   $ delivery init —skip-build-cookbook

and then update the ``config.json`` file for the ``delivery-truck`` cookbook and the path to the cookbook in a private |supermarket|:

.. code-block:: json

   {
     "version": "2",
     "build_cookbook": {
       "name": "delivery-truck",
       "supermarket": "true",
       "site": "https://private-supermarket.example.com"
     },
     ...
   }

