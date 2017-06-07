=====================================================
About the Workflow DSL
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/dsl_delivery.rst>`__

The Workflow DSL is a collection of helper methods that is used in recipes as a way to enhance the Recipe DSL to collect data about:

* Which testing tools---Foodcritic, Kitchen, ChefSpec, and so on---are present in a cookbook?
* What types of delivery environments are available?
* Have files been changed?
* Do the changes made to a cookbook require a version change?
* Should a cookbook should be pushed to the Chef server and/or to GitHub?

.. warning:: These recipe helpers are available from the ``delivery-truck`` cookbook: https://github.com/opscode-cookbooks/delivery-truck. This cookbook is a recommended dependency for any ``build-cookbook`` for a project that publishes changes to a Chef Automate pipeline.

Helpers
=====================================================
The following Chef Automate-specific helpers can be used in recipes:

``bumped_version?``
   Determine if files in a cookbook have been modified, and then to ensure that a cookbook's version is updated in its metadata.rb file. The Verify phase will fail if files in a cookbook are modified without a corresponding vesrion bump to the metadata.rb file.

``changed_cookbooks``
   Get a list of cookbooks that have been modified.

``changed_files``
   Get a list of files that have been modified.

``define_project_application``
   Define a set of attributes that are used to pin versions as the project moves through stages in the Chef Automate pipeline.

``delivery_chef_server``
   Return a Hash that contains details about how to talk to the Chef server.

``delivery_chef_server_search``
   Run a search query against the node objects on the Chef server, using the default search query. The default search query is defined in the Chef Automate web UI on the "Default Search" tab.

``delivery_environment``
   Get the name of the standard environment.

``deployment_search_query``
   Get a custom search query from the ``config.json`` file. By default, the ``deploy.rb`` recipe triggers a chef-client run via Chef push jobs against all nodes that belong to the current environment in Chef Automate and have modified cookbooks in the run-list.

   If the ``config.json`` file specifies:

   .. code-block:: javascript

      "delivery-truck": {
        "deploy": {
          "search": "SEARCH_QUERY"
        }
      }

   then the search is run against all node objects on the Chef server. For example:

   .. code-block:: javascript

      "delivery-truck": {
        "deploy": {
          "search": "role:load_balancer"
        }
      }

``foodcritic_excludes``
   Get a list of directories against which Foodcritic rules should not be run. This looks in the ``config.json`` file for the ``foodcritic`` block to see if the ``excludes`` setting has been specified.

   .. tag delivery_config_json_setting_delivery_truck_lint_foodcritic_excludes

   If the ``config.json`` file specifies:

   .. code-block:: javascript

      "delivery-truck": {
        "lint": {
          "foodcritic": {
            "ignore_rules": ["RULE", "RULE", ...],
            "only_rules": ["RULE", "RULE", ...],
            "excludes": ["spec", "test"]
          }
        }
      }

   then Foodcritic rules are not run against tests that are located in the specified directories, in this case the ``/spec`` and ``/test`` directories.

   .. end_tag

``foodcritic_tags``
   Get a list of Foodcritic tags (rule identifiers) to be run. This looks in the ``config.json`` file for the ``foodcritic`` block to see if the ``only_rules`` and/or ``ignore_rules`` settings have been specified.

   .. tag delivery_config_json_setting_delivery_truck_lint_foodcritic_ignore_rules

   If the ``config.json`` file specifies:

   .. code-block:: javascript

      "delivery-truck": {
        "lint": {
          "foodcritic": {
            "ignore_rules": ["FC009", "FC057", "FC058"],
            "excludes": ["DIRECTORY", "DIRECTORY", ...]
          }
        }
      }

   then all Foodcritic rules except ``FC009``, ``FC057``, and ``FC058``  rules are run.

   .. end_tag

   .. tag delivery_config_json_setting_delivery_truck_lint_foodcritic_only_rules

   If the ``config.json`` file specifies:

   .. code-block:: javascript

      "delivery-truck": {
        "lint": {
          "foodcritic": {
            "only_rules": ["FC002"],
            "excludes": ["DIRECTORY", "DIRECTORY", ...]
          }
        }
      }

   then only the ``FC002`` Foodcritic rules is run.

   .. end_tag

``get_acceptance_environment``
   Get the name of the acceptance environment.

``get_project_application``
   Get attributes for a defined project application.

   .. warning:: If the ``get_project_application`` method is called from the ``provision.rb`` recipe, be sure that ``delivery-truck::provision`` is executed before ``get_project_application`` by putting it in a ``ruby_block`` or into a separate recipe that is called from ``provision.rb`` via ``include_recipe``. If the ``get_project_application`` method is called directly in ``provision.rb``:

                .. code-block:: ruby

                   include_recipe 'delivery-truck::provision'
                   get_project_application(<project_app_name_string>)

                you will get an error because the chef-client will execute ``get_project_application`` at compile time before it has run ``include_recipe 'delivery-truck::provision'``. It is recommended to either use ``get_project_application`` in ``deploy.rb``, a project cookbook, in a ``ruby_block`` or in a separate ``include_recipe`` that is executed after ``include_recipe 'delivery-truck::provision'``.

``get_project_secrets``
   Get the contents of the ``delivery-secrets`` data bag from the Chef server. This data bag contains secrets that enable cookbooks to be published to a Chef Supermarket, an open source git repository, a repository on GitHub.

``has_kitchen_tests?``
   Determine if a .kitchen.yml file exists in a cookbook.

``has_spec_tests?``
   Determine if tests exist in the ``/spec`` directory in a cookbook.

``push_repo_to_git?``
   Determine if a repo should be pushed to an open source git repository.

   .. tag delivery_config_json_setting_delivery_truck_publish_git

   If the ``config.json`` file specifies the following cookbooks are published to a git repository located on an open source git server:

   .. code-block:: javascript

      "delivery-truck":{
        "publish": {
          "git": "ssh://git@stash:2222/<project-name>/<repo-name>"
        }
      }

   This publishing option requires the ``git`` deploy key for that repository to be available from a data bag on the Chef server that is part of this Chef Automate configuration.

   .. end_tag

``push_repo_to_github?``
   Determine if a repo should be pushed to GitHub.

   .. tag delivery_config_json_setting_delivery_truck_publish_github

   If the ``config.json`` file specifies the following cookbooks are published to a GitHub repository:

   .. code-block:: javascript

      "delivery-truck":{
        "publish": {
          "github": "chef/chef-web-docs"
        }
      }

   where ``"chef/chef-web-docs"`` represents the organization/repository to which the ``build-cookbook`` belongs.

   This publishing option requires the ``github`` deploy key for that repository to be available from a data bag on the Chef server that is part of this Chef Automate configuration.

   .. end_tag

``share_cookbook_to_supermarket?``
   Determine if a repo should be pushed to an open source git repository.

   .. tag delivery_config_json_setting_delivery_truck_publish_supermarket

   Publish cookbooks to the public Chef Supermarket:

   If the ``config.json`` file specifies the following cookbooks are published to the public Chef Supermarket:

   .. code-block:: javascript

      "delivery-truck":{
        "publish": {
          "supermarket": "https://supermarket.chef.io"
        }
      }

   .. end_tag

   .. tag delivery_config_json_setting_delivery_truck_publish_supermarket_private

   Publish cookbooks to a private Chef Supermarket:

   .. code-block:: javascript

      "delivery-truck":{
        "publish": {
          "supermarket": "https://private-supermarket.example.com"
        }
      }

   .. end_tag

``upload_cookbook_to_chef_server?``
   Determine if a cookbook should be pushed to the Chef server.

   .. tag delivery_config_json_setting_delivery_truck_publish_chef_server

   If the ``config.json`` file specifies the following cookbooks are published to the Chef server that is part of this Chef Automate configuration:

   .. code-block:: javascript

      "delivery-truck":{
        "publish": {
          "chef_server": "true"
        }
      }

   .. end_tag

``use_custom_supermarket_credentials``

   .. tag delivery_config_json_setting_delivery_truck_publish_supermarket_credentials

   Publish cookbooks to Chef Supermarket, but with custom credentials:

   .. code-block:: javascript

      "delivery-truck":{
        "publish": {
          "supermarket": "https://supermarket.chef.io",
          "supermarket-custom-credentials": "true"
        }
      }

   This ``publish`` option requires the ``supermarket_user`` and ``supermarket_key`` credentials to be available from the
   ``delivery-secrets`` data bag on the Chef server that is part of this Chef Automate configuration. For more information on the ``delivery-secrets`` data bag,
   see `Handling Secrets <https://github.com/chef-cookbooks/delivery-sugar#handling-secrets-alpha>`_ in the ``delivery-sugar`` cookbook README file.

   .. end_tag

