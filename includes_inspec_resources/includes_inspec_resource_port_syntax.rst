.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``port`` |inspec resource| block declares a port, and then depending on what needs to be tested, a process, protocol, process identifier, and its state (is it listening?):

.. code-block:: ruby

   describe port(514) do
     it { should be_listening }
     its('process') {should eq 'syslog'}
   end

where the ``process`` returns the process listening on port 514.
