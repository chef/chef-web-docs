.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A custom audit resource takes the following form:

.. code-block:: ruby

   class Tiny < Inspec.resource(1)
     name 'tiny'
   end

Custom audit resources are written as a regular |ruby| ``class`` which inherits from ``Inspec.resource``. The number (``1``) specifies the version of |inspec| this custom audit resource targets. As |inspec| evolves, this interface may change and may require a higher version number.
