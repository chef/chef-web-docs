.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``port`` |inspec resource| block declares a port, and then depending on what needs to be tested, a process, protocol, process identifier, and its state (is it listening?):

.. code-block:: ruby

   describe port(514) do
     it { should be_listening }
     its('processes') {should include 'syslog'}
   end

where the ``processes`` returns the processes listening on port 514.

A filter may specify an attribute:

.. code-block:: ruby

   describe port.where { protocol =~ /tcp/ && port > 22 && port < 80 } do
     it { should_not be_listening }
   end

where

* ``.where{}`` specifies a block in which one (or more) attributes---``port``, ``address``, ``protocol``, ``process``, ``pid``, or ``listening?``----scope the test to ports that match those attributes

For example, to test if the |ssh| daemon is available on a |linux| machine via the default port (22):

.. code-block:: ruby

   describe port(22) do
     its('processes') { should include 'sshd' }
     its('protocols') { should include 'tcp' }
     its('addresses') { should include '0.0.0.0' }
   end
