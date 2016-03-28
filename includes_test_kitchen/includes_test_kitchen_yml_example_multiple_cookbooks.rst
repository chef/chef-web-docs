.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to use the ``chef_solo`` provisioner without |berkshelf| in a way that allows multiple cookbooks:

.. code-block:: yaml

   provisioner:
     name: chef_solo
     roles_path: '../../roles'
     data_bags_path: '../../data_bags'
     environments_path: '../../environments'
     cookbooks_path:
       - ../cookbooks
       - ../../site-cookbooks