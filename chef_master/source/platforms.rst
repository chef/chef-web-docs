=====================================================
Platforms
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/platforms.rst>`__

The sections below list the platforms that Chef have adopted for the chef-client, Ohai, and the Chef server.

.. note:: Foundational platforms are those for which Chef performs some
          post-build verification on them or their equivalents, and
          publishes packages for. Only platform versions that receive
          automated post-build verification are listed here, even when
          newer or intermediate versions may be known to work.

.. note:: Secondary platforms are those that Chef performs no
          post-build verification on, but packages are made available for.

.. note:: Other platforms are those that are supported in code, but Chef
          does not provide packages for.

chef-client/ohai, Foundational Platforms
=====================================================
The following table lists the Foundational platforms for the chef-client and ohai:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - AIX
     - ``ppc64``
     - ``6.1`` (TL6 or higher, recommended), ``7.1`` (TL0 SP3 or higher, recommended)
   * - CentOS
     - ``i386``, ``x86_64``
     - ``5``, ``6``, ``7``
   * - FreeBSD
     - ``i386``, ``amd64``
     - ``9``, ``10``
   * - Mac OS X
     - ``x86_64``
     - ``10.9``, ``10.10``, ``10.11``, ``10.12``
   * - Oracle Linux
     - ``i386``, ``x86_64``
     - ``5``, ``6``, ``7``
   * - Red Hat Enterprise Linux
     - ``i386``, ``x86_64``
     - ``5``, ``6``, ``7``
   * - Solaris
     - ``sparc``, ``x86``
     - ``10``, ``11``
   * - Ubuntu
     - ``x86``, ``x86_64``
     - ``12.04``, ``14.04``, ``16.04``
   * - Microsoft Windows
     - ``x86``, ``x86_64``
     - ``2008r2``, ``2012``, ``2012r2``, ``7``, ``8``, ``8.1``, ``10``
   * - Cisco NX-OS
     - ``x86_64``
     - ``7``
   * - Cisco IOS XR
     - ``x86_64``
     - ``6``

Secondary Platforms
-----------------------------------------------------
The following table lists the Secondary platforms for the chef-client:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - Arch Linux
     -
     - current version
   * - Debian
     - ``i686``, ``x86_64``
     - ``6``, ``7``, ``8``
   * - Fedora
     -
     - current non-EOL releases
   * - Gentoo
     -
     - current version
   * - OmniOS
     -
     - stable and LTS releases
   * - openSUSE
     -
     - ``13``
   * - Scientific Linux
     - ``i386``, ``x86-64``
     - ``5``, ``6``, ``7``
   * - SUSE Enterprise Linux Server
     -
     - ``10``, ``11``

Other Platforms
-----------------------------------------------------
The following platforms are not tested by Chef Software:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - AIX
     -
     - ``5.1L``
   * - CentOS
     -
     - ``4.x`` (or older)
   * - FreeBSD
     -
     - ``8``
   * - HP-UX
     -
     -
   * - Mac OS X
     -
     - ``10.8`` (and older)
   * - NetBSD
     -
     -
   * - OpenBSD
     -
     -
   * - Oracle Linux
     -
     - ``4.x`` (or older)
   * - Red Hat Enterprise Linux
     - ``ppc64``, ``System/z``
     -

   * - SUSE Enterprise Linux Server
     - ``ppc64``, ``System/z``
     -
   * - Solaris
     -
     - ``8``, ``9``
   * - Ubuntu
     -
     - ``10.04`` (or older)
   * - Microsoft Windows
     -
     - ``2000``, ``2003``, ``2003 R2``, ``2008``

Chef DK
=====================================================
The following table lists the Foundational platforms for the Chef DK:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - Debian
     -
     - ``7.x``, ``8.x``
   * - Mac OS X
     -
     - ``10.9``, ``10.10``, ``10.11``, ``10.12``
   * - Red Hat Enterprise Linux
     -
     - ``6.x``, ``7.x``
   * - Ubuntu
     -
     - ``12.04``, ``14.04``, ``16.04``
   * - Microsoft Windows
     -
     - ``7``, ``8``, ``8.1``, ``10``, ``2008 R2``, ``2012``, ``2012 R2``

Other Platforms
-----------------------------------------------------
The following platforms are not tested by Chef Software:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - Mac OS X
     -
     - ``10.8`` (and earlier)
   * - Microsoft Windows
     -
     - ``Vista``, ``XP``, ``2000``, ``2003``, ``2003 R2``

Chef Server
=====================================================
.. tag adopted_platforms_server

The following table lists the Foundational platforms for the Chef server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     -
     - ``5.x``, ``6.x``, ``7.x``
   * - Oracle Linux
     -
     - ``5.x``, ``6.x``
   * - Red Hat Enterprise Linux
     -
     - ``5.x``, ``6.x``, ``7.x``
   * - Ubuntu
     -
     - ``12.04``, ``14.04``, ``16.04``

.. end_tag

Other Platforms
-----------------------------------------------------
.. tag adopted_platforms_server_other

The following platforms are not tested by Chef Software:

* Any Linux or UNIX distribution that is not listed as a Foundational platform.
* Microsoft Windows
* 32-bit architectures

.. end_tag

Chef Automate
=====================================================
The Chef Automate server may be run on the following platforms. Do not mix platforms or platform versions within the Chef Automate cluster.

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.5``, ``6.6``, ``7``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.5``, ``6.6``, ``7``
   * - Ubuntu
     - ``x86_64``
     - ``12.04``, ``14.04``, ``16.04``

.. note:: The Delivery CLI may be run on the following platforms:

          * Mac OS X
          * Ubuntu
          * Red Hat Enterprise Linux
          * Microsoft Windows

Chef Push Jobs
=====================================================
.. tag adopted_platforms_push_jobs

The following table lists the Foundational platforms for the Chef push jobs:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``i386``
     - ``5``, ``6``
   * -
     - ``x86_64``
     - ``5``, ``6``, ``7``
   * - Debian
     - ``i386``, ``x86_64``
     - ``7``
   * - Red Hat Enterprise Linux
     - ``i386``
     - ``5``, ``6``
   * -
     - ``x86_64``
     - ``5``, ``6``, ``7``
   * - Ubuntu
     - ``x86``, ``x86_64``
     - ``12.04``, ``14.04``
   * - Microsoft Windows
     - ``x86``, ``x86_64``
     - ``2008r2``, ``2012``, ``2012r2``, ``7``, ``8``, ``8.1``, ``10``

.. end_tag
