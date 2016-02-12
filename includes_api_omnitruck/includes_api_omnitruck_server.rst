.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``/metadata-server`` and/or ``/download-server`` endpoints can be used to download the |chef server|:

.. code-block:: xml

   http://www.chef.io/chef/download-server?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false

or:

.. code-block:: xml

   http://www.chef.io/chef/metadata-server?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false

where:

* ``p`` is the platform. Possible values: ``ubuntu`` or ``el`` (for |centos|).
* ``pv`` is the platform version.  Possible values depend on the platform. For example, |ubuntu|: ``10.04``, ``10.10``, ``11.04``, ``11.10``, ``12.04``, or ``12.10``.
* ``m`` is the machine architecture for the machine on which the |chef server| will be installed. Possible values: ``x86_64``.
* ``v`` is the version of the |chef server| to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. A two-part version (x.y) is also allowed. For more information about application versioning, see http://semver.org/. Default value: ``latest``.
* ``prerelease`` indicates that pre-release versions of |chef server| will be included in the query. Default value: ``false``.
* ``nightlies`` indicates that nightly versions of |chef server| will be included in the query. Default value: ``false``.

.. warning:: Nightly versions should never be run in a production environment and should be used for testing and validation purposes only.

