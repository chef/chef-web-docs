=====================================================
Manage Secrets in a build-cookbook
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/delivery_manage_secrets.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

This topic describes how and why to use secrets in a ``build-cookbook``:

* This code is used in the ``build-cookbook``
* Secrets are managed at a project, organization and/or enterprise level
* There are two mechanisms to manage secrets in Chef Automate:
  - Using encrypted data bag
  - Using chef vaults 

For more information on security, see `How to be a Secure Chef <https://learn.chef.io/skills/be-a-secure-chef/>`_.


Using encrypted data bag
=====================================================

This section describes how to use encrypted data bag items in Chef Automate.

Create an Encrypted Data Bag
=====================================================
Create an encrypted data bag item that lives inside the ``delivery-secrets`` data bag. Give the encrypted data bag item the name:

.. code-block:: javascript

   <ENT>-<ORG>-<PROJECT>

If the project is in the ``chef`` enterprise and is in the ``CIA`` organization with a name of ``chef-web-www``, the encrypted data bag item would have the following name:

.. code-block:: javascript

   chef-CIA-chef-web-www

This should use the same encrypted data bag secret key that is distributed with the build nodes.

If the project item does not exist, ``delivery-sugar`` will try to load the secrets from the organization that your project lives in. It will look for an item called:

.. code-block:: javascript

   chef-CIA

This is useful if you would like to share secrets across projects within the same organization.

Use an Encrypted Data Bag
=====================================================
To use the encrypted data bag item, do the following:

#. Ensure that ``metadata.rb`` for the ``build-cookbook`` shows that it depends on the ``delivery-sugar`` cookbook (https://github.com/chef-cookbooks/delivery-sugar)
#. Update the Berksfile to point to GitHub for the cookbook. The line in your Berksfile should be similar to:

   .. code-block:: javascript

      cookbook 'delivery-sugar', github: 'chef-cookbooks/delivery-sugar'

From there, begin using the secrets by calling the ``get_project_secrets`` method. For example:

.. code-block:: ruby

   if push_repo_to_github?
     secrets = get_project_secrets
     github_repo = node['delivery']['config']['delivery-truck']['publish']['github']

     delivery_github github_repo do
       deploy_key secrets['github']
       branch node['delivery']['change']['pipeline']
       remote_url "git@github.com:#{github_repo}.git"
       repo_path node['delivery']['workspace']['repo']
       cache_path node['delivery']['workspace']['cache']
       action :push
     end
  end

which is part of the ``publish.rb`` recipe in the ``delivery-truck`` cookbook: https://github.com/chef-cookbooks/delivery-truck/blob/master/recipes/publish.rb#L91-L103.

Using a Chef Vault
=====================================================

This section describes how to use Chef Vault in Chef Automate.

Create a Chef Vault
=====================================================
In order to use this functionality you must use the following naming standard for your Chef Vaults under the `workflow-vaults` data bag:

.. code-block:: javascript

   <ENT>
   <ENT>-<ORG>
   <ENT>-<ORG>-<PROJECT>

The data in these vaults will be merged into a single Ruby hash. Any duplicate key names will be merged as follows:
  - ``<ENT>-<ORG>-<PROJECT>`` will overwrite ``<ENT>-<ORG>`` and ``<ENT>``.
  - ``<ENT>-<ORG>`` will overwrite ``<ENT>``.

Here is an example of the name of the vaults if a project is in the ``chef`` enterprise and is in the ``cookbooks`` organization with a name of ``mysql``:

.. code-block:: javascript

   chef
   chef-cookbook
   chef-cookbook-mysql

Use an Encrypted Data Bag
=====================================================
To access your secret data from the vault items, do the following:

#. Ensure that ``metadata.rb`` for the ``build-cookbook`` shows that it depends on the ``delivery-sugar`` cookbook (https://github.com/chef-cookbooks/delivery-sugar)

From there, begin using the secrets by calling the ``get_chef_vault_data`` method. For example:

.. code-block:: ruby

      vault = get_workflow_vault_data
      puts vault['my_key']

