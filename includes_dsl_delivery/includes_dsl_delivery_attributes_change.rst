.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use attributes from the ``node['delivery']['change']`` namespace to get details about the job execution for the current change in the pipeline.

``change_id``
   Use ``node['delivery']['change']['change_id']`` for the change identifier.

``enterprise``
   Use ``node['delivery']['change']['enterprise']`` for the enterprise name.

``git_url``
   Use ``node['delivery']['change']['git_url']`` for the URL for the |git| project.

``organization``
   Use ``node['delivery']['change']['organization']`` for the organization name.

``patchset_branch``
   Use ``node['delivery']['change']['patchset_branch']`` for the branch name.

``patchset_number``
   Use ``node['delivery']['change']['patchset_number']`` for the patchset number.

``phase``
   Use ``node['delivery']['change']['phase']`` for the current phase name.

``pipeline``
   Use ``node['delivery']['change']['pipeline']`` for the pipeline name.

``project``
   Use ``node['delivery']['change']['project']`` for the project name.

``sha``
   Use ``node['delivery']['change']['sha']`` for the |sha1| hash.

``stage``
   Use ``node['delivery']['change']['stage']`` for the current stage name.
