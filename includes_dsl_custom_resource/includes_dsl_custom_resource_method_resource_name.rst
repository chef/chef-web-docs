.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

By default, the custom resource name is inferred from the name of the cookbook and the name of the resource file, separated by an underscore (``_``), and with non-alphanumeric characters replaced with underscores. To give it a different name, use the ``resource_name`` method at the top of the file. For example:

.. code-block:: ruby

   resource_name :custom_name

where ``:custom_name`` is the resource name as it may be used in a recipe.
