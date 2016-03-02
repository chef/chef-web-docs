.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``mount`` |inspec resource| block declares the synchronization settings that should be tested:

.. code-block:: ruby

   describe mount('path') do
     it { should MATCHER 'value' }
   end

where

* ``('path')`` is the path to the mounted directory
* ``MATCHER`` is a valid matcher for this |inspec resource|
* ``'value'`` is the value to be tested
