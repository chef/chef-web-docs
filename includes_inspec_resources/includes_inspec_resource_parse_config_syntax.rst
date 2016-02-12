.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``parse_config`` |inspec resource| block declares the location of the configuration setting to be tested, and then what value is to be tested. Because this |inspec resource| relies on arbitrary configuration files, the test itself is often arbitrary and relies on custom |ruby| code:

.. code-block:: ruby

   output = command('some-command').stdout

   describe parse_config(output, { data_config_option: value } ) do
     its('setting') { should eq 1 }
   end

or:

.. code-block:: ruby

   audit = command('/sbin/auditctl -l').stdout
     options = {
       assignment_re: /^\s*([^:]*?)\s*:\s*(.*?)\s*$/,
       multiple_values: true
     }

   describe parse_config(audit, options) do
     its('setting') { should eq 1 }
   end

where each test

* Must declare the location of the configuration file to be tested
* Must declare one (or more) settings to be tested
* May run a command to ``stdout``, and then run the test against that output
* May use options to define how configuration data is to be parsed
