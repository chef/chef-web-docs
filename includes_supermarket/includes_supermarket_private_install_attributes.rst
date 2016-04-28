.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Define the attributes for the |supermarket| installation and how it connects to the |chef server|. One approach would be to hard-code attributes in the wrapper cookbook's ``default.rb`` recipe. A better approach is to place these attributes in a data bag, and then reference them from the recipe. For example, the data bag could be named ``apps`` and then a data bag item within the data bag could be named ``supermarket``.

The following attribute values must be defined:

* ``chef_server_url``
* ``chef_oauth2_app``
* ``chef_oauth2_secret``

To define these attributes, do the following:

#. Open the ``/recipes/default.rb`` file and add the following (assuming a data bag named ``apps`` and a data bag item named ``supermarket``):

   .. code-block:: ruby

      app = data_bag_item('apps', 'supermarket')

#. Set the attributes from the data bag:

   .. code-block:: ruby

      node.set['supermarket_omnibus']['chef_server_url'] = app['chefserverurl']
      node.set['supermarket_omnibus']['chef_oauth2_app_id'] = app['app_id']
      node.set['supermarket_omnibus']['chef_oauth2_secret'] = app['secret']

   When finished, the ``/recipes/default.rb`` file should have code similar to:

   .. code-block:: ruby

      app = data_bag_item('apps', 'supermarket')
      node.set['supermarket_omnibus']['chef_server_url'] = app['chefserverurl']
      node.set['supermarket_omnibus']['chef_oauth2_app_id'] = app['app_id']
      node.set['supermarket_omnibus']['chef_oauth2_secret'] = app['secret']

#. Save and close the ``/recipes/default.rb`` file.


