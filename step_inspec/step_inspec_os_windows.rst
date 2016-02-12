.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for Microsoft Windows:

.. code-block:: ruby

   describe os['family'] do
     it { should eq 'windows' }
   end
