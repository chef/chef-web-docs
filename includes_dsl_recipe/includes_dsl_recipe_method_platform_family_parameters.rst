.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. This topic is currently commented out and needs to be validated before it can be uncommented.

The following parameters can be used with this method:

.. list-table::
   :widths: 100 500
   :header-rows: 1

   * - Parameter
     - Platforms
   * - ``aix``
     - |ibm aix|. All platform variants of |ibm aix| return ``aix``.
   * - ``arch``
     - |archlinux|
   * - ``darwin``
     - |darwin|. All platform variants of |darwin| return ``darwin``.
   * - ``debian``
     - |debian|, |mint|, |ubuntu|
   * - ``fedora``
     - |fedora|
   * - ``freebsd``
     - |freebsd|. All platform variants of |freebsd| return ``freebsd``.
   * - ``gentoo``
     - |gentoo|
   * - ``hpux``
     - |hpux|. All platform variants of |hpux| return ``hpux``.
   * - ``mac_os_x``
     - |mac os x|
   * - ``netbsd``
     - |netbsd|. All platform variants of |netbsd| return ``netbsd``.
   * - ``openbsd``
     - |open bsd|. All platform variants of |open bsd| return ``openbsd``.
   * - ``rhel``
     - |amazon linux|, |centos|, |oracle linux|, |scientific linux|, |redhat enterprise linux|.
   * - ``slackware``
     - |slackware|
   * - ``solaris``
     - |solaris|. For |solaris|-related platforms, the ``platform_family`` method does not support the |solaris| platform family and will default back to ``platform_family = platform``. For example, if the platform is |omnios|, the ``platform_family`` is ``omnios``, if the platform is |smartos|, the ``platform_family`` is ``smartos``, and so on. All platform variants of |solaris| return ``solaris``.
   * - ``suse``
     - |suse|, |suse els|.
   * - ``windows``
     - |windows|. All platform variants of |windows| return ``windows``.

.. note:: |ohai| collects platform information at the start of the |chef client| run and stores that information in the ``node['platform']`` attribute.
