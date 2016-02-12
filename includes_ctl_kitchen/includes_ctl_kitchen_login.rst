.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``login`` subcommand to log in to a single instance. Instances are based on the list of platforms and suites in the |kitchen yml| file. After logging in successfully, the instance can be interacted with just like any other virtual machine, including adding or removing packages, starting or stopping services, and so on. It's a sandbox. Make any change necessary to help improve the coverage for cookbook testing.