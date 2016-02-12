.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``--tree`` option to view the results with structure:

.. code-block::  bash

   $ knife deps roles/webserver.json

to return something like:

.. code-block:: bash

   roles/webserver.json
     roles/base.json
       cookbooks/github
         cookbooks/git
       cookbooks/users
     cookbooks/apache2
