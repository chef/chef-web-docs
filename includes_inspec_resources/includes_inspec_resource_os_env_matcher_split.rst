.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``split`` splits the content with the ``:``` deliminator:

.. code-block:: ruby

   its('split') { should include ('') }

or:

.. code-block:: ruby

   its('split') { should_not include ('.') }

Use ``-1`` to test for cases where there is a trailing colon (``:``), such as ``dir1::dir2:``:

.. code-block:: ruby

   its('split') { should include ('-1') }
