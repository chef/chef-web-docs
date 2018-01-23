==================================================================
Deprecation: :uninstall Resource for chocolatey_package (CHEF-21)
==================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_chocolatey_uninstall.rst>`__

The Chocolatey cookbook’s ``chocolatey_package`` resource originally contained an ``:uninstall`` action. When `chocolatey_package </resource_chocolatey_package.html>`__ was moved into core Chef, we made ``:uninstall`` an alias for ``:remove``. In Chef 14, ``:uninstall`` will no longer be a valid action. Foodcritic rule `FC103 <http://www.foodcritic.io/#FC103>`__ has been introduced to detect usage of the ``:uninstall`` action.

Remediation
================
The ``:uninstall`` action must be replaced with the ``:remove`` action when using the ``chocolatey_package`` resource in recipes that you intend to use with Chef 14. For example, where you might previously have used the following code to uninstall ``nginx``:

.. code-block:: ruby

   chocolatey_package 'nginx' do
     action :uninstall
   end

You would instead use:

.. code-block:: ruby

   chocolatey_package 'nginx' do
     action :remove
   end
