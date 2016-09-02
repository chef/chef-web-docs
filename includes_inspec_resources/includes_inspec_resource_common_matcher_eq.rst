.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``eq`` matcher to test the equality of two values: ``its('Port') { should eq '22' }``.

.. note:: ``its('Port') { should eq 22 }`` will fail because ``22`` is not a string value! Use the ``cmp`` matcher for less restrictive value comparisons.
