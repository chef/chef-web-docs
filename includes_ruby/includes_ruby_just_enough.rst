.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Many people who are new to |ruby| often find that it doesn't take very long to get up to speed with the basics. For example, it's useful to know how to check the syntax of a |ruby| file, such as the contents of a cookbook named ``my_cookbook.rb``:

.. code-block:: bash

   $ ruby -c my_cookbook_file.rb

to return:

.. code-block:: bash

   Syntax OK

Here is a quick rundown of some basic |ruby| commands.





Anything after a ``#`` is a comment.

.. code-block:: ruby

   # This is a comment.






Assign a local variable:
    
.. code-block:: ruby

   x = 1






Do some basic arithmetic:
 
.. code-block:: ruby

   1 + 2           # => 3
   2 * 7           # => 14
   5 / 2           # => 2   (because both arguments are whole numbers)
   5 / 2.0         # => 2.5 (because one of the numbers had a decimal place)
   1 + (2 * 3)     # => 7   (you can use parens to group expressions)






Work with strings:

.. code-block:: ruby

   'single quoted' # => "single quoted"
   "double quoted" # => "double quoted"
   'It\'s alive'   # => "It's alive!"
   "1 + 2 = 5"     # => "1 + 2 = 5" (numbers surrounded by quotes may exhibit string-like behavior)






Embed |ruby| in a string:

.. code-block:: ruby

   x = 'Bob'
   'Hi, #{x}'      # => "Hi, Bob"
   'Hello, #{x}'   # => "Hello, \#{x}" Notice that single quotes don't work with #{}






Work with basic truths:

.. code-block:: ruby

   true            # => true
   false           # => false
   nil             # => nil
   1 == 1          # => true ( == tests for equality )
   1 == true       # => false ( == tests for equality )






Work with basic untruths (``!`` means not!):

.. code-block:: ruby

   !true           # => false
   !false          # => true
   !nil            # => true
   1 != 2          # => true (1 is not equal to 2)
   1 != 1          # => false (1 is not not equal to itself)






Convert something to either true or false (``!!`` means not not!!):

.. code-block:: ruby

   !!true          # => true
   !!false         # => false
   !!nil           # => false (when pressed, nil is false)
   !!0             # => true (zero is NOT false).






Create lists using arrays:

.. code-block:: ruby

   x = ['a', 'b', 'c'] # => ["a", "b", "c"]
   x[0]                # => "a" (zero is the first index)
   x.first             # => "a" (see?)
   x.last              # => "c"
   x + ['d']           # => ["a", "b", "c", "d"]
   x                   # => ["a", "b", "c"] ( x is unchanged)
   x = x + ['d']       # => ["a", "b", "c", "d"]
   x                   # => ["a", "b", "c", "d"]







A |ruby hash| is a list with keys and values. Sometimes they don't have a set order:

.. code-block:: ruby

   h = {
   'first_name' => 'Bob',
   'last_name'  => 'Jones'
   }

And sometimes they do. For example, first name then last name:

.. code-block:: ruby

   h.keys              # => ["first_name", "last_name"]
   h['first_name']     # => "Bob"
   h['last_name']      # => "Jones"
   h['age'] = 23
   h.keys              # => ["first_name", "age", "last_name"]
   h.values            # => ["Jones", "Bob", 23]






Use |perl|-style regular expressions:

.. code-block:: ruby

   'I believe'  =~ /I/                       # => 0 (matches at the first character)
   'I believe'  =~ /lie/                     # => 4 (matches at the 5th character)
   'I am human' =~ /bacon/                   # => nil (no match - bacon comes from pigs)
   'I am human' !~ /bacon/                   # => true (correct, no bacon here)
   /give me a ([0-9]+)/ =~ 'give me a 7'     # => 0 (matched)






Use conditions! For example, an ``if`` statement

.. code-block:: ruby

   if false
     # this won't happen
   elsif nil
     # this won't either
   else
     # code here will run though
   end

or a ``case`` statement:

.. code-block:: ruby

   x = 'dog'
   case x
   when 'fish'
    # this won't happen
   when 'dog', 'cat', 'monkey'
     # this will run
   else
     # the else is an optional catch-all
   end





Define a method (or a function, if you like):

.. code-block:: ruby
 
   def do_something_useless( first_argument, second_argument)
     puts 'You gave me #{first_argument} and #{second_argument}'
   end
   
   do_something_useless( 'apple', 'banana')
   # => "You gave me apple and banana"
   do_something_useless 1, 2
   # => "You gave me 1 and 2"
   # see how the parens are optional if there's no confusion about what to do



Call a method on something with ``.method_name()``:

.. code-block:: ruby

   x = 'My String'
   x.split(' ')            # => ["My", "String"]
   x.split(' ').join(', ') # => "My, String"



Use the |ruby| ``File`` class in a recipe. Because |chef| has the |resource file| resource, use ``::File`` to use the |ruby| ``File`` class. For example:

.. code-block:: ruby

   execute 'apt-get-update' do
     command 'apt-get update'
     ignore_failure true
     only_if { apt_installed? }
     not_if { ::File.exist?('/var/lib/apt/periodic/update-success-stamp') }
   end



Use ``:include`` to include another |ruby| class. For example:

.. code-block:: ruby

   ::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

In non-|chef| |ruby|, the syntax is ``include`` (without the ``:`` prefix), but without the ``:`` prefix the |chef client| will try to find a provider named ``include``. Using the ``:`` prefix tells the |chef client| to look for the specified class that follows.



To learn more about |ruby|, see the following:

* |url ruby_lang_org|
* |url ruby_power_of_chef|
* |url codeacademy|
* |url ruby_doc_org|



