.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


For example, to match any 8.x version of Ohai, but not 7.x or 9.x:

.. code-block:: ruby

   ohai_version "~> 8"

Or matches any 8.x (or higher) version of Ohai:

.. code-block:: ruby

   ohai_version ">= 8"
