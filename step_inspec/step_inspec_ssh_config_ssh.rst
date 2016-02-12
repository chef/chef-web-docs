.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test SSH configuration:

.. code-block:: ruby

  describe ssh_config do
    its('Host') { should eq '*' }
    its('Tunnel') { should eq nil }
    its('SendEnv') { should eq 'LANG LC_*' }
    its('HashKnownHosts') { should eq 'yes' }
  end
