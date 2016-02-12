.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use a |rubocop_todo yml| file to capture the current state of all evaluations, and then write them to a file. This allows evaluations to reviewed one at a time. Disable any evaluations that are unhelpful, and then address the ones that are.

To generate the |rubocop_todo yml| file, run the following command:

.. code-block:: bash

   $ rubocop --auto-gen-config

.. note:: Rename this file to |rubocop yml| to adopt this evaluation state as the standard. Include this file in the |rubocop yml| file by adding ``inherit_from: .rubocop_todo.yml`` to the top of the |rubocop yml| file.
