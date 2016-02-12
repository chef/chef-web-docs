.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``ntp_conf`` |inspec resource| block declares the synchronization settings that should be tested:

.. code-block:: ruby

   describe ntp_conf('path') do
     its('setting_name') { should eq 'value' }
   end

where

* ``'setting_name'`` is a synchronization setting defined in the ``ntp.conf`` file
* ``('path')`` is the non-default path to the ``ntp.conf`` file
* ``{ should eq 'value' }`` is the value that is expected
