=====================================================
Platforms and Supported Versions
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/platforms.rst>`__

Chef software is supported on the various operating systems (platforms) listed below. To see which versions of our software we currently support, see the :ref:`versions` section.

Platforms
=====================================================

The sections below list the platforms that Chef Software Inc. supports. Commercial support is divided into two sections: mainstream support, and extended support. There are also several platforms for which support is only available through the community.

Any platforms or versions not explicitly listed here are unsupported, both commercially and by the community.

Mainstream support generally follows Chef community support policies which also track the lifecycle policies of the underlying operating system vendor. Extended support is offered by Chef Software Inc. in scenarios where, due to customer demand, we offer support beyond the lifecycle defined by the underlying operating system vendor.

In all cases (beyond community support), a maintenance contract with Chef Software Inc. is required in order to open support tickets and get SLA-based support from our support desk.

Chef Client
------------------------------------------------------

Mainstream Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the mainstream support platforms and versions for Chef Client:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - AIX
     - ``ppc64``
     - ``6.1`` (TL6 or higher, recommended), ``7.1`` (TL0 SP3 or higher, recommended), ``7.2``
   * - Amazon Linux
     -
     - current version
   * - CentOS
     - ``x86_64``
     - ``6``, ``7``
   * - FreeBSD
     - ``i386``, ``amd64``
     - ``9``, ``10``
   * - macOS
     - ``x86_64``
     - ``10.9``, ``10.10``, ``10.11``, ``10.12``
   * - Oracle Linux
     - ``x86_64``
     - ``6``, ``7``
   * - Red Hat Enterprise Linux
     - ``x86_64``, ``s390x``, ``ppc64le``, ``ppc64be``
     - ``6``, ``7``
   * - Solaris
     - ``sparc``, ``x86``
     - ``10 1\13`` (``"10U11"``), ``11.2``, ``11.3`` 
   * - SUSE Enterprise Linux Server
     - ``x86_64``, ``s390x``, ``ppc64le``, ``ppc64be``
     - ``11 SP4``, ``12 SP1``
   * - Ubuntu
     - ``x86``, ``x86_64``
     - ``12.04``, ``14.04``, ``16.04``
   * - Microsoft Windows
     - ``x86``, ``x86_64``
     - ``2008r2``, ``2012``, ``2012r2``, ``2016``, ``7``, ``8``, ``8.1``, ``10``

Extended Support
++++++++++++++++++++++++++++++++++++++++++++++++++++
The following table lists the extended support platforms for the chef-client. There may be an extra cost to purchase extended support subscriptions, and a limitation on the service-level agreement (SLA) for these platforms. Please consult your Chef Software account representative for more details.

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``i386``, ``x86_64``
     - ``5``
   * - Oracle Enterprise Linux
     - ``i386``, ``x86_64``
     - ``5``
   * - Red Hat Enterprise Linux
     - ``i386``, ``x86_64``
     - ``5``

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
     - ``i386``, ``x86-64``
     - ``5``, ``6``, ``7``

Chef DK
------------------------------------------------------

Mainstream Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the mainstream support platforms and versions for the Chef Development Kit (Chef DK):

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
     - ``12.04``, ``14.04``, ``16.04``
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
.. tag adopted_platforms_server

Mainstream Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the mainstream support platforms and versions for the Chef Server:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6.x``, ``7.x``
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

Extended Support
++++++++++++++++++++++++++++++++++++++++++++++++++++
The following table lists the extended support platforms for the Chef Server. There may be an extra cost to purchase extended support subscriptions, and a limitation on the service-level agreement (SLA) for these platforms. Please consult your Chef Software account representative for more details.

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``5``
   * - Oracle Enterprise Linux
     - ``x86_64``
     - ``5``
   * - Red Hat Enterprise Linux
     - ``x86_64``
     - ``5``

Chef Automate Server
----------------------------------------------------

Mainstream Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

The following table lists the mainstream support platforms and versions for Chef Automate Server. Do not mix platforms or platform versions within the Chef Automate cluster.

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``x86_64``
     - ``6``, ``7``
   * - Oracle Linux
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
     - ``12.04``, ``14.04``, ``16.04``

Chef Automate Job Runners
----------------------------------------------------

Mainstream Support
++++++++++++++++++++++++++++++++++++++++++++++++++++

Chef Automate Job Runners are supported on the Mainstream Support platforms for Chef Automate Server listed above as well as on the following platforms:

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

The following table lists the mainstream support platforms for the Chef push jobs client:

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

**Open Source**                                                            

+----------------------+-----------------------------------------------------------------------------------------------------------+       
| Product              | Version                                                                                                   |
+======================+===========================================================================================================+ 
| Chef Client          | 12.0.0 or later                                                                                           | 
+----------------------+-----------------------------------------------------------------------------------------------------------+
| Chef DK              | 1.0.3 or later                                                                                            | 
+----------------------+-----------------------------------------------------------------------------------------------------------+
| Chef Server          | 12.0.0 or later                                                                                           | 
+----------------------+-----------------------------------------------------------------------------------------------------------+ 
| Chef Provisioning    | 1.6.0 or later                                                                                            | 
+----------------------+-----------------------------------------------------------------------------------------------------------+
| InSpec               | Current minor version - 1 or later  (e.g. 1.32 when the current version is 1.33)                          |
+                      +                                                                                                           +
|                      | See the `Changelog <https://github.com/chef/inspec/blob/master/CHANGELOG.md>`__ for latest InSpec versions|
+----------------------+-----------------------------------------------------------------------------------------------------------+
| Habitat              | No supported version at this time                                                                         | 
+----------------------+-----------------------------------------------------------------------------------------------------------+    
| Push Jobs Client     |                                                                                                           | 
+----------------------+ 2.1.0 or later                                                                                            |
| Push Jobs Server     |                                                                                                           | 
+----------------------+-----------------------------------------------------------------------------------------------------------+  
| Supermarket          | 2.2.1 or later                                                                                            | 
+----------------------+-----------------------------------------------------------------------------------------------------------+ 


**Commercial**                                                             

+----------------------+--------------------------------------------------+ 
| Product              | Version                                          |
+======================+==================================================+ 
| Chef Automate        | 0.7.151 or later                                 | 
+----------------------+--------------------------------------------------+
| Chef Backend         | Latest                                           | 
+----------------------+--------------------------------------------------+  
| Chef Compliance      | 0.9.0 or later                                   | 
+----------------------+--------------------------------------------------+
| Chef Manage          | 2.1.0 or later                                   | 
+----------------------+--------------------------------------------------+ 
| Enterprise Chef      | 11.2.2 or later                                  | 
+----------------------+--------------------------------------------------+
| Reporting            | 1.5.5 or later                                   | 
+----------------------+--------------------------------------------------+
| Analytics            | No longer supported for new installations        | 
+----------------------+--------------------------------------------------+
