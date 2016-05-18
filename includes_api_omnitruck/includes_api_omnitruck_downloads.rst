.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``/metadata`` and/or ``/download`` endpoints can be used to download packages for all products:

.. code-block:: xml

   https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest

or:

.. code-block:: xml

   https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest

where:

* ``<CHANNEL>`` is the release channel to install from. See `Chef Software Inc Packages <https://docs.chef.io/packages.html>`__ for full details on the available channels.
* ``<PRODUCT>`` is the |chef inc| product to install. A list of valid product keys can be found at https://omnitruck.chef.io/products
* ``p`` is the platform. Possible values: ``debian``, ``el`` (for |centos|), ``freebsd``, ``mac_os_x``, ``solaris2``, ``sles``, ``suse``, ``ubuntu`` or ``windows``.
* ``pv`` is the platform version. Possible values depend on the platform. For example, |ubuntu|: ``10.10``, ``11.04``, ``11.10``, ``12.04``, or ``12.10`` or for |mac os x|: ``10.6`` or ``10.7``.
* ``m`` is the machine architecture for the machine on which the product will be installed. Possible values depend on the platform. For example, for |ubuntu| or |debian|: ``i386`` or ``x86_64`` or for |mac os x|: ``x86_64``.
* ``v`` is the version of the product to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. One-part (x) and two-part (x.y) versions are allowed. For more information about application versioning, see http://semver.org/. Default value: ``latest``.
