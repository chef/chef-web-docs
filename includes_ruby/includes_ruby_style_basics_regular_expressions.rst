.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use |perl|-style regular expressions:

.. code-block:: ruby

   'I believe'  =~ /I/                       # => 0 (matches at the first character)
   'I believe'  =~ /lie/                     # => 4 (matches at the 5th character)
   'I am human' =~ /bacon/                   # => nil (no match - bacon comes from pigs)
   'I am human' !~ /bacon/                   # => true (correct, no bacon here)
   /give me a ([0-9]+)/ =~ 'give me a 7'     # => 0 (matched)
