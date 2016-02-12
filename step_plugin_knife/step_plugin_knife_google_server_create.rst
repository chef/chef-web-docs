.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To create a server:

.. code-block:: bash

   $ knife google server create www1 -m n1-standard-1 
       -I centos-6-v20130325 -Z us-central2-a -i ~/.ssh/id_rsa -x jdoe