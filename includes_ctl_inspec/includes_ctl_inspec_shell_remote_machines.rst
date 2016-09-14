.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


The |inspec| shell may connect to remote machines. Use the ``--target`` and ``--key-files`` options as required.

To login to a remote machine via SSH as the ``root`` user:

.. code-block:: ruby

   $ inspec shell -target ssh://root@192.168.64.2:11022

To login to a hostname as a user via SSH with a key:

.. code-block:: ruby

   $ inspec shell -target ssh://user@hostname:1234 -key-files /path/to/user_key

To login to a |windows| machine as a user via WinRM:

.. code-block:: ruby

   $ inspec shell -target winrm://UserName:Password@windowsmachine:1234

To login to a |docker| container:

.. code-block:: ruby

   $ inspec shell -target docker://container_id
