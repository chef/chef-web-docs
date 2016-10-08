.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


When a change to a project is submitted to |delivery|, the ``provision.rb`` does the work of promoting the project to the various nodes in the |delivery| pipeline.

To submit changes to |delivery|, use commands similar to:

#. Update to match the working tree:

   .. code-block:: bash

      $ git add -A

#. Commit the project:

   .. code-block:: bash

      $ git commit -m "Let us deploy our app."

#. Review the changes in |delivery|:

   .. code-block:: bash

      $ delivery review

   This command will open the |delivery| web UI, and then run unit, lint, and syntax tests. After the tests pass, the change may be approved. Once approved, the ``provision.rb`` recipe will deploy the project onto the acceptance stage's infrastructure nodes.

#. After the change has built successfully through the Acceptance stage, approve the changes by clicking the **Deliver** button in the |delivery| web UI. This sends the project to the Union, Rehearsal, and Delivered stages.
