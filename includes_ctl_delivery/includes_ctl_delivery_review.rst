.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``review`` subcommand to submit a feature branch for review as a new patchset. This either creates a new change associated with the feature branch, or adds a new patchset on an existing change in the pipeline. When the new patchset has been created, the Verify stage for the associated change is automatically triggered and runs the unit, lint and syntax phases. By default, this action opens a browser window to show the pipeline in |chef delivery|.
