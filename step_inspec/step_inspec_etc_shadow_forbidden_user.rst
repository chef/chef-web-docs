.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for a forbidden user:

.. code-block:: ruby

   describe shadow do
     its('users') { should_not include 'forbidden_user' }
   end
