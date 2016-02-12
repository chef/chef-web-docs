.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``have_rule`` matcher tests the named rule against the information in the ``iptables`` file:

.. code-block:: ruby

   it { should have_rule('RULE') }
