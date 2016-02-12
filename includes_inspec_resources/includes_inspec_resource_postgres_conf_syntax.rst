.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``postgres_conf`` |inspec resource| block declares one (or more) settings in the ``postgresql.conf`` file, and then compares the setting in the configuration file to the value stated in the test:

.. code-block:: ruby

   describe postgres_conf('path') do
     its('setting') { should eq 'value' }
   end

where

* ``'setting'`` specifies a setting in the ``postgresql.conf`` file
* ``('path')`` is the non-default path to the ``postgresql.conf`` file (optional)
* ``should eq 'value'`` is the value that is expected
