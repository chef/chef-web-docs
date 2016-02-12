.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test SSH protocols:

.. code-block:: ruby

  describe sshd_config do
    its('Port') { should eq '22' }
    its('UsePAM') { should eq 'yes' }
    its('ListenAddress') { should eq nil }
    its('HostKey') { should eq [
        '/etc/ssh/ssh_host_rsa_key',
        '/etc/ssh/ssh_host_dsa_key',
        '/etc/ssh/ssh_host_ecdsa_key',
      ] }
  end
