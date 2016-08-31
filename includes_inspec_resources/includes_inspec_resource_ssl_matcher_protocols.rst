.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``protocols`` matcher tests the number of times the named user appears in ``/etc/shadow``:

.. code-block:: ruby

   its('protocols') { should eq 'ssl2' }

or:

.. code-block:: ruby

   describe ssl(port: 443).protocols('ssl2') do
     it { should_not be_enabled }
   end
