.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

Use the following commands to remove the |chef dk| on |mac os x|.

To remove installed files:

.. code-block:: bash

   $ sudo rm -rf /opt/chefdk

To remove the system installation entry:

.. code-block:: bash

   $ sudo pkgutil --forget com.getchef.pkg.chefdk

To remove symlinks:

* For |chef client| version 12.x, under ``/usr/local/bin``:

  .. code-block:: bash

     $ sudo find /usr/local/bin -lname '/opt/chefdk/*' -delete

* For |chef client| version 11.x, under ``/usr/bin``:

  .. code-block:: bash

     $ sudo find /usr/bin -lname '/opt/chefdk/*' -delete
