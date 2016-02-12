.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This |inspec resource| supports the following options for parsing configuration data. Use them in an ``options`` block stated outside of (and immediately before) the actual test:

.. code-block:: ruby

   options = {
       assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
       multiple_values: true
     }
   describe parse_config_file('path/to/file',  options) do
     its('setting') { should eq 1 }
   end