Node Attributes
=====================================================
Node attributes specific to the workspace, project changes, and project configuration are available for use in ``build-cookbook`` recipes.

Project Changes
-----------------------------------------------------
Use attributes from the ``node['delivery']['change']`` namespace to get details about the job execution for the current change in the pipeline.

``change_id``
   Use ``node['delivery']['change']['change_id']`` for the change identifier.

``enterprise``
   Use ``node['delivery']['change']['enterprise']`` for the enterprise name.

``git_url``
   Use ``node['delivery']['change']['git_url']`` for the URL for the git project.

``organization``
   Use ``node['delivery']['change']['organization']`` for the organization name.

``patchset_branch``
   Use ``node['delivery']['change']['patchset_branch']`` for the branch name.

``patchset_number``
   Use ``node['delivery']['change']['patchset_number']`` for the patchset number.

``phase``
   Use ``node['delivery']['change']['phase']`` for the current phase name.

``pipeline``
   Use ``node['delivery']['change']['pipeline']`` for the pipeline name.

``project``
   Use ``node['delivery']['change']['project']`` for the project name.

``sha``
   Use ``node['delivery']['change']['sha']`` for the SHA-1 hash.

``stage``
   Use ``node['delivery']['change']['stage']`` for the current stage name.

Project Configuration
-----------------------------------------------------
Use attributes from the ``node['delivery']['config']`` namespace to get :doc:`configuration settings from the .delivery/config.json file </config_json_delivery>`.

