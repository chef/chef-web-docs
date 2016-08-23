.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``vbscript`` |inspec resource| block tests the output of a |vbscript| on the |windows| platform:

.. code-block:: ruby

   describe vbscript('script_name') do
     its('stdout') { should eq 'output' }
   end

where

* ``'script_name'`` is the name of the |vbscript| to test
* ``('output')`` is the expected output of the |vbscript|
