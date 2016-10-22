.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``actions`` method is used to define a list of actions that are available to be used in a recipe. Each action must have a corresponding section in a lightweight provider that tells the chef-client what to do when this action is specified in a recipe. The syntax for the ``actions`` method is as follows:

.. code-block:: ruby

   actions :action_name, :action_name

where ``actions`` is a comma-delimited list of individual actions.
