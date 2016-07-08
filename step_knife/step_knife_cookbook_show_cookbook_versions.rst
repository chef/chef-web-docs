.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To show a list of data about a cookbook using the name of the cookbook and the version, enter:

.. code-block:: bash

   $ knife cookbook show getting-started 0.3.0

to return something like:

.. code-block:: none

   attributes:
     checksum:     fa0fc4abf3f6787aeb5c3c5c35de667c
     name:         default.rb
     path:         attributes/default.rb
     specificity:  default
     url:          https://somelongurlhere.com
   chef_type:      cookbook_version
   cookbook_name:  getting-started
   definitions:    []
   files:          []
   frozen?:        false
   json_class:     Chef::CookbookVersion
   libraries:      []

