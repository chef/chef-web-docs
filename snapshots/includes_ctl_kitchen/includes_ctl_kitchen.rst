.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


kitchen is the command-line tool for Kitchen, an integration testing tool used by the chef-client. Kitchen runs tests against any combination of platforms using any combination of test suites. Each test, however, is done against a specific instance, which is comprised of a single platform and a single set of testing criteria. This allows each test to be run in isolation, ensuring that different behaviors within the same codebase can be tested thoroughly before those changes are committed to production.

.. note:: Any Kitchen subcommand that does not specify an instance will be applied to all instances.
