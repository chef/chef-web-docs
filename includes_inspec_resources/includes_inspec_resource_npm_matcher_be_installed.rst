.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_installed`` matcher tests if the named |gem| package and package version (if specified) is installed:

.. code-block:: ruby

   it { should be_installed }
