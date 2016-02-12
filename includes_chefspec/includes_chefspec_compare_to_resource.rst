.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef spec| behaves like a resource block, with regard to how the name of the block itself may be specified. For example, and for comparison, the |resource file| resource in |chef|:

.. code-block:: ruby

   file '/path/to/file' do
     # stuff
   end

is similar to:

.. code-block:: ruby

   file 'use this file for foo' do
     path '/path/to/file'
   end

where the latter uses the ``path`` attribute to set the path explicitly and the former uses the name of the resource to set the path (because ``path``, when not explictly declared, will default to the name of the resource).

This is similar in |chef spec|. For example:

.. code-block:: ruby

   describe "command('ls -al /')" do
     its(:stdout) { should match /bin/ }
   end

versus:

.. code-block:: ruby

   describe 'use this test to foo' do
     let(:subject) { command('ls -al /') }
     its(:stdout) { should match /bin/ }
   end
