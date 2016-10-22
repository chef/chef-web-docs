.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The syntax of RSpec-based tests should follow the natural language descriptions of RSpec itself. The tests themselves should create an English-like sentence: "The sum of one plus one equals two, and not three." For example:

.. code-block:: ruby

   describe '1 plus 1' do
     it 'equals 2' do
       a = 1
       b = 1
       sum = a + b
       expect(sum).to eq(2)
       expect(sum).not_to eq(3)
     end
   end

where:

* ``describe`` creates the testing scenario: ``1 plus 1``
* ``it`` is a block that defines a list of parameters to test, along with parameters that define the expected outcome
* ``describe`` and ``it`` should have human readable descriptions: "one plus one equals two"
* ``a``, ``b``, and ``sum`` define the testing scenario: ``a`` equals one, ``b`` equals one, the ``sum`` of one plus equals two
* ``expect()`` defines the expectation: the sum of one plus one equals two---``expect(sum).to eq(2)``---and does not equal three--``expect(sum).not_to eq(3)``
* ``.to`` tests the results of the test for true; ``.not_to`` tests the result of the test for false; a test passes when the results of the test are true
