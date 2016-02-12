.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``/metadata-chefdk`` and/or ``/download-chefdk`` endpoints can be used to download the |chef dk|:

.. code-block:: xml

   http://www.chef.io/chef/download-chefdk?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false

or:

.. code-block:: xml

   http://www.chef.io/chef/metadata-chefdk?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false

where:

* ``p`` is the platform. Possible values: ``ubuntu``, ``rhel``, or ``mac``.
* ``pv`` is the platform version.  Possible values depend on the platform. For example, |ubuntu|: ``12.04`` or ``13.10``.
* ``m`` is the machine architecture for the machine on which the |chef dk| will be installed. Possible values: ``x86_64``.
* ``v`` is the version of the |chef dk| to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. A two-part version (x.y) is also allowed. For more information about application versioning, see http://semver.org/. Default value: ``latest``.
* ``prerelease`` indicates that pre-release versions of |chef dk| will be included in the query. Default value: ``false``.
* ``nightlies`` indicates that nightly versions of |chef dk| will be included in the query. Default value: ``false``.

.. warning:: Nightly versions should never be run in a production environment and should be used for testing and validation purposes only.



