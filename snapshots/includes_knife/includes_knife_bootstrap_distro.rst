.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The template file to be used during a bootstrap operation. The following distributions are supported:

* ``chef-full`` (the default bootstrap)
* ``centos5-gems``
* ``fedora13-gems``
* ``ubuntu10.04-gems``
* ``ubuntu10.04-apt``
* ``ubuntu12.04-gems``
* The name of a custom bootstrap template file.

When this option is used, knife searches for the template file in the following order:

#. The ``bootstrap/`` folder in the current working directory
#. The ``bootstrap/`` folder in the chef-repo
#. The ``bootstrap/`` folder in the ``~/.chef/`` directory
#. A default bootstrap file.

Do not use the ``--template-file`` option when ``--distro`` is specified.
