.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``selinux_label`` matcher tests if the |selinux| label for a file matches the specified value:

.. code-block:: ruby

   its('selinux_label') { should eq 'system_u:system_r:httpd_t:s0' }
