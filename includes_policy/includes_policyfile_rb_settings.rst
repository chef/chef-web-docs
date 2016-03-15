.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


A |policyfile rb| file may contain the following settings:

``name "name"``
   Required. The name of the policy. Use a name that reflects the purpose of the machines against which the policy will run.

``run_list "ITEM", "ITEM", ...``
   Required. The run-list the |chef client| will use to apply the policy to one (or more) nodes.
   
``default_source :SOURCE_TYPE, *args``
   The location in which any cookbooks not specified by ``cookbook`` are located. Possible values: ``chef_repo``, ``chef_server``, ``:community``, and ``:supermarket``. Use more than one ``default_source`` to specify more than one location for cookbooks.

   ``default_source :supermarket`` pulls cookbooks from the public |supermarket|.

   ``default_source :supermarket, "https://mysupermarket.example"`` pulls cookbooks from a named private |supermarekt|.

   ``default_source :community`` is an alias for ``:supermarket``.

   ``default_source :chef_repo, "path/to/repo"`` pulls cookbooks from a monolithic cookbook repository. This may be a path to the top-level of a cookbook repository or to the ``/cookbooks`` directory within that repository.

   ``chef_server https://chef-server.example.org/organizations/org_name/universe`` pulls cookbooks from the |chef server| via the ``/universe`` endpoint for the named organization.

   Multiple cookbook sources may be specified. For example from the public |supermarket| and a monolithic repository:

   .. code-block:: ruby

	  default_source :supermarket
	  default_source :chef_repo, "path/to/repo"

   or from both a public and private |supermarket|:

   .. code-block:: ruby

	  default_source :supermarket
	  default_source :supermarket, "https://supermarket.example"

   .. note:: If a run-list or any dependencies require a cookbook that is present in more than one source, be explicit about which source is preferred. This will ensure that a cookbook is always pulled from an expected source. For example, an internally-developed cookbook named ``chef-client`` will conflict with the public ``chef-client`` cookbook that is maintained by |company_name|. To specify a named source for a cookbook:

      .. code-block:: ruby

         default_source :supermarket
         default_source :supermarket, "https://supermarket.example" do |s|
           s.preferred_source_for "chef-client"
         end

      List multiple cookbooks on the same line:

      .. code-block:: ruby

         default_source :supermarket
         default_source :supermarket, "https://supermarket.example" do |s|
           s.preferred_source_for "chef-client", "nginx", "mysql"
         end

``cookbook "NAME" [, "VERSION_CONSTRAINT"] [, SOURCE_OPTIONS]``
   Add cookbooks to the policy, specify a version constraint, or specify an alternate source location, such as |supermarket|.
