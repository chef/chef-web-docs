.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An |ohai| plugin can be run independently of a |chef client| run. First, ensure that the plugin is located in the ``/plugins`` directory and then use the ``-f`` option when running |ohai| from the command line. For example, a plugin named ``sl_installed`` may look like the following:

.. code-block:: ruby

   provides "sl"
   
   if ::File.exists?("/usr/games/sl")
     sl Mash.new
     sl[:installed] = true
   end

To run that plugin from the command line, use the following command:

.. code-block:: bash

   $ ohai -f sl_installed.rb

The command will return something similar to:

.. code-block:: javascript

   {
     "sl": {
       "installed": true
     }
   }




