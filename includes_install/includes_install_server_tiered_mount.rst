.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To build and mount the storage device on the backend server, do the following:

#. Create the file system. For example, an ``ext4`` type named ``tiered``:

   .. code-block:: bash
      
      $ mkfs.ext4 /dev/opscode/tiered

   then:

   .. code-block:: bash
      
      $ mkdir -p /var/opt/opscode

   and then:

   .. code-block:: bash
      
      $ mount /dev/opscode/tiered /var/opt/opscode

