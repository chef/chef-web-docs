To set up a second pipeline, there is an assumption that the branch that will become the second pipeline exists in your local project.

#. Push that branch to the Chef Automate Server ``git push delivery $BRANCH_NAME``
#. Navigate to the project's page (``e/$ENT_NAME/#/organizations/$ORG_NAME/projects/$PROJECT_NAME``) in the Chef Automate web UI and click on the ``Pipelines`` tab.
#. Click on ``Add A New Pipeline`` on the top of the page.
#. Give the new pipeline a descriptive name and input the base branch.

To make a pipeline other than ``master`` the default for a single project, create a ``cli.toml`` file in the ``/.delivery`` directory in the root of the project that includes ``pipeline = "$BRANCH_NAME"``. Now, all delivery-cli commands that target a pipeline will target $BRANCH_NAME.

If you wish to target a pipeline that is NOT the defined default, add the ``--pipeline=$BRANCH_NAME`` flag to the delivery-cli command.

Example:

``delivery review --pipeline=$BRANCH_NAME``

The commands that take this flag are:

* ``delivery init``
* ``delivery review``
* ``delivery diff``
* ``delivery job``
* ``delivery setup``
