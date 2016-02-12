.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|rubocop| is run from the command line, typically against a single cookbook and all of the |ruby| files contained within it:

.. code-block:: bash

   $ rubocop /path/to/cookbook

|rubocop| may also be run from the root of an individual cookbook directory:

.. code-block:: bash

   $ rubocop .

|rubocop| returns a list, via standard output, that shows the results of the evaluation:

.. code-block:: bash

   Inspecting 8 files
   CWCWCCCC
   
   Offences:
   
   cookbooks/apache/attributes/default.rb:1:1: C: Missing utf-8 encoding comment.
   default["apache"]["indexfile"] = "index1.html"
   ^
   cookbooks/apache/attributes/default.rb:1:9: C: Prefer single-quoted strings when you don't
   need string interpolation or special symbols.
   default["apache"]["indexfile"] = "index1.html"
           ^^^^^^^^
   cookbooks/apache/attributes/default.rb:1:19: C: Prefer single-quoted strings when you
   don't need string interpolation or special symbols.
   default["apache"]["indexfile"] = "index1.html"
                     ^^^^^^^^^^^
