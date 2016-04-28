.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The wrapper cookbook around the ``supermarket-omnibus-cookbook`` cookbook must be uploaded to the |chef server|, along with any cookbooks against which the ``supermarket-omnibus-cookbook`` cookbook has dependencies.

To upload the cookbooks necessary to install |supermarket|, do the following:

#. Install |berkshelf|:

   .. code-block:: bash

      $ berks install

#. Change directories into ``~/.berkshelf/cookbooks``:

   .. code-block:: bash

      $ cd ~/.berkshelf/cookbooks

#. Upload all cookbooks to the |chef server|:

   .. code-block:: bash

      $ knife cookbook upload -a

#. Change directories into the location in which the wrapper cookbook was created:

   .. code-block:: bash

      $ cd path/to/wrapper/cookbook/

#. Upload the wrapper cookbook to the |chef server|:

   .. code-block:: bash

      $ knife cookbook upload -a
