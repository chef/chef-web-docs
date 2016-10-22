.. The contents of this file are included in multiple topics.
.. This file describes a command or a subcommand for Knife.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.

To get a list of nodes using a recipe named ``postfix`` use ``search(:node,"recipe:postfix")``. To get a list of nodes using a sub-recipe named ``delivery``, use chef-shell. For example:

.. code-block:: ruby

   search(:node, 'recipes:postfix\:\:delivery')

.. note:: Single (' ') vs. double (" ") is important. This is because a backslash (\) needs to be included in the string, instead of having Ruby interpret it as an escape.
