=====================================================
Platforms and Supported Versions
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/platforms.rst>`__

Chef software is supported on the various operating systems (platforms) listed below. To see which versions of our software we currently support, see the :ref:`versions` section.

Platforms
=====================================================

The sections below list the platforms that Chef Software Inc. supports. Support is divided into two levels:

* **Commercial Support** consists of the platforms that are supported as part of a paid commercial support contract with Chef Software Inc.
* **Community Support** is made up of platforms for which support is only available through the Chef community

Any platforms or versions not explicitly listed here are unsupported, both commercially and by the community.

Commercial support generally follows Chef community support policies, which track the lifecycle policies of the underlying operating system vendor.

In all cases (beyond community support), a maintenance contract with Chef Software Inc. is required in order to open support tickets and get SLA-based assistance from our support desk.

Chef Client
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms and versions for Chef Client:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - AIX
     - ``ppc64``
     - ``6.1`` (TL8 or higher, required), ``7.1`` (TL0 SP3 or higher, recommended), ``7.2``
   * - Amazon Linux
     -
     - current version
   * - CentOS
     - ``i386`` (5.x only), ``x86_64``
     - ``5``, ``6``, ``7``
   * - FreeBSD
     - ``amd64``
     - ``10``, ``11``
   * - macOS
     - ``x86_64``
     - ``10.10``, ``10.11``, ``10.12``
   * - Oracle Enterprise Linux
     - ``i386`` (5.x only), ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``i386`` (5.x only), ``x86_64``, ``s390x``, ``ppc64le`` (7.x only), ``ppc64`` (7.x only)
     - ``5.x``, ``6.x``, ``7.x``
   * - Solaris
     - ``sparc``, ``x86``
     - ``10 1/13`` (``"10U11"``), ``11.2``, ``11.3`` 
   * - SUSE Enterprise Linux Server
     - ``x86_64``, ``s390x``, ``ppc64le``, ``ppc64``
     - ``11 SP4``, ``12 SP1``
   * - Ubuntu (LTS releases)
     - ``x86``, ``x86_64``, ``ppc64le`` (14.04 only)
     - ``14.04``, ``16.04``
   * - Microsoft Windows
     - ``x86``, ``x86_64``
     - ``2008r2``, ``2012``, ``2012r2``, ``2016``, ``7``, ``8``, ``8.1``, ``10``

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
     - ``i386`` (5.x only), ``x86-64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Ubuntu
     - ``x86``, ``x86_64``
     - non-LTS releases

Chef DK
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms and versions for the Chef Development Kit (Chef DK):

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
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
     - ``14.04``, ``16.04``
   * - Microsoft Windows
     -
     - ``7``, ``8``, ``8.1``, ``10``, ``2008 R2``, ``2012``, ``2012 R2``

Community Support
++++++++++++++++++++++++++++++++++++++++++++++++++++
The following platforms are supported only via the community:

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
     - ``10.9`` (and earlier)
   * - Microsoft Windows
     -
     - ``Vista``, ``XP``, ``2000``, ``2003``, ``2003 R2``, ``2008``

Chef Server
------------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag adopted_platforms_server

The following table lists the commercially-supported platforms and versions for the Chef Server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``, ``ppc64le`` (7.x only), ``ppc64`` (7.x only)
     - ``5.x``, ``6.x``, ``7.x``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``11 SP4``, ``12 SP1``
   * - Ubuntu
     - ``x86_64``, ``ppc64le`` (14.04 only)
     - ``12.04``, ``14.04``, ``16.04``

.. end_tag

Chef Automate Server
----------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms and versions for Chef Automate Server. Do not mix platforms or platform versions within the Chef Automate cluster.

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6``, ``7``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``6``, ``7``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``6``, ``7``
   * - SUSE Enterprise Linux Server
     - ``x86_64``
     - ``11 SP4``, ``12 SP2``
   * - Ubuntu
     - ``x86_64``
     - ``14.04``, ``16.04``

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
-----------------------------------------------------
.. tag adopted_platforms_push_jobs

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for the Chef push jobs client:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``i386`` (5.x only), ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - macOS
     - ``x86_64``
     - ``10.10``, ``10.11``, ``10.12``
   * - Red Hat Enterprise Linux
     - ``i386`` (5.x and 6.x only), ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``x86``, ``x86_64``
     - ``14.04``
   * - Microsoft Windows
     - ``x86``, ``x86_64``
     - ``2008r2``, ``2012``, ``2012r2``, ``7``, ``8``, ``8.1``, ``10``

.. end_tag

Chef Push Jobs Server
-----------------------------------------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for the Chef push jobs server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``x86_64``
     - ``14.04``, ``16.04``

Chef Backend
------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for Chef Backend, the high-availability solution for Chef Server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``x86_64``
     - ``14.04``, ``16.04``

Chef Compliance Server
----------------------

Commercial Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the commercially-supported platforms for Chef Compliance Server:

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
     - ``14.04``, ``16.04``

Chef Manage
-----------

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
     - ``5.x``, ``6.x``, ``7.x``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``5.x``, ``6.x``, ``7.x``
   * - Ubuntu (LTS releases)
     - ``x86_64``
     - ``14.04``, ``16.04``

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
| Enterprise Linux (covers RedHat Enterprise Linux, CentOS)                          | End of Production 3        |
+------------------------------------------------------------------------------------+----------------------------+
| FreeBSD                                                                            | End of Life                |
+------------------------------------------------------------------------------------+----------------------------+
| Microsoft Windows                                                                  | Mainstream End of Support  |
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
| Microsoft Windows Server 2008 (RTM) Service Pack 2           | January 13, 2015        | January 13, 2015      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Ubuntu Linux 12.04 LTS                                       | April 30, 2017          | April 30, 2017        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| AIX 6.1                                                      | April 30, 2017          | December 31, 2017     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Enterprise Linux 5 (covers Red Hat Enterprise Linux, CentOS) | April 30, 2017          | December 31, 2017     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Oracle Enterprise Linux 5                                    | June 30, 2017           | December 31, 2017     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Microsoft Windows Server 2008R2 Service Pack 1               | January 13, 2015        | January 13, 2018      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Oracle Solaris 10                                            | January 30, 2018        | January 30, 2018      |
+--------------------------------------------------------------+-------------------------+-----------------------+
| FreeBSD 10-STABLE                                            | April 30, 2018          | April 30, 2018        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Microsoft Windows Server 2012 and 2012R2                     | October 9, 2018         | October 9, 2018       |
+--------------------------------------------------------------+-------------------------+-----------------------+
| SUSE Linux Enterprise Server 11                              | March 31, 2019          | March 31, 2019        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Ubuntu Linux 14.04 LTS                                       | April 30, 2019          | April 30, 2019        |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Enterprise Linux 6 (covers Red Hat Enterprise Linux, CentOS) | November 30, 2020       | November 30, 2020     |
+--------------------------------------------------------------+-------------------------+-----------------------+
| Oracle Enterprise Linux 6                                    | March 31, 2021          | March 31, 2021        |
+--------------------------------------------------------------+-------------------------+-----------------------+

.. _versions:

Supported Versions
==============================================

This section lists the versions of the OSS and commercial Chef products we currently support as well as the support level (expressed as a lifecycle status) for each product. The lifecycle status defines the involvement by Chef Software in updating and maintaining each product in the list below.

Lifecycle Definitions
----------------------------------------------

**Generally Available (GA)**

This stage indicates that an application or version is in active development or is considered feature complete.

* Chef continues to provide releases to the application or version in response to customer needs and security vulnerabilities
* Chef welcomes customer feature requests for the product roadmap for the application

**Deprecated** 

This stage indicates that an application or version is no longer in active development and will eventually move to end of life status.  Chef continues to provide support `according to our SLAs <https://www.chef.io/service-level-agreement/>`_.

