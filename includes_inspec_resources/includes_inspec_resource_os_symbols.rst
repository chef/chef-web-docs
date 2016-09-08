.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``os[:family]`` to enable more granular testing of platforms, platform names, architectures, and releases.

Use any of the following platform-specific symbols to test for specific platforms:

* ``:aix``
* ``:bsd`` For platforms that are part of the |berkeley os| family: ``:darwin``, ``:freebsd``, ``:netbsd``, and ``:openbsd``.
* ``:debian``
* ``:hpux``
* ``:linux``. For platforms that are part of the |linux| family: ``:alpine``, ``:amazon``, ``:arch``, ``:coreos``, ``:exherbo``, ``:fedora``, ``:gentoo``, and ``:slackware``.
* ``:redhat``
* ``:solaris``. For platforms that are part of the |solaris| family: ``:nexentacore``, ``:omnios``, ``:openindiana``, ``:opensolaris``, and ``:smartos``.
* ``:suse``
* ``:unix``
* ``:windows``

For example, both of the following tests should have the same result:

.. code-block:: ruby

   if os[:family] == 'debian'
     describe port(69) do
       its('processes') { should include 'in.tftpd' }
     end
   elsif os[:family] == 'rhel'
     describe port(69) do
       its('processes') { should include 'xinetd' }
     end
   end

.. code-block:: ruby

   if os[:debian]
     describe port(69) do
       its('processes') { should include 'in.tftpd' }
     end
   elsif os[:rhel]
     describe port(69) do
       its('processes') { should include 'xinetd' }
     end
   end
