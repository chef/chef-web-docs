.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To show the details for a cookbook version, run a command similar to:

.. code-block:: bash

   $ knife supermarket show mysql 0.10.0

where ``mysql`` is the cookbook and ``0.10.0`` is the cookbook version. This will return something similar to:

.. code-block:: bash

   average_rating:
   cookbook:          http://cookbooks.opscode.com/api/v1/cookbooks/mysql
   file:              http://cookbooks.opscode.com/api/v1/cookbooks/mysql/versions/0.10.0/download
   license:           Apache 2.0
   tarball_file_size: 7010
   version:           0.10.0
