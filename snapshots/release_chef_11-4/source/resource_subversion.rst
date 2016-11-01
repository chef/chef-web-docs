

=====================================================
subversion
=====================================================

.. tag resource_scm_subversion

Use the **subversion** resource to manage source control resources that exist in a Subversion repository.

.. end_tag

.. note:: .. tag notes_scm_resource_use_with_resource_deploy

          This resource is often used in conjunction with the **deploy** resource.

          .. end_tag

Syntax
=====================================================
.. tag 6_9

A **subversion** resource block manages source control resources that exist in a Subversion repository:

.. code-block:: ruby

   subversion 'CouchDB Edge' do
     repository 'http://svn.apache.org/repos/asf/couchdb/trunk'
     revision 'HEAD'
     destination '/opt/mysources/couch'
     action :sync
   end

The full syntax for all of the properties that are available to the **subversion** resource is:

.. code-block:: ruby

   subversion 'name' do
     destination                String # defaults to 'name' if not specified
     group                      String, Integer
     notifies                   # see description
     provider                   Chef::Provider::Scm::Subversion
     repository                 String
     revision                   String
     subscribes                 # see description
     svn_arguments              String
     svn_info_args              String
     svn_password               String
     svn_username               String
     user                       String, Integer
     action                     Symbol # defaults to :sync if not specified
   end

where

* ``subversion`` is the resource
* ``name`` is the name of the resource block and also (when the ``destination`` property is not specified) the location in which the source files will be placed and/or synchronized with the files under source control management
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``destination``, ``group``, ``provider``, ``repository``, ``revision``, ``svn_arguments``, ``svn_info_args``, ``svn_password``, ``svn_username``, and ``user`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
=====================================================
.. tag resource_scm_subversion_actions

This resource has the following actions:

``:checkout``
   Clone or check out the source. When a checkout is available, this provider does nothing.

``:export``
   Export the source, excluding or removing any version control artifacts.

``:force_export``
   Export the source, excluding or removing any version control artifacts and force an export of the source that is overwriting the existing copy (if it exists).

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:sync``
   Default. Update the source to the specified version, or get a new clone or checkout. This action causes a hard reset of the index and working tree, discarding any uncommitted changes.

.. end_tag

Properties
=====================================================
.. tag 6_8

This resource has the following properties:

``destination``
   **Ruby Type:** String

   The location path to which the source is to be cloned, checked out, or exported. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``group``
   **Ruby Types:** String, Integer

   The system group that is responsible for the checked-out code.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.

``repository``
   **Ruby Type:** String

   The URI for the Subversion repository.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``revision``
   **Ruby Type:** String

   A branch, tag, or commit to be synchronized with git. This can be symbolic, like ``HEAD`` or it can be a source control management-specific revision identifier. Default value: ``HEAD``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

``svn_arguments``
   **Ruby Type:** String

   The extra arguments that are passed to the Subversion command.

``svn_info_args``
   **Ruby Type:** String

   Use when the ``svn info`` command is used by the chef-client and arguments need to be passed. The ``svn_arguments`` command does not work when the ``svn info`` command is used.

``svn_password``
   **Ruby Type:** String

   The password for a user that has access to the Subversion repository.

``svn_username``
   **Ruby Type:** String

   The user name for a user that has access to the Subversion repository.

``user``
   **Ruby Types:** String, Integer

   The system user that is responsible for the checked-out code.

.. end_tag

Providers
=====================================================
.. tag resources_common_provider

Where a resource represents a piece of the system (and its desired state), a provider defines the steps that are needed to bring that piece of the system from its current state into the desired state.

.. end_tag

.. tag resources_common_provider_attributes

The chef-client will determine the correct provider based on configuration data collected by Ohai at the start of the chef-client run. This configuration data is then mapped to a platform and an associated list of providers.

Generally, it's best to let the chef-client choose the provider, and this is (by far) the most common approach. However, in some cases, specifying a provider may be desirable. There are two approaches:

* Use a more specific short name---``yum_package "foo" do`` instead of ``package "foo" do``, ``script "foo" do`` instead of ``bash "foo" do``, and so on---when available
* Use the ``provider`` property within the resource block to specify the long name of the provider as a property of a resource. For example: ``provider Chef::Provider::Long::Name``

.. end_tag

.. tag resource_scm_subversion_providers

This resource has the following providers:

``Chef::Provider::Subversion``, ``subversion``
   This provider work only with Subversion.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Get the latest version of an application**

.. tag resource_scm_get_latest_version

.. To get the latest version of CouchDB:

.. code-block:: ruby

   subversion 'CouchDB Edge' do
     repository 'http://svn.apache.org/repos/asf/couchdb/trunk'
     revision 'HEAD'
     destination '/opt/mysources/couch'
     action :sync
   end

.. end_tag

