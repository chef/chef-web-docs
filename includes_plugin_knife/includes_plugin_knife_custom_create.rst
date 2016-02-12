.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |knife| command is a |ruby| class that inherits from the ``Chef::Knife`` class.  A |knife| command is run by calling the ``run`` method on an instance of the command class. For example:

.. code-block:: ruby

   module MyKnifePlugins
     class HelloWorld < Chef::Knife
 
       def run
         puts "Hello, World!"
       end
     end
   end

and is run from the command line using:

.. code-block:: bash

   $ knife hello world


