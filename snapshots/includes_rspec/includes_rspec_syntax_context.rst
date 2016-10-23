.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


RSpec-based tests may contain ``context`` blocks. Use ``context`` blocks within ``describe`` blocks to define "tests within tests". Each ``context`` block is tested individually. All ``context`` blocks within a ``describe`` block must be true for the test to pass. For example:

.. code-block:: ruby

   describe 'math' do
     context 'when adding 1 + 1' do
       it 'equals 2' do
         expect(sum).to eq(2)
       end
     end
   
     context 'when adding 2 + 2' do
       it 'equals 4' do
         expect(sum).to eq(4)
       end
     end
   end

where each ``context`` block describes a different testing scenario: "The sum of one plus one to equal two, and also the sum of two plus two to equal four." A ``context`` block is useful to handle platform-specific scenarios. For example, "When on platform A, test for foo; when on platform B, test for bar." For example:

.. code-block:: ruby

   describe 'cookbook_name::recipe_name' do
   
     context 'when on Debian' do
       it 'equals 2' do
         a = 1
         b = 1
         sum = a + b
         expect(sum).to eq(2)
       end
     end
   
     context 'when on Ubuntu' do
       it 'equals 2' do
         expect(1 + 1).to eq(2)
       end
     end
   
     context 'when on Windows' do
       it 'equals 3' do
         expect(1 + 2).to eq(3)
       end
     end
   
   end
