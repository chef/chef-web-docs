.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|reporting| has the following minimum requirements:

* |chef server| 12
* |chef client| version 11.6.0 (or later)

|reporting| can make use of an external database, but to do so |reporting| 1.5.5 or later is needed along with |chef server| 12.2.0 or later.

The |reporting| client is built into the |chef client| and can run on all platforms that |chef client| is supported on.

.. warning:: |reporting| does not work on |chef client| version 11.8.0; upgrade to |chef client| version 11.8.2 (or later) if |reporting| is being run in your organization.

.. warning:: |reporting| versions 1.5.5 or later are supported.
