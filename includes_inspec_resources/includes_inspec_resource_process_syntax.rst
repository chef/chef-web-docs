.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``processes`` |inspec resource| block declares the name of the process to be tested, and then declares one (or more) property/value pairs:

.. code-block:: ruby

   describe processes('process_name') do
     its('property_name') { should eq 'property_value' }
   end

where

* ``processes('process_name')`` must specify the name of a process that is running on the system
* Multiple properties may be tested; for each property to be tested, use an ``its('property_name')`` statement
