.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Values for the ``source`` attribute are internally stored as an array starting with the 11.0.0 version of the |chef client|. (Previous versions of the |chef client|---10.x and earlier---store these values as a string.) This update is a breaking change between these major versions of the |chef client|. Any library code that subclasses the |resource remote_file| resource in the 10.x version of the |chef client| may require updates for the 11.x version. Alternatively, the provider for the |resource remote_file| resource may be updated to properly handle the case that the ``source`` parameter is an array. And, also alternatively, the array values may be converted back into a string in the resource itself by using code similar to the following:

.. code-block:: ruby

   def source(args=nil)
     set_or_return(:source, args, :kind_of=>String)
   end

   def after_created
     true
   end


