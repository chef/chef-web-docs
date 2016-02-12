.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The class name declares a plugin as a subclass of both ``Knife`` and ``Chef``. For example:

.. code-block:: ruby
   
   class SubclassName < Chef::Knife
   
where ``SubclassName`` is the class name used by this plugin. The capitalization of this name is important. For example, ``OMG`` would have a |knife| command of ``knife o m g``, whereas ``Omg`` would have a |knife| command of ``knife omg``. Use the capitalization pattern to define the word grouping that best makes sense for the plugin.

A plugin can override an existing |knife| subcommand by using the same class name as the existing subcommand. For example, to override the current functionality of ``knife cookbook upload``, use the following class name:

.. code-block:: ruby

   class CookbookUpload < Chef::Knife

