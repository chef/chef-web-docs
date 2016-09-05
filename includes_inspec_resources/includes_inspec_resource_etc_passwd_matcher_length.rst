.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``length`` matcher tests the length of a password that appears in ``/etc/passwd``:

.. code-block:: ruby

   its('length') { should be <= 32 }

.. note:: This matcher is best used in conjunction with filters. For example:

   .. code-block:: ruby

      describe passwd.users('highlander') do
         its('length') { should_not be < 16 }
      end
