.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``converge`` subcommand to converge one (or more) instances. Instances are based on the list of platforms in the |kitchen yml| file. This process will install the |chef client| on an instance using the |omnibus installer|, upload cookbook files and minimal configuration to the instance, and then start a |chef client| run using the run-list and attributes specified in the |kitchen yml| file.

|kitchen| will skip unnecessary steps. For example, if the |chef client| is already installed to the instance, |kitchen| will not re-install the |chef client|. That said, |kitchen| will always upload the cookbook files and minimal configuration. This ensures that cookbook testing is being done correctly.

The following exit codes are used by |kitchen|:

* ``0`` means the operation was successful
* Any non-zero value means at least one part of the operation was unsuccessful

In general, use the ``test`` subcommand to verify the end-to-end quality of a cookbook. Use the ``converge`` and ``verify`` subcommands during the normal the day-to-day development of a cookbook.