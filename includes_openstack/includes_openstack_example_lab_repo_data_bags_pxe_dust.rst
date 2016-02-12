.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The `pxe_dust <http://ckbk.it/pxe_dust>`_ cookbook uses a ``pxe_dust`` data bag to track which operating systems to install and what configuration options are used. Because the machines in the lab are quite diverse, there are individidual data bag items for machines that have unique configurations (ie. 32-bit vs. 64-bit or boot eth1 vs. eth0).

