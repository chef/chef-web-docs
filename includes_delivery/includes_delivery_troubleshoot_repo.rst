.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. warning:: This topic is a draft copy and is not hooked into any official topic about Chef Delivery.

Broken Build - Push to GitHub Fails
=====================================================
If a pull request is merged on a public repo that is also being hosted by Chef Delivery, the synchronization between the two repos may be broken.

Symptoms
-----------------------------------------------------
You will usually see an error that looks like:

.. code-block:: bash

   ================================================================================
   Error executing action `push` on resource 'delivery_github[chef/chef-web-docs]'
   ================================================================================
   
   Mixlib::ShellOut::ShellCommandFailed
   ------------------------------------
   Expected process to exit with [0], but received '1'
   ---- Begin output of git push github master ----
   STDOUT: 
   STDERR: To git@github.com:chef/chef-web-docs.git
    ! [rejected]        master -> master (fetch first)
   error: failed to push some refs to 'git@github.com:chef/chef-web-docs.git'
   hint: Updates were rejected because the remote contains work that you do
   hint: not have locally. This is usually caused by another repository pushing
   hint: to the same ref. You may want to first integrate the remote changes
   hint: (e.g., 'git pull ...') before pushing again.
   hint: See the 'Note about fast-forwards' in 'git push --help' for details.
   ---- End output of git push github master ----
   Ran git push github master returned 1


Causes
-----------------------------------------------------
This is almost always caused by someone accepting a PR on GitHub and merging it.

Correcting
-----------------------------------------------------
Use the following steps to correct this error:

Ensure you have a remote for GitHub
+++++++++++++++++++++++++++++++++++++++++++++++++++++

#. Open your Terminal
#. Change directory to the working repo
#. Run: ``git remote -v``

   * If you have a remote that includes ``git@github.com:chef/chef-docs.git`` use that in place of the ``github`` name in future commands
   * If you do not have a remote that includes ``git@github.com:chef/chef-docs.git`` run ``git remote add github git@github.com:chef/chef-docs.git``
#. Ensure all remotes are up to date by running ``git fetch --all``

Getting the changes on GitHub into Delivery
+++++++++++++++++++++++++++++++++++++++++++++++++++++

#. Ensure that you are on the master branch by running ``git checkout master``
#. Make sure that you have the lastest merged changes from delivery by running ``git pull --rebase``
#. Checkout a new branch for pulling in change by running ``git checkout -b BRANCH_NAME``
#. Run ``git pull github master``
#. Run ``delivery review`` to push the change into Delivery.
#. Approve the change as usual.
