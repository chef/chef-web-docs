.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To create a cookbook named "my_cookbook" with copyright, email, license, and readme format options specified, enter:

.. code-block:: bash

   $ knife cookbook create my_cookbook -C "My Name" -m "my@email.com" -I apachev2 -r md

to return something like:

.. code-block:: bash

   ** Creating cookbook my_cookbook
   ** Creating README for cookbook: my_cookbook
   ** Creating metadata for cookbook: my_cookbook
