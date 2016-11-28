=====================================================
Release Notes: Chef Push Jobs
=====================================================

.. tag push_jobs_1

Chef push jobs is an extension of the Chef server that allows jobs to be run against nodes independently of a chef-client run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the Chef server.

Chef push jobs uses the Chef server API and a Ruby client to initiate all connections to the Chef server. Connections use the same authentication and authorization model as any other request made to the Chef server. A knife plugin is used to initiate job creation and job tracking.

.. end_tag

What's New
=====================================================
The following items are new for Chef push jobs:

* **Push Jobs client 2.1** Chef push jobs client 2.1 is backwards-compatible with the Chef push jobs 1.x server when the ``allow_unencrypted`` option to be set to ``true`` in the ``LOCATION OF LOG FILE GOES HERE``.

