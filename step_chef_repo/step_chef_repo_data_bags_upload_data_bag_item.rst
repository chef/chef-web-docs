.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To upload a data bag item to the |chef server|:

#. Create the data bag on the |chef server|. Enter the following:

   .. code-block:: bash

      $ knife data bag create NAME_OF_DATA_BAG

   where ``NAME_OF_DATA_BAG`` is the name of the data bag to be created.

#. Upload the data bag item from a local directory. For example:

   .. code-block:: bash

      $ knife data bag from file NAME_OF_DATA_BAG NAME_OF_DATA_BAG_ITEM.json

   where ``NAME_OF_DATA_BAG_ITEM`` is the name of the data bag item to be uploaded. Repeat for each data bag item that needs to be uploaded.
   
