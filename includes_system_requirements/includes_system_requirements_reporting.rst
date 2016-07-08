.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|reporting| has the following minimum requirements:

* |chef server| 12
* |chef server oec| version 11.0.1 (or later)
* |chef server oec| 11.1.7 (and earlier) should use |reporting| 1.1.2 (or earlier); |chef server oec| 11.1.8 should use |reporting| 1.1.5 (and later)
* |chef client| version 11.6.0 (or later), with the exception of |chef client| version 11.8.0

|reporting| can make use of an external database, but to do so |reporting| 1.5.5 or later is needed along with |chef server| 12.2.0 or later or |chef server oec| 11.3.2 or later.

The |reporting| client is built into the |chef client| and can run on all platforms that |chef client| is supported on.

.. warning:: |reporting| does not work on |chef client| version 11.8.0; upgrade to |chef client| version 11.8.2 (or later) if |reporting| is being run in your organization.

.. warning:: |reporting| requires version 1.0.1 (or later) when the |chef server oec| is run in a high availability configuration.

.. warning:: |reporting| versions 1.5.2, 1.5.3, and 1.5.4 were removed from availability due to incompatibilities with |chef server| 12.2.0. |reporting| 1.5.5 replaced these versions.
