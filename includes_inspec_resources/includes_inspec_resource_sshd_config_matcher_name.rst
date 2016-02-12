.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``name`` matcher tests the value of ``name`` as read from ``sshd_config`` versus the value declared in the test:

.. code-block:: ruby

   its('name') { should eq 'foo' }

or:

.. code-block:: ruby

   its('name') {should include('bar') }
