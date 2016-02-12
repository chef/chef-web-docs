.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``auditd_conf`` |inspec resource| block declares configuration settings that should be tested:

.. code-block:: ruby

   describe auditd_conf('path') do
     its('keyword') { should eq 'value' }
   end

where

* ``'keyword'`` is a configuration setting defined in the ``auditd.conf`` configuration file
* ``('path')`` is the non-default path to the ``auditd.conf`` configuration file
* ``{ should eq 'value' }`` is the value that is expected
