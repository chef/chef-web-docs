.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test parameters for bond0:

.. code-block:: ruby

   describe bond('bond0') do
     its('Bonding Mode') { should eq 'IEEE 802.3ad Dynamic link aggregation' }
     its('Transmit Hash Policy') { should eq 'layer3+4 (1)' }
     its('MII Status') { should eq 'up' }
     its('MII Polling Interval (ms)') { should eq '100' }
     its('Up Delay (ms)') { should eq '0' }
     its('Down Delay (ms)') { should eq '0' }
   end
