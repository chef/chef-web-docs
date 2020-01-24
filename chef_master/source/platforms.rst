=====================================================
Platforms
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/platforms.rst>`__

Chef software is supported on the various operating systems (platforms) listed below. To see which versions of our software we currently support, see the `Supported Versions </versions.html>`__ page.

Platforms
=====================================================

The sections below list the platforms that Chef Software Inc. supports. Support is divided into two levels:

* **Commercial Support** consists of the platforms that are supported as part of a paid commercial support contract with Chef Software Inc.
* **Community Support** is made up of platforms for which support is only available through the Chef community

Any platforms or versions not explicitly listed here are unsupported, both commercially and by the community.

Commercial support generally follows Chef community support policies, which track the lifecycle policies of the underlying operating system vendor.

In all cases (beyond community support), a maintenance contract with Chef Software Inc. is required in order to open support tickets and get SLA-based assistance from our support desk.

Chef Infra Client
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms and versions for Chef Infra Client:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - AIX
     - ``powerpc``
     - ``7.1`` (TL5 SP2 or higher, recommended), ``7.2``
   * - Amazon Linux
     -
     - 2013+ and 2.0
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``, ``8.x``
   * - Debian
     - ``i686``, ``x86_64``
     - ``8``, ``9``, ``10``
   * - FreeBSD
     - ``amd64``
     - ``11.x``, ``12.x``
   * - macOS
     - ``x86_64``
     - ``10.13``, ``10.14``, ``10.15``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``, ``8.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``, ``ppc64le`` (7.x only), ``ppc64`` (7.x only), ``aarch64`` (7.x only)
     - ``6.x``, ``7.x``, ``8.x``
   * - Solaris
     - ``sparc``, ``i86pc``
     - ``11.2``, ``11.3``, ``11.4``
   * - SUSE Enterprise Linux Server
     - ``x86_64``, ``ppc64le``, ``ppc64``
     - ``12 SP1+``, ``15``
   * - Ubuntu (LTS releases)
     - ``x86_64``
     - ``16.04``, ``18.04``
   * - Microsoft Windows
     - ``x86``, ``x64``
     - ``7``, ``8.1``, ``2008 R2``, ``2012``, ``2012 R2``, ``2016``, ``10 (all channels except "insider" builds)``, ``2019 (Long-term servicing channel (LTSC), both Desktop Experience and Server Core)``

Community Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following platforms are supported only via the community:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - Arch Linux
     -
     - current version
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
     - ``42.x``
   * - Scientific Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Ubuntu
     - ``i386``, ``x86_64``
     - Current non-LTS releases
   * - Windows
     - ``x64``
     - ``Windows Server, Semi-annual channel (SAC) (Server Core only)``

Chef Workstation
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms and versions for the Chef Workstation:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - macOS
     - ``x86_64``
     - ``10.13``, ``10.14``, ``10.15``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``, ``8.x``
   * - Ubuntu
     - ``x86_64``
     - ``16.04``, ``18.04``
   * - Microsoft Windows
     - ``x64``
     - ``2012``, ``2012 R2``, ``2016``, ``10 (all channels except "insider" builds)``, ``2019 (Long-term servicing channel (LTSC), Desktop Experience only)``

Chef InSpec
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms and versions for Chef InSpec:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - macOS
     - ``x86_64``
     - ``10.13``, ``10.14``, ``10.15``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``, ``8.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``12 SP1+``, ``15``
   * - Ubuntu
     - ``x86_64``
     - ``16.04``, ``18.04``
   * - Microsoft Windows
     - ``x86_64``
     - ``2012``, ``2012 R2``, ``2016``, ``10 (all channels except "insider" builds)``, ``2019``

Chef InSpec Target Mode (``inspec --target``) may be functional on additional platforms, versions, and architectures but are not validated by Chef Software, Inc.

ChefDK
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms and versions for ChefDK:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - Debian
     - ``x86_64``
     - ``8.x``, ``9.x``, ``10.x``
   * - macOS
     - ``x86_64``
     - ``10.13``, ``10.14``, ``10.15``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``, ``8.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``12 SP1+``, ``15``
   * - Ubuntu
     - ``x86_64``
     - ``16.04``, ``18.04``
   * - Microsoft Windows
     - ``x86``, ``x64``
     - ``2008 R2``, ``2012``, ``2012 R2``, ``2016``, ``10 (all channels except "insider" builds)``, ``2019 (Long-term servicing channel (LTSC), Desktop Experience only)``

Community Support
++++++++++++++++++++++++++++++++++++++++++++++++++++
The following platforms are supported only via the community:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - openSUSE
     -
     - ``42.x``
   * - Scientific Linux
     - ``x86_64``
     - ``6.x``, ``7.x``

Chef Infra Server
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag adopted_platforms_server

The following table lists the commercially-supported platforms and versions for the Chef Infra Server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``, ``ppc64le`` (7.x only), ``ppc64`` (7.x only)
     - ``6.x``, ``7.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``12 SP1+``, ``15``
   * - Ubuntu
     - ``x86_64``
     - ``16.04``, ``18.04``

.. end_tag

Chef Automate Server
----------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

Commercial support for the `Chef Automate 2 Server <https://automate.chef.io/docs/system-requirements/>`_ is available for platforms that use:

