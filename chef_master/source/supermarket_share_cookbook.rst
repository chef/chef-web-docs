=====================================================
Share Cookbooks on the Chef Supermarket
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/supermarket_share_cookbook.rst>`__

This guide will show you how to share a cookbook on the public `Chef Supermarket <https://supermarket.chef.io/>`__. The public Supermarket uses `Hosted Chef <https://manage.chef.io>`__, the Chef-as-a-service provider, for user authentication. You will need a Hosted Chef account to share cookbooks.

If you already use Hosted Chef as your Chef server, skip to the cookbook sharing method of your choice:

* Share

Create a Hosted Chef Account
-----------------------------------------------------

#. Go to the `Hosted Chef signup page <https://manage.chef.io/signup>`__ and enter the requested information to create your account.

#. You will receive a confirmation email. Use the link in the email to confirm your confirm your email address.

#. Create a Hosted Chef organization

#. Download and extract the Starter Kit.

Share Cookbooks via Stove
-------------------------------------------------------
`Stove <https://github.com/sethvargo/stove>`__ is a cookbook release utility that keeps the upload process localized to the cookbook itself, as opposed to the traditional (knife) method which requires a cookbook repository.

#. Add the following line to the ``Gemfile`` within your project's repository:

   .. code-block:: ruby

      gem 'stove'

   Create the ``Gemfile`` if it is not already present.

#. Add your Hosted Chef credentials to Stove. Replace ``USER`` with your Hosted Chef user, and ``KEY.pem`` with your Hosted Chef private key:

   .. code-block:: none

      stove login --username USER --key ~/chef-repo/.chef/KEY.pem

   Stove will save this information to its configuration file under ``~/.stove``. Note that if you've just downloaded the Hosted Chef starter kit, your private key  will be located in the chef-repo that was created by the starter kit, under ``/chef-repo/.chef/USERNAME.pem``.

#. Navigate to the root of the cookbook that you want to upload, then initialize Stove:

   .. code-block:: none

      stove

   Stove will package the cookbook, tag the cookbook version, and publish it to the public Supermarket.

Share Cookbooks via Knife
-------------------------------------------------------
The `knife cookbook site  </knife_cookbook_site.html>`__ command is used to upload cookbooks to the Supermarket via Knife. In this section you'll configure the chef-repo that was created by the Hosted Chef starter kit, and then upload cookbooks from your workstation's cookbook repository.

.. note:: If you're using Hosted Chef as your regular Chef server, skip to the second step.

#. The ``knife.rb`` file located under ``/chef-repo/.chef/knife.rb`` contains the basic information necessary to authenticate with Hosted Chef. It will look similar to the following:

   ..code-block:: ruby

     current_dir = File.dirname(__FILE__)
     log_level                :info
     log_location             STDOUT
     node_name                "brewn"
     client_key               "#{current_dir}/brewn.pem"
     chef_server_url          "https://api.chef.io/organizations/chfex"
     cookbook_path            ["#{current_dir}/../cookbooks"]

   However if you're not an existing Hosted Chef user, you've most likely created your cookbooks within another repository with its own Knife configuration. Instead of modifying your workstation setup, simply add the path to your cookbook repository under the ``cookbook_path`` setting in your Hosted Chef chef-repo. For example":

   ..code-block:: ruby

     cookbook_path

#.




Share the cookbook:

* `knife cookbook site share awesome_sauce` (if awesome_sauce is found in knife.rb's `cookbook_path`)
* `knife cookbook site share awesome_sauce -o ~/path/to/where/awesome_sauce/is` (if somewhere else)
* `stove` (while in the root of the cookbook)
    * stove will perform some better-practice actions by default, like tagging the current commit of a git repo with the version number declared in the cookbook's metadata and pushing that tag to the git remote; use `stove --no-git` to disable this feature
