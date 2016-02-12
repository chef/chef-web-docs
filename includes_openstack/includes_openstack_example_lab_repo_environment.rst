.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The `lab Environment <https://github.com/mattray/lab-repo/blob/master/environments/lab.rb>`_  provides overridden attributes.

* The ``apt`` attributes are for restricting search to the lab.
* The ``authorization`` attributes are for configuring |sudo cmd| to not require a password, include the sudoers.d directory and add the 'mray' user to sudoers.
* The ``dnsmasq`` attributes are for configuring DHCP, DNS and TFTP on the private 'admin' network.
* The ``pxe_dust`` attribute is to lock down the |chef client| version.

