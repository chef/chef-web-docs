.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


A Policyfile.rb file may contain the following settings:

``name "name"``
   Required. The name of the policy. Use a name that reflects the purpose of the machines against which the policy will run.

``run_list "ITEM", "ITEM", ...``
   Required. The run-list the chef-client will use to apply the policy to one (or more) nodes.
   
``default_source :SOURCE_TYPE, *args``
   The location in which any cookbooks not specified by ``cookbook`` are located. Possible values: ``chef_repo``, ``:community``, and ``:supermarket``. Use more than one ``default_source`` to specify more than one location for cookbooks.

   ``default_source :supermarket`` pulls cookbooks from the public Chef Supermarket.

   ``default_source :supermarket, "https://mysupermarket.example"`` pulls cookbooks from a named private Chef Supermarket.

   ``default_source :community`` is an alias for ``:supermarket``.

   ``default_source :chef_repo, "path/to/repo"`` pulls cookbooks from a monolithic cookbook repository. This may be a path to the top-level of a cookbook repository or to the ``/cookbooks`` directory within that repository.

   Multiple cookbook sources may be specified. For example from the public Chef Supermarket and a monolithic repository:

   .. code-block:: ruby

	  default_source :supermarket
	  default_source :chef_repo, "path/to/repo"

   or from both a public and private Chef Supermarket:

   .. code-block:: ruby

	  default_source :supermarket
	  default_source :supermarket, "https://supermarket.example"

   .. note:: If a run-list or any dependencies require a cookbook that is present in more than one source, be explicit about which source is preferred. This will ensure that a cookbook is always pulled from an expected source. For example, an internally-developed cookbook named ``chef-client`` will conflict with the public ``chef-client`` cookbook that is maintained by Chef. To specify a named source for a cookbook:

      .. code-block:: ruby

         default_source :supermarket
         default_source :supermarket, "https://supermarket.example" do |s|
           s.preferred_for "chef-client"
         end

      List multiple cookbooks on the same line:

      .. code-block:: ruby

         default_source :supermarket
         default_source :supermarket, "https://supermarket.example" do |s|
           s.preferred_for "chef-client", "nginx", "mysql"
         end

``cookbook "NAME" [, "VERSION_CONSTRAINT"] [, SOURCE_OPTIONS]``
   Add cookbooks to the policy, specify a version constraint, or specify an alternate source location, such as Chef Supermarket. For example, add a cookbook:

   .. code-block:: ruby

      cookbook "apache2"

   Specify a version constraint:

   .. code-block:: ruby

      run_list "jenkins::master"
      
      # Restrict the jenkins cookbook to version 2.x, greater than 2.1
      cookbook "jenkins", "~> 2.1"

   Specify an alternate source:

   .. code-block:: ruby

      cookbook 'my_app', path: 'cookbooks/my_app'

   or:

   .. code-block:: ruby

      cookbook 'mysql', github: 'opscode-cookbooks/mysql', branch: 'master'

   or:

   .. code-block:: ruby

      cookbook 'chef-ingredient', git: 'https://github.com/chef-cookbooks/chef-ingredient.git', tag: 'v0.12.0'

``named_run_list "NAME", "ITEM1", "ITEM2", ...``
   Specify a named run-list to be used as an alternative to the override run-list. This setting should be used carefully and for specific use cases, like running a small set of recipes to quickly converge configuration for a single application on a host or for one-time setup tasks. For example:

   .. code-block:: ruby

      named_run_list :update_app, "my_app_cookbook::default"
