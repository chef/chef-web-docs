.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

All machines in a |chef server| deployment (including a standalone |chef analytics| machine) have the following requirements.

For all deployments:

* 64-bit architecture

For a standalone deployment:

* 4 total cores, 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs
* 4 GB of RAM; 8 GB of RAM for |chef analytics|
* 5 GB of free disk space in ``/opt``
* 5 GB of free disk space in ``/var``

For a tiered deployment:

* 8 total cores 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 16GB RAM
* 2 x 300GB SAS RAID1 drives
* Hardware RAID card
* 1 GigE NIC interface
* 20 GB of free disk space in ``/opt``
* 40 GB of free disk space in ``/var``
* A back-end server; all other systems will be front-end servers.

For a high availability deployment:

* 8 total cores 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 16GB RAM
* 2 x 300GB SAS RAID1 drives
* Hardware |raid| card
* 1 x GigE NIC interface
* 20 GB of free disk space in ``/opt``
* 40 GB of free disk space in ``/var``
* Two back-end servers; as many front-end servers as required.

.. note:: Front end machines, when load balanced, may have fewer than 4 cores and 4 GB of RAM.

.. warning:: The |chef server| MUST NOT use a network file system of any type---virtual or physical---for backend storage. The |chef server| database operates quickly. The behavior of operations, such as the writing of log files, will be unpredictable when run over a network file system.

