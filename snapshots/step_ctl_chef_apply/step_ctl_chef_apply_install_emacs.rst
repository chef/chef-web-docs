.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ sudo chef-apply -e "package 'emacs'"

Returns:

.. code-block:: bash

   Recipe: (chef-apply cookbook)::(chef-apply recipe)
     * package[emacs] action install
       - install version 23.1-25.el6 of package emacs
