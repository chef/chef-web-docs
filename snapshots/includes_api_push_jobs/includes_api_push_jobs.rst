.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The Push Jobs API is used to create jobs and retrieve status using Chef push jobs, a tool that pushes jobs against a set of nodes in the organization. All requests are signed using the Chef server API and the validation key on the workstation from which the requests are made. All commands are sent to the Chef server using the ``knife exec`` subcommand.
