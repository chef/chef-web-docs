.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Name things uniformly for their system and component. For example:

* attributes: ``node['foo']['bar']``
* recipe: ``foo::bar``
* role: ``foo-bar``
* directories: ``foo/bar`` (if specific to component), ``foo`` (if not). For example: ``/var/log/foo/bar``.

Name attributes after the recipe in which they are primarily used. e.g. ``node['postgresql']['server']``.