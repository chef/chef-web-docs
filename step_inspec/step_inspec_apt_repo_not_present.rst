.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify that a repository is not present:

.. code-block:: ruby

   describe apt('ubuntu-wine/ppa') do
     it { should_not exist }
     it { should_not be_enabled }
   end
