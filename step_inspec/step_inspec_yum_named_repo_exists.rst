.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test if a specific yum repo exists:

.. code-block:: ruby

   describe yum.repo('epel') do
     it { should exist }
     it { should be_enabled }
   end
