.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

On the primary |chef server|, create the |chef_sync rb| file in the ``/etc/chef-sync/`` directory, and then add the following setting:

.. code-block:: ruby
      
   role :master