``['build-cookbook']``
   Use ``node['delivery']['config']['build-cookbook']`` for the contents of the ``"build-cookbook"`` configuration setting.

``['build_nodes']``
   Use ``node['delivery']['config']['build_nodes']`` for the contents of the ``"build-cookbook"`` configuration setting.

``['delivery-truck']``
   Use ``node['delivery']['config']['delivery-truck']`` for the contents of the ``"build-cookbook"`` configuration setting.

``['delivery-truck']['PHASE_NAME']``
   Use ``node['delivery']['config']['delivery-truck']['phase_name']`` for the contents of a specific phase within the ``"build-cookbook"`` configuration setting. Replace ``PHASE_NAME`` with the actual phase name. For example: ``node['delivery']['config']['delivery-truck']['publish']``.

``dependencies``
   Use ``node['delivery']['config']['dependencies']`` for the contents of the ``"build-cookbook"`` configuration setting.

``skip_phases``
   Use ``node['delivery']['config']['skip_phases']`` for the contents of the ``"skip_phases"`` configuration setting.

``version``
   Use ``node['delivery']['config']['version']`` for the contents of the ``"version"`` configuration setting.

Workspace
-----------------------------------------------------
Use attributes from the ``node['delivery']['workspace']`` namespace to get paths to workspace directories on a build node/runner.

``cache``
   Use ``node['delivery']['workspace']['cache']`` for the ``/cache`` directory.

``chef``
   Use ``node['delivery']['workspace']['chef']`` for the ``/chef`` directory.

``root``
   Use ``node['delivery']['workspace']['root']`` for the root directory, typically ``/var/opt/delivery/workspace``.

``repo``
   Use ``node['delivery']['workspace']['repo']`` for the ``/repo`` directory.

Workspace Path
-----------------------------------------------------
Use the ``node['delivery']['workspace_path']`` attribute to get the path to the global workspace.

Examples
=====================================================
The following examples show how to use the Workflow DSL in a cookbook:

**changed_cookbooks**

.. code-block:: ruby

   changed_cookbooks.each do |cookbook|
     execute "unit_rspec_#{cookbook[:name]}" do
       cwd cookbook[:path]
       command "rspec --format documentation --color"
       only_if { has_spec_tests?(cookbook[:path]) }
     end
   end

**bumped_version?**

.. code-block:: ruby

   changed_cookbooks.each do |cookbook|
     unless bumped_version?(cookbook[:path])
       raise DeliveryTruck::Error, "The #{cookbook[:name]} cookbook was modified " \
                                   "but the version was not updated in the " \
                                   "metadata file."
     end

     execute "syntax_check_#{cookbook[:name]}" do
       command "knife cookbook test -o #{cookbook[:path]} -a"
     end
   end

**push_repo_to_github?**

.. code-block:: ruby

   if push_repo_to_github?
     git_ssh = File.join(node['delivery']['workspace']['cache'], 'git_ssh')
     deploy_key = File.join(node['delivery']['workspace']['cache'], 'github.pem')
     secrets = get_project_secrets

     file deploy_key do
       content secrets['github']
       owner 'dbuild'
       mode '0600'
       sensitive true
     end

     template git_ssh do
       source 'git_ssh.erb'
       owner 'dbuild'
       mode '0755'
     end

     execute "set_git_username" do
       command "git config user.name 'Delivery'"
       cwd node['delivery']['workspace']['repo']
       environment({"GIT_SSH" => git_ssh})
     end

     execute "set_git_email" do
       command "git config user.email 'delivery@chef.io'"
       cwd node['delivery']['workspace']['repo']
       environment({"GIT_SSH" => git_ssh})
     end

     github_repo = node['delivery']['config']['delivery-truck']['publish']['github']
     execute "add_github_remote" do
       command "git remote add github git@github.com:#{github_repo}.git"
       cwd node['delivery']['workspace']['repo']
       environment({"GIT_SSH" => git_ssh})
       not_if "git remote --verbose | grep ^github"
     end

     execute "push_to_github" do
       command "git push github master"
       cwd node['delivery']['workspace']['repo']
       environment({"GIT_SSH" => git_ssh})
     end
   end
