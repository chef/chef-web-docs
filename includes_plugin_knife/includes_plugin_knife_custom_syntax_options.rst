.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Command-line options can be added to a |knife| plugin using the ``option`` method. An option can have a true/false value:

.. code-block:: ruby

   option :true_or_false,
     :short => "-t",
     :long => "--true-or-false",
     :description => "Is this value true? Or is this value false?",
     :boolean => true | false
     :default => true

and it can have a string value:

.. code-block:: ruby

   option :some_type_of_string_value,
     :short => "-s VALUE",
     :long => "--some-type-of-string-value VALUE",
     :description => "This is not a random string value.",
     :default => 47

and can specify code that is run to determine the option's value:

.. code-block:: ruby

   option :tags,
     :short => "-T T=V[,T=V,...]",
     :long => "--tags Tag=Value[,Tag=Value...]",
     :description => "A list of tags associated with the virtual machine",
     :proc => Proc.new { |tags| tags.split(',') }

where the |knife| command allows a comma-separated list of values and the ``:proc`` attribute converts that list of values into an array.

When a user enters ``knife --help``, the description attributes are displayed as part of the help. Using the previous examples, something like the following will be displayed:

.. code-block:: bash

   **EXAMPLE COMMANDS**
   knife example
     -s, --some-type-of-string-value     This is not a random string value.
     -t, --true-or-false                 Is this value true? Or is this value false?
     -T, --tags                          A list of tags associated with the virtual machine.

When |knife| runs the command, the options are parsed from the command-line and make the settings available as a hash that can be used to access the ``config`` method. For example, the following option:

.. code-block:: ruby

   option :omg,
     :short => '-O',
     :long => '--omg',
     :boolean => true,
     :description => "I'm so excited!"

can be used to update the ``run`` method of a class to change its behavior based on the ``config`` flag, similar to the following:

.. code-block:: ruby

   def run
     if config[:omg]
       # Oh yeah, we are pumped.
       puts "OMG HELLO WORLD!!!1!!11"
     else
       # meh
       puts "I am just a boring example."
     end
   end

For a |knife| plugin with the ``--omg`` option, run ``knife example --omg`` to return something like:

.. code-block:: bash

   OMG HELLO WORLD!!!1!!11

or just ``knife example`` to return:

.. code-block:: bash

   I am just a boring example.

