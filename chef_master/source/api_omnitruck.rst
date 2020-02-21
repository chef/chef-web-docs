=====================================================
Omnitruck API
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/api_omnitruck.rst>`__

Chef's Omnitruck API powers the Chef install scripts as well as downloads.chef.io site. It can be used to query available versions of Chef Software Inc. products and to provide direct download URLs.

Syntax
=====================================================
The URL from which these downloads can be obtained has the following syntax:

.. code-block:: none

   https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false

or:

.. code-block:: none

   https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest&prerelease=false&nightlies=false

where the difference between these URLs is the ``metadata`` and ``download`` options. Use the ``metadata`` option to verify the build before downloading it. Use the ``download`` option to download the package in a single step.

Downloads
=====================================================
The ``/metadata`` and/or ``/download`` endpoints can be used to download packages for all products:

.. code-block:: none

   https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest

or:

.. code-block:: none

   https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/metadata?p=$PLATFORM&pv=$PLATFORM_VERSION&m=$MACHINE_ARCH&v=latest

where:

* ``<CHANNEL>`` is the release channel to install from. See `Chef Software Inc Packages </packages.html>`__ for full details on the available channels.
* ``<PRODUCT>`` is the Chef Software Inc product to install. A list of valid product keys can be found at https://github.com/chef/mixlib-install/blob/master/PRODUCT_MATRIX.md
* ``p`` is the platform. Possible values: ``debian``, ``el`` (for CentOS), ``freebsd``, ``mac_os_x``, ``solaris2``, ``sles``, ``suse``, ``ubuntu`` or ``windows``.
* ``pv`` is the platform version. Possible values depend on the platform. For example, Ubuntu: ``16.04``, or ``18.04`` or for macOS: ``10.14`` or ``10.15``.
* ``m`` is the machine architecture for the machine on which the product will be installed. Possible values depend on the platform. For example, for Ubuntu or Debian: ``i386`` or ``x86_64`` or for macOS: ``x86_64``.
* ``v`` is the version of the product to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. One-part (x) and two-part (x.y) versions are allowed. For more information about application versioning, see https://semver.org/. Default value: ``latest``.

Platforms
-----------------------------------------------------
Omnitruck accepts the following platforms:

.. list-table::
   :widths: 280 60 60 100
   :header-rows: 1

   * - Platform
     - p
     - m
     - pv
   * - Cisco IOS XR
     - ``ios_xr``
     - ``x86_64``
     - ``6``
   * - Cisco NX-OS
     - ``nexus``
     - ``x86_64``
     - ``7``
   * - Debian
     - ``debian``
     - ``x86_64``
     - ``6``, ``7``, ``8``, ``9``, ``10``
   * -
     -
     - ``i386``
     - ``6``, ``7``, ``8``
   * - Red Hat Enterprise Linux / CentOS
     - ``el``
     - ``x86_64``
     - ``5``, ``6``, ``7``, ``8``
   * -
     -
     - ``i386``
     - ``5``, ``6``, ``7``
   * - FreeBSD
     - ``freebsd``
     - ``x86_64``
     - ``9``, ``10``, ``11``, ``12``
   * -
     -
     - ``i386``
     - ``9``, ``10``, ``11``, ``12``
   * - AIX
     - ``aix``
     - ``powerpc``
     - ``6.1``, ``7.1``
   * - macOS
     - ``mac_os_x``
     - ``x86_64``
     - ``10.6``, ``10.7``, ``10.8``, ``10.9``, ``10.10``, ``10.11``, ``10.12``, ``10.13``, ``10.14``, ``10.15``
   * - Solaris
     - ``solaris2``
     - ``i386``
     - ``5.10``, ``5.11``
   * -
     -
     - ``sparc``
     - ``5.10``, ``5.11``
   * - Ubuntu
     - ``ubuntu``
     - ``x86_64``
     - ``10.04``, ``10.10``, ``11.04``, ``11.10``, ``12.04``, ``12.10``, ``13.04``, ``13.10``, ``14.04``, ``14.10``, ``16.04``, ``16.10``, ``17.04``, ``17.10``, ``18.04``
   * -
     -
     - ``i386``
     - ``10.04``, ``10.10``, ``11.04``, ``11.10``, ``12.04``, ``12.10``, ``13.04``, ``13.10``, ``14.04``, ``14.10``, ``16.04``, ``16.10``, ``17.04``, ``17.10``, ``18.04``
   * - Microsoft Windows
     - ``windows``
     - ``x86_64``
     - ``7``, ``8``, ``10``, `2008r2`, ``2012``, ``2012r2``, ``2016``, ``2019``
   * -
     -
     - ``i386``
     - ``7``, ``8``, ``10``, `2008r2`, ``2012``, ``2012r2``

Examples
-----------------------------------------------------

**Get the Latest Build**

To get the latest supported build for Ubuntu 18.04, enter the following:

.. code-block:: none

   https://omnitruck.chef.io/stable/chef/metadata?p=ubuntu&pv=18.04&m=x86_64

to return something like:

.. code-block:: none


   sha1 dc185e713e1dc3a79f699340c4fb169596375b43
   sha256 d5a616db707690fe52aa90f52c13deb3e37c3b8790feb2c37154ab3c4565fda7
   url https://packages.chef.io/files/stable/chef/15.8.23/ubuntu/18.04/chef_15.8.23-1_amd64.deb
   version 15.8.23

**Download Directly**

To use cURL to download a package directly, enter the following:

.. code-block:: bash

   curl -LOJ 'https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=debian&pv=6&m=x86_64'

To use GNU Wget to download a package directly, enter the following:

.. code-block:: bash

   wget --content-disposition https://omnitruck.chef.io/<CHANNEL>/<PRODUCT>/download?p=debian&pv=6&m=x86_64
