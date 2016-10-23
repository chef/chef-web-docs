.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file documents specifc behavior related to the -j option in the chef-client, chef-solo, and chef-shell executables.

Use this option to define a ``run_list`` object. For example, a JSON file similar to:

.. code-block:: javascript

   "run_list": [
     "recipe[base]",
     "recipe[foo]",
     "recipe[bar]",
     "role[webserver]"
   ],

may be used by running ``chef-client -j path/to/file.json``.

In certain situations this option may be used to update ``normal`` attributes.
