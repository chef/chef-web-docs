=====================================================
windows_certificate resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_certificate.rst>`__

Use the **windows_certificate** resource to install a certificate into the Windows certificate store from a file. The resource grants read-only access to the private key for designated accounts. Due to current limitations in WinRM, installing certificates remotely may not work if the operation requires a user profile. Operations on the local machine store should still work.

**New in Chef Client 14.7.**

Syntax
=====================================================
The windows_certificate resource has the following syntax:

.. code-block:: ruby

  windows_certificate 'name' do
    cert_path            String
    pfx_password         String
    private_key_acl      Array
    source               String # default value: 'name' unless specified
    store_name           String # default value: "MY"
    user_store           true, false # default value: false
    action               Symbol # defaults to :create if not specified
  end

where:

* ``windows_certificate`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``cert_path``, ``pfx_password``, ``private_key_acl``, ``source``, ``store_name``, and ``user_store`` are the properties available to this resource.

Actions
=====================================================

The windows_certificate resource has the following actions:

``:acl_add``
    Adds read-only entries to a certificate's private key ACL.

``:create``
    Creates or updates a certificate.

``:delete``
    Deletes a certificate.

``:fetch``
    Fetches a certificate.

``:verify``
    Verifies a certificate.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

Properties
=====================================================

The windows_certificate resource has the following properties:

``cert_path``
   **Ruby Type:** String

``pfx_password``
   **Ruby Type:** String

   The password to access the source if it is a pfx file.

``private_key_acl``
   **Ruby Type:** Array

   An array of 'domain\account' entries to be granted read-only access to the certificate's private key. Not idempotent.

``source``
   **Ruby Type:** String | **Default Value:** ``'name'``

   The source file (for create and acl_add), thumbprint (for delete and acl_add) or subject (for delete).

``store_name``
   **Ruby Type:** String | **Default Value:** ``"MY"``

   The certificate store to manipulate.

``user_store``
   **Ruby Type:** true, false | **Default Value:** ``false``

   Use the user store of the local machine store if set to false.

Examples
==========================================

**Add PFX cert to local machine personal store and grant accounts read-only access to private key**

.. code-block:: ruby

  windows_certificate 'c:/test/mycert.pfx' do
    pfx_password 'password'
    private_key_acl ["acme\fred", "pc\jane"]
  end

**Add cert to trusted intermediate store**

.. code-block:: ruby

  windows_certificate 'c:/test/mycert.cer' do
    store_name 'CA'
  end

**Remove all certificates matching the subject**

.. code-block:: ruby

  windows_certificate 'me.acme.com' do
    action :delete
  end
