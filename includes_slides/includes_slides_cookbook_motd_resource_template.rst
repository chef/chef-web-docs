.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the |resource template| resource when a template is stored a cookbook's ``/templates`` directory:

.. code-block:: python
       
   motd
      ├── Berksfile
      ├── README.md
      ├── chefignore
      ├── metadata.rb
      ├── recipes
      │   └── default.rb
      └── templates
          └── default
              └── motd.erb

This template is then rendered to create a file:

.. code-block:: ruby
       
   Property of <%= @company_name %>
