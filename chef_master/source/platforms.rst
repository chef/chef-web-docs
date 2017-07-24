=====================================================
Platforms and Supported Versions
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/platforms.rst>`__

Chef software is supported on the various platforms listed below. To see which versions of our software we currently support, see the :ref:`versions` section.

Platforms
=====================================================
The available platforms for Chef software are divided into three categories, based on the level of testing that is performed, and the amount of support that is provided for them:

**Foundational platforms** are those for which Chef performs some post-build verification on them or their equivalents, and publishes packages for them. Only platform versions that receive automated post-build verification are listed here, even when newer or intermediate versions may be known to work.

**Secondary platforms** are those that Chef does not perform post-build verification on, but packages are made available for them.

**Other platforms** are those that are supported in code, but Chef does not provide packages for them.

chef-client/ohai
++++++++++++++++++++++++++++++++++++++++++++++++++++

Foundational Platforms
------------------------------------------------------

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
   * - macOS
     - ``x86_64``
     - ``10.9``, ``10.10``, ``10.11``, ``10.12``
   * - Oracle Linux
     - ``i386``, ``x86_64``
     - ``5``, ``6``, ``7``
   * - Red Hat Enterprise Linux
     - ``i386``, ``x86_64``, ``s390x``
     - ``5``, ``6``, ``7``
   * - Solaris
     - ``sparc``, ``x86``
     - ``10 1\13`` (``"10U11"``), ``11.2``, ``11.3`` 
   * - SUSE Enterprise Linux Server
     - ``x86_64``, ``s390x``
     - ``11 SP4``, ``12 SP1``
   * - Ubuntu
     - ``x86``, ``x86_64``
     - ``12.04``, ``14.04``, ``16.04``
   * - Microsoft Windows
     - ``x86``, ``x86_64``
     - ``2008r2``, ``2012``, ``2012r2``, ``7``, ``8``, ``8.1``, ``10``

Secondary Platforms
------------------------------------------------------
The following table lists the Secondary platforms for the chef-client:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - AIX
     - ``ppc64``
     - ``7.2``
   * - Amazon Linux
     -
     - current version
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
     - ``42``
   * - Scientific Linux
     - ``i386``, ``x86-64``
     - ``5``, ``6``, ``7``
   * - Microsoft Windows
     -
     - ``2016``

Other Platforms
------------------------------------------------------
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
   * - macOS
     -
     - ``10.8`` (and older)
   * - NetBSD
     -
     -
   * - openSUSE
     - ``13.x`` (or older)
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
     - ``ppc64``, ``System/z``, 10 (or older)
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
++++++++++++++++++++++++++++++++++++++++++++++++++++

Foundational Platforms
------------------------------------------------------
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
   * - macOS
     -
     - ``10.10``, ``10.11``, ``10.12``
   * - Red Hat Enterprise Linux
     -
     - ``6.x``, ``7.x``
   * - SUSE Enterprise Linux Server
     -
     - ``11 SP4``, ``12 SP1``
   * - Ubuntu
     -
     - ``12.04``, ``14.04``, ``16.04``
   * - Microsoft Windows
     -
     - ``7``, ``8``, ``8.1``, ``10``, ``2008 R2``, ``2012``, ``2012 R2``

Other Platforms
------------------------------------------------------
The following platforms are not tested by Chef Software:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - macOS
     -
     - ``10.9`` (and earlier)
   * - Microsoft Windows
     -
     - ``Vista``, ``XP``, ``2000``, ``2003``, ``2003 R2``, ``2008``

Chef Server
++++++++++++++++++++++++++++++++++++++++++++++++++++

Foundational Platforms
------------------------------------------------------

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
   * - SUSE Enterprise Linux Server
     - ``x86_64``, ``s390x``
     - ``11 SP4``, ``12 SP1``
   * - Ubuntu
     -
     - ``12.04``, ``14.04``, ``16.04``

.. end_tag

Other Platforms
------------------------------------------------------
.. tag adopted_platforms_server_other

The following platforms are not tested by Chef Software:

* Any Linux or UNIX distribution that is not listed as a Foundational platform.
* Microsoft Windows
* 32-bit architectures

.. end_tag

Chef Automate
++++++++++++++++++++++++++++++++++++++++++++++++++++

Foundational Platforms
------------------------------------------------------
The following table lists the Foundational platforms for Chef Automate. Do not mix platforms or platform versions within the Chef Automate cluster.

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
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``11 SP4``, ``12 SP2``
   * - Ubuntu
     - ``x86_64``
     - ``12.04``, ``14.04``, ``16.04``

Secondary Platforms
------------------------------------------------------
The following table lists the Secondary platforms for the Chef Automate server:

.. list-table::
 :widths: 280 100 120
 :header-rows: 1

 * - Platform
   - Architecture
   - Version
 * - Oracle Linux
   - ``x86_64``
   - ``6``, ``7``

.. note:: The Delivery CLI may be run on the following platforms:

          * macOS
          * Ubuntu
          * Red Hat Enterprise Linux
          * Microsoft Windows

Runners
------------------------------------------------------
Runners are supported on the Foundational and Secondary platforms listed above, as well as on the following platforms:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - macOS
     - ``x86_64``
     - ``10.12``

Chef Push Jobs
++++++++++++++++++++++++++++++++++++++++++++++++++++

Foundational Platforms
------------------------------------------------------
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

.. _versions:

Supported Versions
==============================================

The following tables list the versions of the OSS and commercial Chef products we currently support:

+-------------------------------------------------------------------------+ 
|  Open Source                                                            | 
+----------------------+--------------------------------------------------+       
| Product              | Version                                          |
+======================+==================================================+ 
| Chef Client          | 12.0.0 or later                                  | 
+----------------------+--------------------------------------------------+
| Chef DK              | 1.0.3 or later                                   | 
+----------------------+--------------------------------------------------+
| Chef Server          | 12.0.0 or later                                  | 
+----------------------+--------------------------------------------------+   
| Push Jobs Client     |                                                  | 
+----------------------+ 2.1.0 or later                                   |
| Push Jobs Server     |                                                  | 
+----------------------+--------------------------------------------------+
| Supermarket          | 2.2.1 or later                                   | 
+----------------------+--------------------------------------------------+   

+-------------------------------------------------------------------------+ 
|  Chef Automate License                                                  | 
+----------------------+--------------------------------------------------+ 
| Product              | Version                                          |
+======================+==================================================+ 
| Chef Automate        | 0.3.56                                           | 
+----------------------+--------------------------------------------------+
| Chef Backend         | Latest                                           | 
+----------------------+--------------------------------------------------+  
| Chef Compliance      | 0.9.0 or later                                   | 
+----------------------+--------------------------------------------------+
| Chef Manage          | 2.1.0 or later                                   | 
+----------------------+--------------------------------------------------+ 

+-------------------------------------------------------------------------+ 
|  Enterprise Chef License (Legacy)                                       | 
+----------------------+--------------------------------------------------+ 
| Product              | Version                                          |
+======================+==================================================+ 
| Enterprise Chef      | 11.2.2                                           | 
+----------------------+--------------------------------------------------+
| Reporting            | 1.0.0 or later                                   | 
+----------------------+--------------------------------------------------+
| Analytics            | No longer supported for new installations.       | 
+----------------------+--------------------------------------------------+
