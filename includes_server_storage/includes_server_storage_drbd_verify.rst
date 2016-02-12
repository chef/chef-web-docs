.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To verify the results of resizing |drbd|, run the following commands and compare the results to the same data that was collected prior to resizing |drbd|:

.. code-block:: bash

   sudo lvdisplay -v --units 4096k /dev/opscode/drbd

and then:

.. code-block:: bash

   df -k /var/opt/opscode/drbd/data
