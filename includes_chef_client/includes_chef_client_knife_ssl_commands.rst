.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef client| includes two |knife| commands for managing |ssl| certificates:

* Use :doc:`knife ssl check </knife_ssl_check>` to troubleshoot |ssl| certificate issues
* Use :doc:`knife ssl fetch </knife_ssl_fetch>` to pull down a certificate from the |chef server| to the |path trusted_certs| directory on the workstation.

After the workstation has the correct |ssl| certificate, bootstrap operations from that workstation will use the certificate in the |path trusted_certs| directory during the bootstrap operation.