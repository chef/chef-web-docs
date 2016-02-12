.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ chef generate template . motd -s /etc/motd

Returns:

.. code-block:: bash

   Compiling Cookbooks...
     Recipe: code_generator::template
     * directory[././templates/default] action create
       - create new directory ././templates/default
     * file[././templates/default/motd.erb] action create
       - create new file ././templates/default/motd.erb
       - update content in file ././templates/default/motd.erb 
         from none to 315f5b
