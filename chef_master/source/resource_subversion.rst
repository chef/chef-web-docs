=====================================================
subversion resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_subversion.rst>`__

Use the **subversion** resource to manage source control resources that exist in a Subversion repository.

.. warning:: The subversion resource has known bugs and may not work as expected. For more information see Chef GitHub issues, particularly `#4050 <https://github.com/chef/chef/issues/4050>`_ and `#4257 <https://github.com/chef/chef/issues/4257>`_.

Syntax
=====================================================
The subversion resource has the following syntax:

.. code-block:: ruby

  subversion 'name' do
    checkout_branch        String # default value: deploy
    depth                  Integer
    destination            String # default value: 'name' unless specified
    enable_checkout        true, false # default value: true
    enable_submodules      true, false # default value: false
    environment            Hash, nil
    group                  String, Integer
    remote                 String # default value: origin
    repository             String
    revision               String # default value: HEAD
    ssh_wrapper            String
    svn_arguments          String, nil, false # default value: --no-auth-cache
    svn_binary             String
    svn_info_args          String, nil, false # default value: --no-auth-cache
    svn_password           String
    svn_username           String
    timeout                Integer
    user                   String, Integer
    action                 Symbol # defaults to :sync if not specified
  end

where:

* ``subversion`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``checkout_branch``, ``depth``, ``destination``, ``enable_checkout``, ``enable_submodules``, ``environment``, ``group``, ``remote``, ``repository``, ``revision``, ``ssh_wrapper``, ``svn_arguments``, ``svn_binary``, ``svn_info_args``, ``svn_password``, ``svn_username``, ``timeout``, and ``user`` are the properties available to this resource.

Actions
=====================================================

The subversion resource has the following actions:

``:checkout``
   Clone or check out the source. When a checkout is available, this provider does nothing.

``:export``
   Export the source, excluding or removing any version control artifacts.

``:force_export``
   Export the source, excluding or removing any version control artifacts and force an export of the source that is overwriting the existing copy (if it exists).

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:sync``
   Default. Update the source to the specified version, or get a new clone or checkout. This action causes a hard reset of the index and working tree, discarding any uncommitted changes.

Properties
=====================================================

The subversion resource has the following properties:

``destination``
   **Ruby Type:** String

   The location path to which the source is to be cloned, checked out, or exported. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``group``
   **Ruby Type:** String, Integer

   The system group that is responsible for the checked-out code.

``repository``
   **Ruby Type:** String

   The URI for the Subversion repository.

``revision``
   **Ruby Type:** String | **Default Value:** ``HEAD``

   A branch, tag, or commit to be synchronized with git. This can be symbolic, like ``HEAD`` or it can be a source control management-specific revision identifier.

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

``timeout``
   **Ruby Type:** Integer

   The amount of time (in seconds) to wait for a command to execute before timing out. When this property is specified using the **deploy** resource, the value of the ``timeout`` property is passed from the **deploy** resource to the **subversion** resource.

``user``
   **Ruby Type:** String, Integer

   The system user that is responsible for the checked-out code.

Common Resource Functionality
=====================================================

Chef resources include common properties, notifications, and resource guards.

Common Properties
-----------------------------------------------------

.. tag resources_common_properties

The following properties are common to every resource:

``ignore_failure``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Continue running a recipe if a resource fails for any reason.

``retries``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The number of times to catch exceptions and retry the resource.

``retry_delay``
   **Ruby Type:** Integer | **Default Value:** ``2``

   The retry delay (in seconds).

``sensitive``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Ensure that sensitive resource data is not logged by the chef-client.

.. end_tag

Notifications
-----------------------------------------------------

 ``notifies``
    **Ruby Type:** Symbol, 'Chef::Resource[String]'

    .. tag resources_common_notification_notifies

    A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

    .. end_tag

    .. tag resources_common_notification_timers

    A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

    ``:before``
       Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

    ``:delayed``
       Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

    ``:immediate``, ``:immediately``
       Specifies that a notification should be run immediately, per resource notified.

    .. end_tag

    .. tag resources_common_notification_notifies_syntax

    The syntax for ``notifies`` is:

    .. code-block:: ruby

       notifies :action, 'resource[name]', :timer

    .. end_tag

 ``subscribes``
    **Ruby Type:** Symbol, 'Chef::Resource[String]'

    .. tag resources_common_notification_subscribes

    A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

    Note that ``subscribes`` does not apply the specified action to the resource that it listens to - for example:

    .. code-block:: ruby

      file '/etc/nginx/ssl/example.crt' do
         mode '0600'
         owner 'root'
      end

      service 'nginx' do
         subscribes :reload, 'file[/etc/nginx/ssl/example.crt]', :immediately
      end

    In this case the ``subscribes`` property reloads the ``nginx`` service whenever its certificate file, located under ``/etc/nginx/ssl/example.crt``, is updated. ``subscribes`` does not make any changes to the certificate file itself, it merely listens for a change to the file, and executes the ``:reload`` action for its resource (in this example ``nginx``) when a change is detected.

    .. end_tag

    .. tag resources_common_notification_timers

    A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

    ``:before``
       Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

    ``:delayed``
       Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

    ``:immediate``, ``:immediately``
       Specifies that a notification should be run immediately, per resource notified.

    .. end_tag

    .. tag resources_common_notification_subscribes_syntax

    The syntax for ``subscribes`` is:

    .. code-block:: ruby

       subscribes :action, 'resource[name]', :timer

    .. end_tag

Guards
-----------------------------------------------------

.. tag resources_common_guards

A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

.. end_tag
.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

``not_if``
   Prevent a resource from executing when the condition returns ``true``.

``only_if``
   Allow a resource to execute only if the condition returns ``true``.

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
