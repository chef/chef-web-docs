.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``test`` subcommand to test one (or more) verified instances. Instances are based on the list of platforms and suites in the |kitchen yml| file. This subcommand will create a new instance (cleaning up a previous instance, if necessary), converge that instance, set up the test harness, verify the instance using that test harness, and then destroy the instance.

In general, use the ``test`` subcommand to verify the end-to-end quality of a cookbook. Use the ``converge`` and ``verify`` subcommands during the normal the day-to-day development of a cookbook.