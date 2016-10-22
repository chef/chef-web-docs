=====================================================
Quick Start
=====================================================

For the quickest way to get started using Chef:

#. Download the Chef development kit: http://downloads.chef.io/chef-dk/.
#. Set your system Ruby to this path:

   .. code-block:: bash

      $ /opt/chefdk/embedded/bin/ruby

#. Generate a cookbook:

   .. code-block:: bash

      $ chef generate app first_cookbook

   where ``first_cookbook`` is an arbitrary cookbook name.

#. Change into the ``first_cookbook`` directory.

#. Update the ``default.rb`` recipe in the generated cookbook to contain:

   .. code-block:: ruby

      file "#{ENV['HOME']}/test.txt" do
        content 'This file was created by Chef!'
      end

#. Run the chef-client using the ``default.rb`` recipe:

   .. code-block:: bash

      $ chef-client --local-mode --override-runlist first_cookbook

This will create a file named ``test.txt`` at the home path on your machine. Open that file and it will say ``This file was created by Chef!``.

* Delete the file, run the chef-client again, and Chef will put the file back.
* Change the string in the file, run the chef-client again, and Chef will make the string in the file the same as the string in the recipe.
* Change the string in the recipe, run the chef-client again, and Chef will update that string to be the same as the one in the recipe.

There's a lot more that Chef can do, obviously, but that was super easy!

* See https://learn.chef.io/tutorials/ for more detailed setup scenarios.
* Try `running Chef in the AWS Marketplace <https://docs.chef.io/aws_marketplace.html>`_.
* Keep reading https://docs.chef.io for more information about setting up a workstation, configuring Kitchen to run virtual environments, setting up a more detailed cookbook, resources, and more.
