.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``extra_chef_config`` property in a recipe in the ``provision`` cookbook to set arbitrary configuration settings. Define the ``extra_chef_config`` values in the ``provision`` cookbook using the following syntax:

.. code-block:: ruby

   ChefDK::ProvisioningData.context.extra_chef_config = 'setting :value'

For example:

.. code-block:: ruby

   ChefDK::ProvisioningData.context.extra_chef_config = 'log_level :debug'
