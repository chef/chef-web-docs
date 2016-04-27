.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To use |curl| to download a package directly, enter the following:

.. code-block:: bash

   $ curl -LOJ 'https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=debian&pv=6&m=x86_64'

To use |gnu wget| to download a package directly, enter the following:

.. code-block:: bash

   $ wget --content-disposition https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=debian&pv=6&m=x86_64
