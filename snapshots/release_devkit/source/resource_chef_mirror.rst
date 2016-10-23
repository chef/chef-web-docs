.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_mirror.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_mirror
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_chef_client/includes_chef_client.rst

Use the **chef_mirror** resource to mirror objects in the chef-repo to a specified location.

Syntax
=====================================================
The syntax for using the **chef_mirror** resource in a recipe is as follows:

.. code-block:: ruby

   chef_mirror 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_mirror`` tells the chef-client to use the ``Chef::Provider::ChefMirror`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``path`` property is not specified as part of a recipe, ``name`` is also the name of the chef-client
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:download``
   

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

``:upload``
   

Properties
=====================================================
This resource has the following properties:

``chef_repo_path``
   The path to the chef-repo.

``chef_server``
   The URL for the Chef server.

``concurrency``
   The number of threads to run in-parallel. Default value: ``10``.

``freeze``
   Use to freeze cookbooks upon upload to the mirrored location. When ``true``, cookbooks are frozen.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``no_diff``
   Use to upload only new files.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``path``
   A path to a directory in the chef-repo to be mirrored. For example: ``nodes``, ``nodes/*``, ``/nodes/my_node``, ``*/*``, ``roles/base``, ``data/secrets``, ``cookbooks/apache2``, and so on.

``purge``
   Use to remove objects that have been deleted locally from the mirrored location. For example, when used with the ``:upload`` action, cookbooks that exist in the mirrored location, but do not exist locally, will be deleted.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

``versioned_cookbooks``
   Append cookbook versions to cookbooks. Set to ``false`` to hide cookbook versions: ``cookbooks/apache``. Set to ``true`` to show cookbook versions: ``cookbooks/apache-1.0.0`` and/or ``cookbooks/apache-1.0.1``. When this setting is ``true``, ``knife download`` downloads ALL cookbook versions, which can be useful if a full-fidelity backup of data on the Chef server is required. Defaults to ``true`` when ``chef_repo_path`` is specified, but this property is not.

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_chef_mirror_providers.rst
.. 

Examples
=====================================================
None.
