.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Cookbook testing uses `foodcritic <http://foodcritic.io/>`_, `rubocop <https://github.com/bbatsov/rubocop>`_, and `Rake <https://github.com/ruby/rake>`_, all wrapped up in the `ChefDK <https://downloads.chef.io/chef-dk/>`_ to run tests. Tests are defined using a |rakefile| with |jenkins| gates.

To run tests from the cookbook directory:

.. code-block:: bash

   $ # Install the ChefDK first
   $ chef exec rake
