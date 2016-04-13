=====================================================
About the |dsl delivery|
=====================================================

.. include:: ../../includes_dsl_delivery/includes_dsl_delivery.rst

.. warning:: These recipe helpers are available from the ``delivery-truck`` cookbook: https://github.com/opscode-cookbooks/delivery-truck. This cookbook is a recommended dependency for any ``build-cookbook`` for a project that publishes changes to a |delivery| pipeline.

Helpers
-----------------------------------------------------
.. include:: ../../includes_dsl_delivery/includes_dsl_delivery_helpers.rst

node['delivery'] Attributes
-----------------------------------------------------
Some useful information is stored in attributes. Use ``node.get`` and ``node.set`` to interact with these values in a recipe.

``change_id``
  Use ``node['delivery']['change']['change_id']`` for change identifier. For example:

  .. code-block:: ruby

     node['delivery']['change']['change_id'] = 'aaaa-bbbb-cccc'

``enterprise``
  Use ``node['delivery']['change']['enterprise']`` for the enterprise name. For example:

  .. code-block:: ruby

     node['delivery']['change']['enterprise'] = 'Chef'

``git_url``
  Use ``node['delivery']['change']['git_url']`` for the URL for the |git| project. For example:

  .. code-block:: ruby

     node['delivery']['change']['git_url'] = 'https://git.co/my_project.git'

``organization``
  Use ``node['delivery']['change']['organization']`` for the organization name. For example:

  .. code-block:: ruby

     node['delivery']['change']['organization'] = 'Delivery'

``patchset_branch``
  Use ``node['delivery']['change']['patchset_branch']`` for the branch name. For example:

  .. code-block:: ruby

     node['delivery']['change']['patchset_branch'] = 'mypatchset/branch'

``patchset_number``
  Use ``node['delivery']['change']['patchset_number']`` for the patchset number. For example:

  .. code-block:: ruby

     node['delivery']['change']['patchset_number'] = '1'

``phase``
  Use ``node['delivery']['change']['phase']`` for the current phase name. For example:

  .. code-block:: ruby

     node['delivery']['change']['phase'] = 'provision'

``pipeline``
  Use ``node['delivery']['change']['pipeline']`` for the pipeline name. For example:

  .. code-block:: ruby

     node['delivery']['change']['pipeline'] = 'master'

``project``
  Use ``node['delivery']['change']['project']`` for the project name. For example:

  .. code-block:: ruby

     node['delivery']['change']['project'] = 'Secret'

``sha``
  Use ``node['delivery']['change']['sha']`` for the |sha1| hash. For example:

  .. code-block:: ruby

     node['delivery']['change']['sha'] = '0123456789abcdef'

``stage``
  Use ``node['delivery']['change']['stage']`` for the current stage name. For example:

  .. code-block:: ruby

     node['delivery']['change']['stage'] = 'union'


Examples
-----------------------------------------------------
The following examples show how to use the |dsl delivery| in a cookbook:

**changed_cookbooks**

.. include:: ../../includes_dsl_delivery/includes_dsl_delivery_example_changed_cookbooks.rst

**bumped_version?**

.. include:: ../../includes_dsl_delivery/includes_dsl_delivery_example_bumped_version.rst

**push_repo_to_github?**

.. include:: ../../includes_dsl_delivery/includes_dsl_delivery_example_push_repo_to_github.rst
