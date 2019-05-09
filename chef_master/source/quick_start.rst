=====================================================
Quick Start
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/quick_start.rst>`__

For the quickest way to get started using Chef:

#. Install ChefDK: https://downloads.chef.io/chefdk/.

#. Generate a cookbook:

   .. code-block:: bash

      $ chef generate cookbook first_cookbook

   where ``first_cookbook`` is an arbitrary cookbook name.

#. Navigate to the ``first_cookbook`` directory.

#. Update the ``cookbooks/first_cookbook/recipes/default.rb`` recipe in the generated cookbook to contain:

   .. code-block:: ruby

      file "#{ENV['HOME']}/test.txt" do
        content 'This file was created by Chef!'
      end

#. Run the Chef Infra Client using the ``default.rb`` recipe:

   .. code-block:: bash

      $ chef-client --local-mode --override-runlist first_cookbook

This will create a file named ``test.txt`` at the home path on your machine. Open that file and it will say ``This file was created by Chef!``.

* Delete the file, run the Chef Infra Client again, and Chef will put the file back.
* Change the string in the file, run the Chef Infra Client again, and Chef will make the string in the file the same as the string in the recipe.
* Change the string in the recipe, run the Chef Infra Client again, and Chef will update that string to be the same as the one in the recipe.

There's a lot more that Chef can do, obviously, but that was super easy!

* See https://learn.chef.io/ for more detailed setup scenarios.
* Keep reading  for more information about setting up a workstation, configuring Kitchen to run virtual environments, setting up a more detailed cookbook, resources, and more.
