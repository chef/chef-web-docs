.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The URL from which these downloads can be obtained has the following syntax:

.. code-block:: xml

   http://www.chef.io/chef/download?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false

or:

.. code-block:: xml

   http://www.chef.io/chef/metadata?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false

where the difference between these URLs is the ``metadata`` and ``download`` options. Use the ``metadata`` option to verify the build before downloading it. Use the ``download`` option to download the package in a single step.