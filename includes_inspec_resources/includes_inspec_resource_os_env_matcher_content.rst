.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``content`` matcher return the value of the environment variable:

.. code-block:: ruby

   its('content') { should eq '/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin' }
