.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``build-cookbook`` is located in the ``.delivery`` directory in a project and defines how the |delivery| pipeline will build, test, and deploy a project. A ``build-cookbook`` should be initially configured to use the ``delivery-truck`` cookbook as a dependency in all recipes, after which it may be modified as necessary. The ``build-cookbook`` is effectively a wrapper cookbook for the ``delivery-truck`` cookbook.

A build node is configured via two isolated |chef client| runs: First, the ``default.rb`` recipe is run by the |chef client| as the root user, after which the phase-specific recipe is run by the |chef client| as the build user (``dbuild``). For example, during the unit phase the first run is the ``default.rb`` file, and then the second is the ``unit.rb`` file.
