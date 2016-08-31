.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If the ``project.toml`` file contains:

.. code-block:: ruby

   unit = "rspec spec/"
   lint = "cookstyle"
   syntax = "foodcritic . --exclude spec -f any -t \"~FC064\" -t \"~FC065\""
   provision = "chef exec kitchen create"
   deploy = "chef exec kitchen converge"
   smoke = "chef exec kitchen verify"
   cleanup = "chef exec kitchen destroy"

the command

.. code-block:: bash

   $ delivery local syntax

will run |foodcritic| and execute the following command locally:

.. code-block:: bash

   $ foodcritic . --exclude spec -f any -t \"~FC064\" -t \"~FC065\"
