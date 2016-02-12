.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The contents of build cookbooks can vary widely, depending on the project. 

For an example of a build cookbook, see the tutorial `Automating your Workflow with Chef Delivery <https://learn.chef.io/tutorials/#build-a-delivery-pipeline>`__.

.. note:: When |chef delivery| executes a phase, it runs two |chef client| runs in isolation. The first runs as ``root`` and executes the default recipe. The second runs as the build user (``dbuild``) and executes the phase recipe.
