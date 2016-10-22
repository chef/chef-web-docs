.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test owner and group permissions:

.. code-block:: ruby

  describe ssh_config do
    its('owner') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
