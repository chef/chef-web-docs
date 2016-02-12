.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To verify that FTP is disabled:

The contents if the ``inetd.conf`` file contain the following:

.. code-block:: text

   #ftp      stream   tcp   nowait   root   /usr/sbin/tcpd   in.ftpd -l -a
   #telnet   stream   tcp   nowait   root   /usr/sbin/tcpd   in.telnetd

and the following test is defined:

.. code-block:: ruby

   describe inetd_conf do
     its('ftp') { should eq nil }
     its('telnet') { should eq nil }
   end

Because both the ``ftp`` and ``telnet`` Internet services are commented out (``#``), both services are disabled. Consequently, both tests will return ``true``. However, if the ``inetd.conf`` file is set as follows:

.. code-block:: text

   ftp       stream   tcp   nowait   root   /usr/sbin/tcpd   in.ftpd -l -a
   #telnet   stream   tcp   nowait   root   /usr/sbin/tcpd   in.telnetd

then the same test will return ``false`` for ``ftp`` and the entire test will fail.
