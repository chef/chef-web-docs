.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_chef_organization.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
chef_organization
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_chef_client/includes_chef_client.rst

Use the **chef_organization** resource to interact with organization objects that exist on the Chef server.

Syntax
=====================================================
The syntax for using the **chef_organization** resource in a recipe is as follows:

.. code-block:: ruby

   chef_organization 'name' do
     attribute 'value' # see attributes section below
     ...
     action :action # see actions section below
   end

where 

* ``chef_organization`` tells the chef-client to use the ``Chef::Provider::ChefOrganization`` provider during the chef-client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the attributes that are available for this resource
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default.

``:delete``
   

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

Properties
=====================================================
This resource has the following properties:

``chef_server``
   The URL for the Chef server.

``complete``
   Use to specify if this resource defines an organization completely. When ``true``, any property not specified by this resource will be reset to default property values.

``full_name``
   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``Chef Software, Inc.``.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``invites``
   Use to specify a list of users to be invited to the organization. An invitation is sent to any user in this list who is not already a member of the organization.

``members``
   Use to specify a list of users who MUST be members of the organization. These users will be added directly to the organization. The user who initiates this operation MUST also have permission to add users to the specified organization.

``members_specified``
   Use to discover if a user is a member of an organization. Will return ``true`` if the user is a member.

``name``
   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``raw_json``
   The organization as JSON data. For example:
       
   .. code-block:: none
       
      {
        "name": "chef",
        "full_name": "Chef Software, Inc",
        "guid": "f980d1asdfda0331235s00ff36862
        ...
      }

``remove_members``
   Use to remove the specified users from an organization. Invitations that have not been accepted will be cancelled.

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

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_chef_organization_providers.rst
.. 

Examples
=====================================================
None.
