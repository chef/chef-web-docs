.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


Custom properties are defined in the resource. This custom resource needs two:

* ``instance_name``
* ``port``

These properties are defined as variables in the ``httpd.conf.erb`` file. A **template** block in recipes will tell the chef-client how to apply these variables.
