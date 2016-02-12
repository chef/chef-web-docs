.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The change submission process is the familiar |git| process: 

#. You must be onboarded to |chef delivery|, a task likely to be done by your sysadmin. Once your |github| username is linked to your |chef delivery| username and you have properly set up a workstation.
#. Clone the |github| repo to which changes are submitted. Be sure you have the right permissions.
#. Workflow for making changes:

   #. Create feature branch: ``git checkout -b <feature_branch_name>``.
   #. Make changes.
   #. Build and test the changes locally.
   #. Check status: ``git status``.
   #. Add changes: ``git add .`` or ``git add <changed file>``.
   #. Commit changes: ``git commit -m <message>``.
   #. Submit changes to delivery: ``delivery review``. The |chef delivery| web UI will open to show your change in the pipeline. Note, you may need to be on a VPN to access |chef delivery|.
   #. When the change has passed **Verify**, approve change, or get someone to, by clicking **Approve** in |chef delivery| web UI. Doing this marks you as the "Signed-off-by" user of the change.
   #. After change is approved, sync your local branch to master: ``git checkout master`` and then ``git pull delivery master``.
   #. Press the **Deliver** button in the |chef delivery| web UI when it is active. Note that your change may be superseded by another change. That is, if another change in the pipeline is approved (merged to master) and then your change is approved, when **Deliver** is pressed, both changes are moved to the final three stages. This goes for all approved changes in the pipeline. Also note that changes that would conflict with approved changes will not be moved past **Acceptance**.
 