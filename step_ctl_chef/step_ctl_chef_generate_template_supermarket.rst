.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To generate a template, run a command similar to:

.. code-block:: bash

   $ chef generate template cookbooks/my_apache2_cookbook index.html

This will create a file named ``index.html.etb`` in the ``/cookbooks/my_apache2_cookbook`` directory. Open the file using a text editor to add content. For example, some HTML:

.. code-block:: html

   <html>
     <body>
       <h1>Chef Love!</h1>
     </body>
   </html>

Save and close the file.
