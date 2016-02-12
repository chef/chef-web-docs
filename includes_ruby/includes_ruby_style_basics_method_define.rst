.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Define a method (or a function, if you like):

.. code-block:: ruby
 
   def do_something_useless( first_argument, second_argument)
     puts "You gave me #{first_argument} and #{second_argument}"
   end
   
   do_something_useless( 'apple', 'banana')
   # => "You gave me apple and banana"
   do_something_useless 1, 2
   # => "You gave me 1 and 2"
   # see how the parens are optional if there's no confusion about what to do
