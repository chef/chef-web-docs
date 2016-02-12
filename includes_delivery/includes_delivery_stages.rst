.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

All |chef delivery| pipelines include these stages:

.. list-table::
   :widths: 100 100 400
   :header-rows: 1

   * - Stage
     - Phases
     - Description
   * - **Verify**
     - Unit, Lint, Syntax
     - When a new change is submitted, the **Verify** stage kicks off a number of recipes for basic change testing on the |chef delivery| build nodes.

       A change exits the **Verify** stage and advances to the next stage of the pipeline when a user with **Reviewer** or **Admin** permissions approves it. The approval can be done by using the **Approve** button in the web UI, the |chef delivery_cli| CLI ``delivery job`` command, or by entering ``@delivery approve`` in the comment section within |github|, if integrated with |chef delivery|. When approved, the change is merged to the base pipeline, usually "master".

   * - **Build**
     - Unit, Lint, Syntax, Quality, Security, Publish
     - In the **Build** stage additional testing, plus optional security and quality testing, is run. Unit, Lint, and Syntax recipes are re-run in case something broke after the merge to the base "master" pipeline. Pinnings are set that prevent changes from affecting current infrastructure until the change is instantiated in the final **Delivered** stage. Lastly, the Publish phase pushes artifacts to locations based on your publish recipe. The ``delivery-truck`` build cookbook offers convenient helpers for that and can be controlled with settings in ``.delivery/config.json``. For non-cookbook applications, you specify where the artifacts are uploaded and how to manage the upload in the Publish phase. A successful **Build** stage is automatically followed by the **Acceptance** stage.
   * - **Acceptance**
     - Provision, Deploy, Smoke, Functional
     - In the **Acceptance** stage, the result of your build stage (artifact, cookbook, etc.) is deployed and tested in an isolated environment.

       A change exits the **Acceptance** stage and advances to the next stage of the pipeline when a user with **Shipper** or **Admin** permissions approves it. The approval can be done by using the **Deliver** button in the web UI, the |chef delivery_cli| CLI ``delivery job`` command, or by entering ``@delivery deliver`` in the comment section within |github|, if integrated with |chef delivery|.

   * - **Union**
     - Provision, Deploy, Smoke, Functional     
     - In the **Union** stage your build product is deployed and tested in an environment with all its upstream and downstream dependencies. For example, a change in the **Acceptance** stage that conflicts with a change in the **Union** stage will not be allowed to pass **Acceptance**. A successful **Union** stage is automatically followed by the **Rehearsal** stage. 
   * - **Rehearsal**
     - Provision, Deploy, Smoke, Functional     
     - In the **Rehearsal** stage your build product is deployed and tested in an environment with all its upstream and downstream dependencies a second time. A successful **Rehearsal** stage is automatically followed by the **Delivered** stage. 
   * - **Delivered**
     - Provision, Deploy, Smoke, Functional     
     - In the **Delivered** stage pinnings are removed and your build product (artifact) is deployed to your user-facing environment. 
