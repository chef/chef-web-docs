.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. tag dsl_custom_resource_method_property

Use the ``property`` method to define properties for the custom resource. The syntax is:

.. code-block:: ruby

   property :name, ruby_type, default: 'value', parameter: 'values'

where

* ``:name`` is the name of the property
* ``ruby_type`` is the optional Ruby type, such as ``String``, ``Integer``, ``TrueClass``, or ``FalseClass``
* ``default: 'value'`` is the optional default value loaded into the resource
* ``parameter: 'values'`` are optional validation parameters and values

For example, the following properties define ``username`` and ``password`` properties with no default values specified:

.. code-block:: ruby

   property :username, String
   property :password, String

.. end_tag
