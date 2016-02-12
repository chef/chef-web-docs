.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the |resource ruby_block| resource to execute |ruby| code during a |chef client| run. |ruby| code in the ``ruby_block`` resource is evaluated with other resources during convergence, whereas |ruby| code outside of a ``ruby_block`` resource is evaluated before other resources, as the recipe is compiled.