* a Linux kernel version of 3.2 or greater
* ``systemd`` as the init system
* ``useradd``
* ``curl`` or ``wget``

The following table lists the commercially-supported platforms and versions for Chef Automate 1 Server. Do not mix platforms or platform versions within the Chef Automate cluster.

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``12 SP2``
   * - Ubuntu
     - ``x86_64``
     - ``16.04``, ``18.04``

Chef Automate Job Runners
----------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate Job Runners are supported on the Commercial Support platforms for Chef Automate Server listed above as well as on the following platforms:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - macOS
     - ``x86_64``
     - ``10.12``

Chef Push Jobs Client
----------------------------------------------------
Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for the Chef Push Jobs client:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - macOS
     - ``x86_64``
     - ``10.11``, ``10.12``, ``10.13``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``i386``, ``x86_64``
     - ``16.04``, ``18.04``
   * - Microsoft Windows
     - ``x86``, ``x64``
     - ``2008 R2``, ``2012``, ``2012 R2``, ``2016``, ``10``



Chef Push Jobs Server
-----------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for the Chef Push Jobs server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``x86_64``
     - ``16.04``, ``18.04``

Chef Backend
----------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for Chef Backend, the high-availability solution for Chef Infra Server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``x86_64``
     - ``16.04``, ``18.04``


Chef Manage
---------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for Chef Manage:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``x86_64``
     - ``16.04``, ``18.04``

Platform End-of-Life Policy
===========================

Chef's products on particular platforms and versions generally reach end-of-life on the same date as the vendor EOL milestone for that operating systems.
Because different vendors use different terminology, the following table clarifies when Chef products are end-of-life according to those vendors'
terms:

+------------------------------------------------------------------------------------+----------------------------+
| Platform                                                                           | Vendor End-of-Life         |
+====================================================================================+============================+
| AIX                                                                                | IBM End of Support Date    |
+------------------------------------------------------------------------------------+----------------------------+
| Debian                                                                             | End of maintenance updates |
+------------------------------------------------------------------------------------+----------------------------+
| Enterprise Linux (covers RedHat Enterprise Linux, CentOS)                          | End of Production 3        |
+------------------------------------------------------------------------------------+----------------------------+
| FreeBSD                                                                            | End of Life                |
+------------------------------------------------------------------------------------+----------------------------+
| Microsoft Windows                                                                  | End of Extended Support    |
+------------------------------------------------------------------------------------+----------------------------+
| Oracle Enterprise Linux                                                            | Premier Support Ends       |
+------------------------------------------------------------------------------------+----------------------------+
| Oracle Solaris                                                                     | Premier Support Ends       |
+------------------------------------------------------------------------------------+----------------------------+
| SUSE Linux Enterprise Server                                                       | General Support Ends       |
+------------------------------------------------------------------------------------+----------------------------+
| Ubuntu Linux                                                                       | End of maintenance updates |
+------------------------------------------------------------------------------------+----------------------------+

At Chef's option, additional support may be provided to customers beyond the vendor end-of-life in the above table.
As such, the following table indicates upcoming product end-of-life dates for particular platforms.
On the Chef end-of-life date, Chef discontinues building software for that platform and version.

+--------------------------------------------------------------+-------------------------+-----------------------+
| Platform and Version                                         | Vendor End-of-Life Date | Chef End-of-Life Date |
+==============================================================+=========================+=======================+
| AIX 6.1                                                      | April 30, 2017          | December 31, 2017     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Debian 7 (Wheezy)                                            | May 31st, 2018          | May 31st, 2018        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Debian 8 (Jessie)                                            | June 6th, 2020          | June 6th, 2020        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Enterprise Linux 5 (covers Red Hat Enterprise Linux, CentOS) | April 30, 2017          | December 31, 2017     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Enterprise Linux 6 (covers Red Hat Enterprise Linux, CentOS) | November 30, 2020       | November 30, 2020     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| FreeBSD 10-STABLE                                            | October 31, 2018        | October 31, 2018      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Microsoft Windows Server 2008 (SP2)/R2 (SP1)                 | January 13, 2015        | January 14, 2020      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Microsoft Windows Server 2012/2012 R2                        | October 10, 2023        | October 10, 2023      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Microsoft Windows Server 2016                                | November 11, 2027       | November 11, 2027     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Microsoft Windows Server 2019                                | October 10, 2028        | October 10, 2028      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Oracle Enterprise Linux 5                                    | June 30, 2017           | December 31, 2017     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Oracle Enterprise Linux 6                                    | March 31, 2021          | March 31, 2021        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Oracle Solaris 10                                            | January 30, 2018        | January 30, 2018      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| SUSE Linux Enterprise Server 11                              | March 31, 2019          | March 31, 2019        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Ubuntu Linux 12.04 LTS                                       | April 30, 2017          | April 30, 2017        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Ubuntu Linux 14.04 LTS                                       | April 30, 2019          | April 30, 2019        |
+--------------------------------------------------------------+-------------------------+-----------------------+
