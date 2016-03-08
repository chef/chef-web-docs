.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Allowing |open ssl| to enforce |fips|-validated security may be enabled by using any of the following ways:

* Set the ``fips`` configuration setting to ``true`` in the |client rb| or |knife rb| files
* Set the ``--fips`` command-line option when running any |knife| command or the |chef client| executable
* Set the ``--fips`` command-line option when bootstrapping a node using the ``knife bootstrap`` command
