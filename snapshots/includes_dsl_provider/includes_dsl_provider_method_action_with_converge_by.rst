.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``action`` method is used to define the steps that will be taken for each of the possible actions defined by the custom resource. Each action must be defined in separate ``action`` blocks within the same file. The syntax for the ``action`` method is as follows:

.. code-block:: ruby

   action :action_name do
     # Chef resources or Ruby converge_by blocks
   end

where:

* ``:action_name`` corresponds to an action defined by a custom resource
* ``converge_by`` tells the chef-client which message to provide when the chef-client is run in why-run mode
