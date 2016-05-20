.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A custom audit resource has the following methods are available:

``inspec``
   Contains a registry of all other resources to interact with the operating system or target in general.

``skip_resource``
   A resource may call this method to indicate that requirements aren't met. All tests that use this resource will be marked as ``skipped``.
