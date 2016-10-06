.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If you are using Chef 12.13 or later, a cookbook may be shared to the private |supermarket| using the ``knife cookbook site``` commands.

.. code-block:: bash

   $ knife cookbook site share 'my_cookbook'

If you are using Chef 12.12 or lower, a cookbook may be shared to the private |supermarket| using the ``knife supermarket`` command. Run the following command:

.. code-block:: bash

   $ knife supermarket share 'my_cookbook'
