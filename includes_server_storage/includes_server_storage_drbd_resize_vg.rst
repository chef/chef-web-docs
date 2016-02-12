.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Resize the volume group on both backend systems. Run the following commands and replace ``sdb1`` for the correct device name:

.. code-block:: bash

   pvcreate /dev/sdb1

and then:

.. code-block:: bash

   vgextend opscode /dev/sdb1
