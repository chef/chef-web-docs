.. THIS PAGE IS IDENTICAL TO docs.chef.io/delivery_manage_secrets.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/delivery/ PATH.

=====================================================
Manage Secrets in a build-cookbook
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

This topic describes how and why to use secrets in a ``build-cookbook``:

* This code is used in the ``build-cookbook``
* Secrets are managed at a project level
* All of the secrets for a given project will live in the same encrypted data bag item

For more information on security, see `How to be a Secure Chef <https://learn.chef.io/skills/be-a-secure-chef/>`_.

Create a Data Bag
=====================================================
Create an encrypted data bag item that lives inside the ``delivery-secrets`` data bag. Give the encrypted data bag item the name:

.. code-block:: javascript

   <ENT>-<ORG>-<PROJECT>

If the project is in the ``chef`` enterprise and is in the ``CIA`` organization with a name of ``chef-web-www``, the encrypted data bag item would have the following name:

.. code-block:: javascript

   chef-CIA-chef-web-www

This should use the same encrypted data bag item that is distributed with the build nodes.

Use a Data Bag
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
