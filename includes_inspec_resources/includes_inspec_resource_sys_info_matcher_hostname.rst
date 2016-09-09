.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``hostname`` matcher tests the host for which standard output is returned:

.. code-block:: ruby

   its('hostname') { should eq 'value' }
