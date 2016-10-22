.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


RSpec-based tests may contain ``let`` statements within a ``context`` block. Use ``let`` statements to create a symbol, assign it a value, and then use it elsewhere in the ``context`` block. For example:

.. code-block:: ruby

   describe 'Math' do
     context 'when adding 1 + 1' do
       let(:sum) { 1 + 1 }
   
       it 'equals 2' do
         expect(sum).to eq(2)
       end
     end
   
     context 'when adding 2 + 2' do
       let(:sum) do
         2 + 2
       end
   
       it 'equals 4' do
         expect(sum).to eq(4)
       end
     end
   end

where:

* The first ``let`` statement creates the ``:sum`` symbol, and then assigns it the value of one plus one. The ``expect`` statement later in the test uses ``sum`` to test that one plus one equals two
* The second ``let`` statement creates the ``:sum`` symbol, and then assigns it the value of two plus two. The ``expect`` statement later in the test uses ``sum`` to test that two plus two equals four
