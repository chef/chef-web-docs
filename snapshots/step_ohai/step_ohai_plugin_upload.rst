.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To upload the ``ohai`` cookbook to the Chef server, use knife and run the following:

.. code-block:: bash

   knife cookbook upload ohai

to return something similar to:

.. code-block:: bash

   INFO: Saving ohai
   INFO: Validating ruby files
   INFO: Validating templates
   INFO: Syntax OK
   INFO: Generating Metadata
   INFO: Uploading files
   [ ... SNIP ... ]
