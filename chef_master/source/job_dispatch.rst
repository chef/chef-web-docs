=====================================================
Job Dispatch
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/job_dispatch.rst>`__

.. tag runner_summary

Chef Automate's workflow engine automatically creates phase jobs as project code is promoted through the phases of a workflow pipeline. These phase jobs are dispatched to special nodes, called runners, that automatically execute each job as it is created.

.. end_tag

Recent Changes
--------------

Chef Automate release 0.6.0 includes a new SSH-based job execution layer. Under the new system, you can more easily:

- Add and remove runners
- Cancel running phase jobs
- View the queue of jobs in the Chef Automate UI
- View and test runner status via the Chef Automate UI

Known Issues
--------------

.. warning:: If you need to run windows build and infrastructure nodes, stop now. Job Dispatch is currently incompatible with Windows. If you are running only linux build/infrastructure nodes, please continue.

   By default, Job Dispatch nodes cannot be used to deploy builds on infrastructure nodes. Infrastructure nodes are usually used as part of testing, but may not be present in your environment. Infrastructure nodes are not build nodes. Currently, as of Automate 0.6.7, Job Dispatch can only be used directly against build nodes.

   * One typical environment would be an Acceptance environment on which both automated and manual testing of new code might happen against a production-like environment. The deploy previous to automated testing will be triggered by a build node triggering a Push Jobs client on the infrastructure node. This will cause the infrastructure node's chef-client to run on the infrastructure node, thus deploying the build. The delivery-truck cookbook's deploy recipe in https://github.com/chef-cookbooks/delivery-truck/blob/master/recipes/deploy.rb#L34 currently assumes that a Push Jobs client will be available on infrastructure nodes for the deploy phase. This behavior is the default, but can be customized to potentially trigger the chef-client run through means other than a Push Jobs job, such as Job Dispatch.
     
   Until this issue is fixed, either Push Jobs alone should be used across the Automate installation, or a combination of Job Dispatch should be used against builder nodes, and Push Jobs against infrastructure nodes respectively.


Terms
=====================================================

``phase job``
   A job corresponding to a phase (for example, your build cookbook's unit recipe).

``runner``
   Any node that a job can be dispatched to. Usually refers to a node that will run a phase job.

Managing Runners
=====================================================

Adding a Runner
-----------------------------------------------------

You can add a new runner via automate-ctl from your Chef Automate server. Log in to your Chef Automate server and run the :ref:`install-runner` command.

After the :ref:`install-runner` command succeeds, the new runner should show up in the UI under ``Workflow -> Runners -> Manage Runners``. If you see it there, click the ``Test`` button. That will test an ssh connection to your runner to verify that jobs can be dispatched to it. If there are any issues, you should get an error in the UI.

Remove a Runner
-----------------------------------------------------

To remove a runner, you will need to use the :ref:`delivery-cli-api` command.

To see a list of runners:

.. code-block:: bash

   $ delivery api get runners

To delete a runner:

.. code-block:: bash

   $ delivery api delete runners/<runner_hostname>

For a full list of additional options, refer to the :ref:`delivery-cli-api` documentation.

Configuring Chef Automate Projects for Job Dispatch
=====================================================

To setup a Chef Automate project to use the SSH-based job dispatch system, you must edit its :doc:`config.json </config_json_delivery>`.

At the bare minimum, you must set the version to v2:

.. code-block:: javascript

   {
      ...
      "job_dispatch": {
         "version": "v2"
      },
      ...
   }

and remove the ``build_nodes`` setting from ``config.json``.

.. code-block:: none

   "build_nodes": {
     "default"    : ["name:name_of_builder"]
   },

You can also set which runners you want jobs to run on for your project. You can set default, per phase, and matrix per phase filters to customize exactly which runners are targeted at various points of your pipeline. Refer to :ref:`job_dispatch config setting <job-dispatch-config-settings>` for more details and examples.

Cancelling Jobs
=====================================================

You can cancel queued or running phase jobs in the new job dispatch system. Simply click the trash can in the UI next to a phase run from the change view for the job you wish to cancel.

Managing and Inspecting Jobs
=====================================================

You can see the job queue, runnning jobs, what your runners are currently doing, runner health, and so on. Navigate to `Workflow -> Runners` in the UI to see all the possibilities.
