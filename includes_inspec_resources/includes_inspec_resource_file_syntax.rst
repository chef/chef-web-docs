.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``file`` |inspec resource| block declares the location of the file type to be tested, what type that file should be (if required), and then one (or more) matchers:

.. code-block:: ruby

   describe file('path') do
     it { should MATCHER 'value' }
   end

where

* ``('path')`` is the name of the file and/or the path to the file
* ``MATCHER`` is a valid matcher for this |inspec resource|
* ``'value'`` is the value to be tested
