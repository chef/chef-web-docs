.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for clock drift against named servers:

.. code-block:: ruby

   describe ntp_conf do
     its('driftfile') { should eq '/var/lib/ntp/ntp.drift' }
     its('server') { should eq [
       0.ubuntu.pool.ntp.org,
       1.ubuntu.pool.ntp.org,
       2.ubuntu.pool.ntp.org
     ] }
   end
