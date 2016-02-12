.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |knife| plugin can also take command-line arguments that are not specified using the ``option`` flag, for example: ``knife node show NODE``. These arguments are added using the ``name_args`` method. For example:

.. code-block:: ruby

   banner "knife hello world WHO"
 
   def run
     unless name_args.size == 1
       puts "You need to say hello to someone!"
       show_usage
       exit 1
     end
    
     who = name_args.first
   
     if config[:omg]
       puts "OMG HELLO #{who.upcase}!!!1!!11"
     else
       puts "Hello, #{who.capitalize}!"
     end
   end

where

* ``unless name_args.size == 1`` is used to check the number of arguments given; the command should fail if the input does not make sense
* ``who = name_args.first`` is used to access arguments using ``name_args``
* ``show_usage`` is used to display the correct usage before exiting (if the command fails)

For example, the following command:

.. code-block:: bash

    $ knife hello world

will return:

.. code-block:: bash

   You need to say hello to someone!
   USAGE: knife hello world WHO

the following command:

.. code-block:: bash

   $ knife hello world chefs

will return:

.. code-block:: bash

   Hello, Chefs!

and the following command:

.. code-block:: bash

   $ knife hello world chefs --omg

will return:

.. code-block:: bash

   OMG HELLO CHEFS!!!1!!11

