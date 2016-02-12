.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``size`` matcher tests if a file's size matches, is greater than, or is less than the specified value. For example, equal:

.. code-block:: ruby

   its('size') { should eq 32375 }

Greater than:

.. code-block:: ruby

   its('size') { should > 64 }

Less than:

.. code-block:: ruby

   its('size') { should < 10240 }
