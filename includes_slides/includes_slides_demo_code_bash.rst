.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ some -bash "command"

For example:

.. code-block:: bash

   $ sudo chef-apply hello.rb

Returns:

.. code-block:: bash

   Recipe: (chef-apply cookbook)::(chef-apply recipe)
     * file[hello.txt] action create (up to date)
