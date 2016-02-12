.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``shell`` matcher tests the path to the default shell for the user:

.. code-block:: ruby

   its('shell') { should eq '/bin/bash' }
