.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the ``config.json`` file specifies the following cookbooks are published to a git repository located on an open source git server:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "git": "ssh://git@stash:2222/<project-name>/<repo-name>"
     }
   }

This publishing option requires the ``git`` deploy key for that repository to be available from a data bag on the Chef server that is part of this Chef Automate configuration.
