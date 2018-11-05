=====================================================
windows_share resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_share.rst>`__

Use the **windows_share** resource to create, modify and remove Windows shares.

**New in Chef Client 14.7.**

Syntax
=====================================================
The windows_share resource has the following syntax:

.. code-block:: ruby

  windows_share 'name' do
    ca_timeout                  Integer # default value: 0
    change_users                Array
    concurrent_user_limit       Integer # default value: 0
    continuously_available      true, false # default value: false
    description                 String
    encrypt_data                true, false # default value: false
    full_users                  Array
    path                        String
    read_users                  Array
    scope_name                  String # default value: "*"
    share_name                  String # default value: 'name' unless specified
    temporary                   true, false # default value: false
    action                      Symbol # defaults to :create if not specified
  end

where:

* ``windows_share`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``ca_timeout``, ``change_users``, ``concurrent_user_limit``, ``continuously_available``, ``description``, ``encrypt_data``, ``full_users``, ``path``, ``read_users``, ``scope_name``, ``share_name``, and ``temporary`` are the properties available to this resource.

Actions
=====================================================

The windows_share resource has the following actions:

``:create``
    Create and modify Windows shares.

``:delete``
    Delete an existing Windows share.

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The windows_share resource has the following properties:

``ca_timeout``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The continuous availability time-out for the share.

``change_users``
   **Ruby Type:** Array

   The users that should have 'modify' permission on the share in domain\username format.

``concurrent_user_limit``
   **Ruby Type:** Integer | **Default Value:** ``0``

   The maximum number of concurrently connected users the share can accommodate.

``continuously_available``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Indicates that the share is continuously available.

``description``
   **Ruby Type:** String

   The description to be applied to the share.

``encrypt_data``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Indicates that the share is encrypted.

``full_users``
   **Ruby Type:** Array

   The users that should have 'Full control' permissions on the share in domain\username format.

``path``
   **Ruby Type:** String

   The path of the folder to share. Required when creating. If the share already exists on a different path then it is deleted and re-created.

``read_users``
   **Ruby Type:** Array

   The users that should have 'read' permission on the share in domain\username format.

``scope_name``
   **Ruby Type:** String | **Default Value:** ``"*"``

   The scope name of the share.

``share_name``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The name to assign to the share.

``temporary``
   **Ruby Type:** true, false | **Default Value:** ``false``

   The lifetime of the new SMB share. A temporary share does not persist beyond the next restart of the computer.


Examples
==========================================

** Create a share **

.. code-block:: ruby

  windows_share 'foo' do
    action :create
    path 'C:\\foo'
    full_users ['DOMAIN_A\\some_user', 'DOMAIN_B\\some_other_user']
    read_users ['DOMAIN_C\\Domain users']
  end

** Delete a share **

.. code-block:: ruby

  windows_share 'foo' do
    action :delete
  end
