.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To see a list of all zones, including status and maintenance windows, enter:

.. code-block:: bash

   $ knife google zone list

to return something similar to the following:

.. code-block:: bash

    Name            Status  Servers  Disks  Maintainance Window                                   
    europe-west1-a  up      0        0      2013-08-03 19:00:00 +0000 to 2013-08-18 19:00:00 +0000
    europe-west1-b  up      0        0      2013-05-11 19:00:00 +0000 to 2013-05-26 19:00:00 +0000
    us-central1-a   up      0        1      2013-08-17 19:00:00 +0000 to 2013-09-01 19:00:00 +0000
    us-central1-b   up      0        0      2013-06-08 19:00:00 +0000 to 2013-06-23 19:00:00 +0000
    us-central2-a   up      10       6      2013-05-25 19:00:00 +0000 to 2013-06-09 19:00:00 +0000
