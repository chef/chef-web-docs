.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following parameters can be used with this method:

.. list-table::
   :widths: 100 500
   :header-rows: 1

   * - Parameter
     - Platforms
   * - ``aix``
     - AIX. All platform variants of AIX return ``aix``.
   * - ``arch``
     - Arch Linux
   * - ``debian``
     - Debian, Linux Mint, Ubuntu
   * - ``fedora``
     - Fedora
   * - ``freebsd``
     - FreeBSD. All platform variants of FreeBSD return ``freebsd``.
   * - ``gentoo``
     - Gentoo
   * - ``hpux``
     - HP-UX. All platform variants of HP-UX return ``hpux``.
   * - ``mac_os_x``
     - Mac OS X
   * - ``netbsd``
     - NetBSD. All platform variants of NetBSD return ``netbsd``.
   * - ``openbsd``
     - OpenBSD. All platform variants of OpenBSD return ``openbsd``.
   * - ``slackware``
     - Slackware
   * - ``solaris``
     - Solaris. For Solaris-related platforms, the ``platform_family`` method does not support the Solaris platform family and will default back to ``platform_family = platform``. For example, if the platform is OmniOS, the ``platform_family`` is ``omnios``, if the platform is SmartOS, the ``platform_family`` is ``smartos``, and so on. All platform variants of Solaris return ``solaris``.
   * - ``suse``
     - openSUSE, SUSE Enterprise Linux Server.
   * - ``windows``
     - Microsoft Windows. All platform variants of Microsoft Windows return ``windows``.

.. note:: Ohai collects platform information at the start of the chef-client run and stores that information in the ``node['platform']`` attribute.
