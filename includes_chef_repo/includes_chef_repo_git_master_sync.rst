.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the following steps to synchronize the master branch. 

#. Run:
    
   .. code-block:: bash

      $ git fetch chef

#. And then run:

   .. code-block:: bash

      $ git rebase chef/master master

   .. note:: Use ``rebase`` instead of ``merge`` to ensure that a linear history is maintained that does not include unnecessary merge commits. ``rebase`` will also rewind, apply, and then reapply commits to the ``master`` branch.
