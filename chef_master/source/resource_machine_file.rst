=====================================================
machine_file
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_machine_file.rst>`__

.. tag resource_machine_file_summary

Use the **machine_file** resource to manage a file on a remote machine in much the same way the **file** resource is used to manage a file on a local machine.

.. end_tag

.. warning:: .. tag notes_provisioning

             This functionality is available with Chef provisioning and is packaged in the Chef development kit. Chef provisioning is a framework that allows clusters to be managed by the chef-client and the Chef server in the same way nodes are managed: with recipes. Use Chef provisioning to describe, version, deploy, and manage clusters of any size and complexity using a common set of tools.

             .. end_tag

Syntax
=====================================================
.. tag resource_machine_file_syntax

The syntax for using the **machine_file** resource in a recipe is as follows:

.. code-block:: ruby

   machine_file 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_file`` tells the chef-client to use the ``Chef::Provider::MachineFile`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``path`` property is not specified as part of a recipe, ``name`` is also the path to a file
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
=====================================================
.. tag resource_machine_file_actions

This resource has the following actions:

``:delete``
   Use to delete a file from a machine.

``:download``
   Use to download a file from a machine.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

``:upload``
   Default. Use to upload a file to a machine.

.. end_tag

Properties
=====================================================
.. tag resource_machine_file_attributes

This resource has the following properties:

``chef_server``
   **Ruby Type:** Hash

   The URL for the Chef server.

``content``
   A string that is written to the file. The contents of this property replace any previous content when this property has something other than the default value. The default behavior will not modify content.

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.

``group``
   **Ruby Type:** String

   A string or ID that identifies the group owner by group name, including fully qualified group names such as ``domain\group`` or ``group@domain``. If this value is not specified, existing groups remain unchanged and new group assignments use the default ``POSIX`` group (if available).

``local_path``
   **Ruby Type:** String

   The local path to a file.

``machine``
   **Ruby Type:** String

   Use to specify the machine type.

``mode``
   **Ruby Type:** String

   If ``mode`` is not specified and if the file already exists, the existing mode on the file is used. If ``mode`` is not specified, the file does not exist, and the ``:create`` action is specified, the chef-client assumes a mask value of ``'0777'`` and then applies the umask for the system on which the file is to be created to the ``mask`` value. For example, if the umask on a system is ``'022'``, the chef-client uses the default value of ``'0755'``.

   The behavior is different depending on the platform.

   UNIX- and Linux-based systems: A quoted 3-5 character string that defines the octal mode that is passed to chmod. For example: ``'755'``, ``'0755'``, or ``00755``. If the value is specified as a quoted string, it works exactly as if the ``chmod`` command was passed. If the value is specified as an integer, prepend a zero (``0``) to the value to ensure that it is interpreted as an octal number. For example, to assign read, write, and execute rights for all users, use ``'0777'`` or ``'777'``; for the same rights, plus the sticky bit, use ``01777`` or ``'1777'``.

   Microsoft Windows: A quoted 3-5 character string that defines the octal mode that is translated into rights for Microsoft Windows security. For example: ``'755'``, ``'0755'``, or ``00755``. Values up to ``'0777'`` are allowed (no sticky bits) and mean the same in Microsoft Windows as they do in UNIX, where ``4`` equals ``GENERIC_READ``, ``2`` equals ``GENERIC_WRITE``, and ``1`` equals ``GENERIC_EXECUTE``. This property cannot be used to set ``:full_control``. This property has no effect if not specified, but when it and ``rights`` are both specified, the effects are cumulative.

.. end_tag

Examples
=====================================================

**Get a remote file onto a new machine**

.. tag resource_machine_file_get_remote_file

A deployment process requires more than just setting up machines. For example, files may need to be copied to machines from remote locations. The following example shows how to use the **remote_file** resource to grab a tarball from a URL, create a machine, copy that tarball to the machine, and then get that machine running by using a recipe that installs and configures that tarball on the machine:

.. code-block:: ruby

   remote_file 'mytarball.tgz' do
     url 'https://myserver.com/mytarball.tgz'
   end

   machine 'x'
     action :allocate
   end

   machine_file '/tmp/mytarball.tgz' do
     machine 'x'
     local_path 'mytarball.tgz'
     action :upload
   end

   machine 'x' do
     recipe 'untarthatthing'
     action :converge
   end

.. end_tag
