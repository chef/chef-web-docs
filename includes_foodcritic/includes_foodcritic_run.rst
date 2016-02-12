.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|foodcritic| is run from the command line, typically against a single cookbook and all of the |ruby| files contained within it:

.. code-block:: bash

   $ foodcritic /path/to/cookbook

|foodcritic| may also be run from the root of an individual cookbook directory:

.. code-block:: bash

   $ foodcritic .

|foodcritic| returns a list, via standard output, that shows the results of the evaluation:

.. code-block:: bash

   FC003: Check whether you are running with chef server before using server-specific features: ./recipes/ip-logger.rb:1
   FC008: Generated cookbook metadata needs updating: ./metadata.rb:2
   FC008: Generated cookbook metadata needs updating: ./metadata.rb:3
