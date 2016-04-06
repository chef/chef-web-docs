.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Some projects need more than one project cookbook. Put as many cookbooks as necessary under the ``/cookbooks`` directory, which is located at the root of a project.

Each cookbook under the ``/cookbooks`` directory must have a valid cookbook structure. If the cookbook does not have a ``metadata.rb`` or ``metadata.json`` file it will not be discovered by the ``provision.rb`` recipe; consequently, that cookbook will not be used to configure nodes in the |delivery| pipeline.

The ``default.rb`` recipes in all project cookbooks are executed by the |chef client| on infrastructure nodes as the project moves through the |delivery| pipeline. The ``default.rb`` recipe in the ``build-cookbook`` is run first, and then each ``default.rb`` recipe in each cookbook under ``/cookbooks`` is run (in alphabetical order, by cookbook name).
