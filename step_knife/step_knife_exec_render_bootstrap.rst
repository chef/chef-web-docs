.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To render a bootstrap template without performing a bootstrap operation, use a command similar to:

.. code-block:: bash

   $ knife exec -E 'a = Chef::Knife::Bootstrap.new;a.config[:distro] = "chef-full";puts a.render_template'
