=====================================================
Manage Secrets in a build-cookbook
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/delivery_manage_secrets.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

This topic describes how and why to use secrets in a ``build-cookbook``:

* This code is used in the ``build-cookbook``
* Secrets are managed at the project, organization and/or enterprise level
* There are two mechanisms to manage secrets in Chef Automate:

  * Using an encrypted data bag.
  * Using chef vaults.

For more information on security, see `How to be a Secure Chef <https://learn.chef.io/tracks/administering-chef-installation/>`_.


Using Encrypted Data Bags
=====================================================

This section describes how to use encrypted data bag items in Chef Automate.

Create an Encrypted Data Bag
=====================================================
Create an encrypted data bag item that is nested inside the ``delivery-secrets`` data bag. Give the encrypted data bag item the name:

.. code-block:: javascript

   <ENT>-<ORG>-<PROJECT>

For example, if the project is in the ``chef`` enterprise and is in the ``CIA`` organization with a name of ``chef-web-www``, the encrypted data bag item would have the following name:

.. code-block:: javascript

   chef-CIA-chef-web-www

The encrypted data bag item should use the same encrypted data bag secret key that is distributed with the build nodes.

If the project item does not exist, ``delivery-sugar`` will try to load the secrets from the project's parent organization. It will look for an item called:

.. code-block:: javascript

   chef-CIA

This is useful if you would like to share secrets across projects within the same organization.

Use an Encrypted Data Bag
=====================================================
To use an encrypted data bag item, do the following:

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

This example is part of the ``publish.rb`` recipe in the ``delivery-truck`` cookbook: https://github.com/chef-cookbooks/delivery-truck/blob/master/recipes/publish.rb#L91-L103.

Using a Chef Vault
=====================================================

This section describes how to use Chef vault in Chef Automate.

Create a Chef Vault
=====================================================
In order to use Chef vaults you must follow hierarchical naming standard for your Chef vaults under the `workflow-vaults` data bag:

.. code-block:: javascript

   <ENT>
   <ENT>-<ORG>
   <ENT>-<ORG>-<PROJECT>

For example, if the ``chef`` enterprise has a ``cookbooks`` organization with a ``mysql`` project, it would have the naming schema:

.. code-block:: javascript

   chef
   chef-cookbook
   chef-cookbook-mysql

During the creation of a Chef vault, the data in these vaults are merged into a single Ruby hash. Any duplicate key names will be merged as follows:
   - ``<ENT>-<ORG>-<PROJECT>`` will overwrite ``<ENT>-<ORG>`` and ``<ENT>``.
   - ``<ENT>-<ORG>`` will overwrite ``<ENT>``.

Using Secrets in a Chef Vault
=====================================================
To access your secret data from the vault items, ensure that ``metadata.rb`` for the ``build-cookbook`` shows that it depends on the ``delivery-sugar`` cookbook (https://github.com/chef-cookbooks/delivery-sugar). From there, begin using the secrets by calling the ``get_chef_vault_data`` method. 

For example:

.. code-block:: ruby

      vault = get_workflow_vault_data
      puts vault['my_key']
