.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``os_env`` |inspec resource| block declares an environment variable, and then declares its value:

.. code-block:: ruby

   describe os_env('VARIABLE') do
     its('matcher') { should eq 1 }
   end

where

* ``('VARIABLE')`` must specify an environment variable, such as ``PATH``
* ``matcher`` is a valid matcher for this |inspec resource|
