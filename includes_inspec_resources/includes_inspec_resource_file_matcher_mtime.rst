.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``mtime`` matcher tests if the file modification time for the file matches the specified value:

.. code-block:: ruby

   its('mtime') { should eq 'October 31 2015 12:10:45' }

or:

.. code-block:: bash

   describe file('/').mtime.to_i do
     it { should <= Time.now.to_i }
     it { should >= Time.now.to_i - 1000}
   end
