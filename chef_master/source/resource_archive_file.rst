=====================================================
archive_file resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_archive_file.rst>`__

Use the **archive_file** resource to extract archive files to disk. This resource uses the libarchive library to extract multiple archive formats including tar, gzip, bzip, and zip formats.

**New in Chef Infra Client 15.0.**

Syntax
=====================================================

The archive_file resource has the following syntax:

.. code-block:: ruby

  archive_file 'name' do
    destination      String
    group            String
    mode             String, Integer # default value: "755"
    options          Array, Symbol
    overwrite        true, false, auto # default value: false
    owner            String
    path             String # default value: 'name' unless specified
    action           Symbol # defaults to :extract if not specified
  end

where:

* ``archive_file`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state.
* ``destination``, ``group``, ``mode``, ``options``, ``overwrite``, ``owner``, and ``path`` are the properties available to this resource.

Actions
=====================================================

The archive_file resource has the following actions:

``:extract``
    Extract and archive file.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

Properties
=====================================================

The archive_file resource has the following properties:

``destination``
   **Ruby Type:** String | ``REQUIRED``

   The file path to extract the archive file to.

``group``
   **Ruby Type:** String

   The group of the extracted files.

``mode``
   **Ruby Type:** String, Integer | **Default Value:** ``"755"``

   The mode of the extracted files.

``options``
   **Ruby Type:** Array, Symbol

   An array of symbols representing extraction flags. Example: ``:no_overwrite`` to prevent overwriting files on disk. By default, this properly sets ``:time``, which preserves the modification timestamps of files in the archive when writing them to disk.

``overwrite``
   **Ruby Type:** true, false, auto | **Default Value:** ``false``

   Should the resource overwrite the destination file contents if they already exist? If set to ``:auto``, the date stamp of files within the archive will be compared to those on disk, and disk contents will be overwritten if they differ. This may cause unintended consequences if disk date stamps are changed between runs, which will result in the files being overwritten during each client run. Make sure to properly test any change to this property.

``owner``
   **Ruby Type:** String

   The owner of the extracted files.

``path``
   **Ruby Type:** String | **Default Value:** ``The resource block's name``

   An optional property to set the file path to the archive to extract if it differs from the resource block's name.

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

  The number of attempts to catch exceptions and retry the resource.

``retry_delay``
  **Ruby Type:** Integer | **Default Value:** ``2``

  The retry delay (in seconds).

``sensitive``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Ensure that sensitive resource data is not logged by Chef Infra Client.

.. end_tag

Notifications
-----------------------------------------------------

``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A timer specifies the point during a Chef Infra Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of a Chef Infra Client run.

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

A guard property can be used to evaluate the state of a node during the execution phase of a Chef Infra Client run. Based on the results of this evaluation, a guard property is then used to tell Chef Infra Client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for Chef Infra Client to do nothing.

.. end_tag

**Properties**

.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of a Chef Infra Client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
==========================================

**Extract a zip file to a specified diredtory**

.. code-block:: ruby

   archive_file 'Precompiled.zip' do
     path '/tmp/Precompiled.zip'
     destination '/srv/files'
   end

.. end_tag
