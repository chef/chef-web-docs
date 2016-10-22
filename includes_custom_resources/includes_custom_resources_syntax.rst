.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A custom resource is defined as a |ruby| file and is located in a cookbook's ``/resources`` directory. This file

* Declares the properties of the custom resource
* Defines each action the custom resource may take

The syntax for a basic custom resource utilizing built-in chef resources is. For example:

.. code-block:: ruby

   property :name, RubyType, default: 'value'

   action :name do
    # built-in Chef resources
   end

   action :name do
    # built-in Chef resources
   end

where the first action listed is the default action.
