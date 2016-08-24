.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``ini`` |inspec resource| block declares the configuration settings to be tested:

.. code-block:: ruby

   describe ini('path') do
     its('setting_name') { should eq 'value' }
   end

where

* ``'setting_name'`` is a synchronization setting defined in the INI file
* ``('path')`` is the path to the INI file
* ``{ should eq 'value' }`` is the value that is expected