* Chef no longer provides scheduled releases
* Customers should use the GA alternative to these products; contact us for help with product selection and deployment
* Chef may provide a release for a critical defect or security vulnerability

**End of Life (EOL)**

This stage indicates that Chef has set a date after which the application or version will no longer be supported or recommended for use by customers.

* As of the end of life date, the application will no longer be supported by Chef and will no longer be available for download
* Documentation for the application will be moved to https://docs-archive.chef.io


Versions and Status
----------------------------------------------
.. important:: Unless otherwise stated, versions older than those listed below are EOL.

**Premium Supported Open Source**                                                            

.. list-table:: 
   :header-rows: 1
   :widths: 150, 450, 100, 100

   * - Product
     - Version
     - Lifecycle Status
     - EOL Date
   * - Chef Client
     - 12.x
     - Deprecated
     - TBD
   * - Chef Client
     - 13.x
     - GA
     - n/a
   * - Chef DK
     - 1.x
     - Deprecated
     - TBD
   * - Chef DK
     - 2.x
     - GA
     - n/a
   * - Chef Server
     - 12.x
     - GA
     - n/a
   * - Chef Provisioning
     - 1.6.0 or later
     - GA
     - n/a
   * - `InSpec <https://www.inspec.io/>`_
     - Latest 
     - GA
     - n/a
   * - `Habitat <https://www.habitat.sh/>`_
     - Latest
     - GA
     - n/a
   * - | Push Jobs Client
       | Push Jobs Server
     - 2.1.0 or later
     - GA
     - n/a
   * - Supermarket
     - 2.2.1 or later
     - GA
     - n/a
     
**Commercial**                                                             

.. list-table::
   :header-rows: 1
   :widths: 150, 450, 100, 100

   * - Product
     - Version
     - Lifecycle Status
     - EOL Date
   * - Chef Automate
     - 0.7.151 or later
     - GA
     - n/a
   * - Chef Backend
     - Latest
     - GA
     - n/a
   * - Chef Compliance
     - 0.9.0 or later
     - GA
     - n/a
   * - Chef Manage
     - 2.1.0 or later
     - GA
     - n/a
   * - Enterprise Chef
     - 11.2.2 or later
     - GA
     - n/a
   * - Reporting
     - 1.5.5 or later
     - GA
     - n/a
   * - Analytics
     - 1.5.0 or later
     - Deprecated
     - TBD
