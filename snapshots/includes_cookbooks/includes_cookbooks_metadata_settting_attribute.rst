.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example:

.. code-block:: ruby

   attribute 'pets/cat/name',
     :display_name => 'Cat Name',
     :description => 'The name of your cat',
     :choice => \[
       'kitty kitty',
       'peanut',
       'einstein',
       'honey' \],
     :type => 'string',
     :required => 'recommended',
     :recipes => \[ 'cats::eat' \],
     :default => 'kitty kitty'
