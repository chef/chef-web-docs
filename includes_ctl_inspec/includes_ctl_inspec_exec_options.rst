.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


This subcommand has additional options:

``--attrs PATH``
   Use to load a |yaml| file at the specified path. This file contains attribute values that are required to run a test successfully, such as a password or user name.

``--color``
   Use to specify if color should be used in output.

``--controls``
   Use to specify an array of controls to be run. Any control not listed in the array will be ignored.

``--format``
   Use to specify the formatter. Possible values: ``cli``, ``documentation``, ``json``, ``json-min``, or ``progress``.

``--id``
   Use to attach a profile identifier to all test results.
