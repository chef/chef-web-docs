.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the PATH environment variable:

.. code-block:: ruby

   describe os_env('PATH') do
     its('split') { should_not include('') }
     its('split') { should_not include('.') }
   end
