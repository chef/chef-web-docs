=====================================================
Quick Start
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/quick_start.rst>`__

For the quickest way to get started using Chef Infra:

#. Install Chef Workstation: https://downloads.chef.io/chef-workstation/.

#. Generate a cookbook:

   .. code-block:: bash

      $ chef generate cookbook first_cookbook

   where ``first_cookbook`` is an arbitrary cookbook name.

#. Navigate to the ``first_cookbook`` directory.

#. Update the ``cookbooks/first_cookbook/recipes/default.rb`` recipe in the generated cookbook to contain:

   .. code-block:: ruby

      file "#{ENV['HOME']}/test.txt" do
        content 'This file was created by Chef Infra!'
      end

#. Run Chef Infra Client using the ``default.rb`` recipe:

   .. code-block:: bash

      $ chef-client --local-mode --override-runlist first_cookbook

This will create a file named ``test.txt`` at the home path on your machine. Open that file and it will say ``This file was created by Chef Infra!``.

* Delete the file, run Chef Infra Client again, and Chef Infra will put the file back.
* Change the string in the file, run Chef Infra Client again, and Chef Infra will make the string in the file the same as the string in the recipe.
* Change the string in the recipe, run Chef Infra Client again, and Chef Infra will update that string to be the same as the one in the recipe.

There's a lot more that Chef Infra can do, obviously, but that was super easy!

* See https://learn.chef.io/ for more detailed setup scenarios.
* Keep reading for more information about setting up a workstation, configuring Test Kitchen to run virtual environments, setting up a more detailed cookbook, resources, and more.
