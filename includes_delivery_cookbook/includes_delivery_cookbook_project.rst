.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A project cookbook is a cookbook that is located within a project and is used to deploy that project's software onto one (or more) nodes in the |delivery| pipeline. These cookbooks are located in the ``/cookbooks`` directory, which should exist at the root of the project (similar to the ``.delivery`` directory).

The ``default.rb`` recipe in a project cookbook is executed by the |chef client| on infrastructure nodes as the project moves through the |delivery| pipeline. The ``provision.rb`` recipe discovers all ``metadata.rb`` and/or ``metadata.json`` files in the project, including those under the ``/cookbooks`` directory.