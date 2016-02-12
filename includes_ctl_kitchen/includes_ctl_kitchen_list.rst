.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``list`` subcommand to view the list of instances. Instances are based on the list of platforms in the |kitchen yml| file. |kitchen| will auto-name instances by combining a suite name with a platform name. For example, if a suite is named ``default`` and a platform is named ``ubuntu-10.04``, then the instance would be ``default-ubuntu-10.04``. This ensures that |kitchen| instances have safe |dns| and hostname records.