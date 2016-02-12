.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To view a list of all servers in the ``us-central2-a`` zone, including those that may not be managed by the |chef client|, enter:

.. code-block:: bash

   $ knife google server list -Z us-central2-a

to return something similar to the following:

.. code-block:: bash

   Name              Type           Image                 Public IP        Private IP      Disks               Zone           Status 
   chef-svr          n1-standard-1  gcel-12-04-v20130325  103.59.80.113    10.240.45.78                        us-central2-a  running
   chef-workstation  n1-standard-1  gcel-12-04-v20130325  103.59.85.188    10.240.9.140                        us-central2-a  running
   fuse-dev          n1-standard-1  gcel-12-04-v20130225  103.59.80.147    10.240.166.18   pd-fuse             us-central2-a  running
   magfs-c1          n1-standard-2  gcel-12-04-v20130225  103.59.87.217    10.240.61.92                        us-central2-a  running
   magfs-c2          n1-standard-2  gcel-12-04-v20130225  103.59.80.161    10.240.175.240                      us-central2-a  running
   magfs-c3          n1-standard-2  gcel-12-04-v20130325  178.255.120.69   10.240.34.197   jay-scratch         us-central2-a  running
   magfs-svr         n1-standard-4  gcel-12-04-v20130225  103.59.80.178    10.240.81.25    pd28g               us-central2-a  running
