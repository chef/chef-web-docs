.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Commits to the Chef repositories should never be made against the master branch. Use a topic branch instead. A topic branch solves a single and unique problem and often maps closely to an issue being tracked in the repository. For example, a topic branch to add support for a new init system or a topic branch to resolve a bug that occurs in a specific version of CentOS. Ideally, a topic branch is named in a way that associates it closely with the issue it is attempting to resolve. This helps ensure that others may easily find it.

Use the following steps to create a topic branch:

#. For a brand new clone of the Chef repository (that was created using the steps listed earlier), fetch the ``opscode`` remote:

   .. code-block:: bash

      $ git fetch chef

#. Create an appropriately named tracking branch:

   .. code-block:: bash

      $ git checkout --track -b CHEF-XX chef/master

   Set up a topic branch to track ``chef/master``. This allows commits to be easily rebased prior to merging.

#. Make your changes, and then commit them:

   .. code-block:: bash

      $ git status

#. And then run:

   .. code-block:: bash

      $ git commit <filespec>

#. Rebase the commits against ``chef/master``. After work in the topic branch is finished, rebase these commits against the upstream master. Do this manually with ``git fetch`` followed by a ``git rebase`` or use ``git pull --rebase``.

   git will let you know if there are any problems. In the event of problems, fix them as directed, and then mark as fixed with a ``git add``, and then continue the rebase process using ``git rebase --continue``.

   For example:

   .. code-block:: bash

      $ git fetch chef

   followed by:

   .. code-block:: bash

      $ git rebase chef/master CHEF-XX

   Or:

   .. code-block:: bash

      $ git pull --rebase

#. Push the local topic branch to GitHub:

   .. code-block:: bash

      $ git push origin CHEF-XX

#. Send a GitHub pull request for the changes, and then update the Chef ticket with the appropriate information.
