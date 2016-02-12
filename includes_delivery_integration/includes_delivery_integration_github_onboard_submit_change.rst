.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For an integrated |github enterprise| project or a project that is hosted at |github com|, users of |chef delivery| should submit changes as follows:

#. The standard |github| process should be followed: clone the desired repo, make and test changes locally, submit the change (create a pull request) which initiates the |chef delivery| review process.

   The |github| webui will display a **Delivery Status** box showing what part of the pipeline the pull request is at. When the pull request has passed the **Verify** stage, |github| will message you in the |github| webui that approval must be manually entered for the pipeline to proceed.

#. When the "Approval Required" message appears, enter ``@delivery approve`` in the comment box.

   The pull request moves to the next stage of the |chef delivery| pipeline, **Build** and **Acceptance**.

#. When the pull request has passed the **Acceptance** stage, |github| will add another message indicating that that the ``deliver`` command must be issued for the pipeline to proceed. When this message appears, enter ``@delivery deliver`` in the comment box.

   The pull request moves to the final three stages, **Union**, **Rehearsal**, and **Delivered**. Other changes in the pipeline that would conflict with a change in the **Union** stage, are blocked from proceeding to the **Acceptance** stage.

   When the final **Delivered** stage is passed, |github| updates the **Delivery Status** at the top of the |github| webui page.
