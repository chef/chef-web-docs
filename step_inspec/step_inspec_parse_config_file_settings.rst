.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a configuration setting:

.. code-block:: ruby

   describe parse_config_file('/path/to/file.conf') do
    its('PARAM_X') { should eq 'Y' }
   end
