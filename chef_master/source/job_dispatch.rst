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

Job Dispatch and Push Jobs
-----------------------------------------------------

Any project configured to use Job Dispatch will not use Push Jobs as the transport mechanism for managing the phase builds (unit, lint, provision, etc.) on runner nodes. Push Jobs is still required to execute the `delivery_push_job` resource that the delivery-sugar cookbook exposes. This means that if you use the default `deploy.rb  <https://github.com/chef-cookbooks/delivery-truck/blob/b9e386e720376f7f3173ca03311cba667eb7ef4b/recipes/deploy.rb>`__ recipe from delivery-truck then Push Jobs is still used within the deploy phase.

Job Dispatch is not a replacement for Push Jobs. Job Dispatch is a targeted solution for managing phase builds and Push Jobs allows users to perform remote tasks on pools of nodes. Job Dispatch uses SSH connections and allows additional features, such as cancelling jobs. 



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

Currently the only supported runner platforms are Ubuntu, Centos, and macOS 10.12.

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
