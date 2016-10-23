.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Many text editors leave files behind. To prevent these files from being uploaded to the Chef server, add an entry to the chefignore file. For Emacs, do something like:

.. code-block:: none

   *~

and for vim, do something like:

.. code-block:: none

   *.sw[a-z]
