.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |inspec resource| matches any service that is listed in the ``ntp.conf`` file:

.. code-block:: ruby

   its('server') { should_not eq nil }

or:

.. code-block:: ruby

   its('restrict') { should include '-4 default kod notrap nomodify nopeer noquery'}

For example:

.. code-block:: ruby

   describe ntp_conf do
     its('server') { should_not eq nil }
     its('restrict') { should include '-4 default kod notrap nomodify nopeer noquery'}
   end
