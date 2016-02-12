.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if the yum repo exists:

.. code-block:: ruby

   describe yum do
     its('repos') { should exist }
   end
