.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |ha| upgrade process is substantially more complicated than a |standalone| upgrade. Systems must be upgraded in a specific order, and key material generated during the first install must be copied around manually to the other nodes in the cluster by the user performing the upgrade. Also it is important to validate that services are down and kill any stray processes (this is for upgrading from old builds prior to 1.1.10).

