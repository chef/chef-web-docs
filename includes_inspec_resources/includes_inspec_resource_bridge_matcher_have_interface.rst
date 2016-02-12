.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``have_interface`` matcher tests if the named interface is defined for the network bridge:

.. code-block:: ruby

   it { should have_interface 'eth0' }
