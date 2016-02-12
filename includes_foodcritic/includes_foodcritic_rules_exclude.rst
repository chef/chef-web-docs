.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run the following command to exclude a |foodcritic| rule:

.. code-block:: bash

   $ foodcritic . --tags ~RULE

For example, to exclude rule ``FC003``:

.. code-block:: bash

   $ foodcritic . --tags ~FC003
