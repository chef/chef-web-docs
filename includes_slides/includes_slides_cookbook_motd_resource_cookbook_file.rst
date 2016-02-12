.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the |resource cookbook_file| resource for a file that is stored a cookbook's ``/files`` directory:

.. code-block:: python

   motd
      ├── Berksfile
      ├── README.md
      ├── chefignore
      ├── files
      │   └── default
      │       └── motd
      ├── metadata.rb
      ├── recipes
      └── default.rb
