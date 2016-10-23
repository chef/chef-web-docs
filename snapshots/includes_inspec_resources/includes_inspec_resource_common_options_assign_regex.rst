.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use ``assignment_re`` to test a key value using a regular expression:

.. code-block:: ruby

   'key = value'

may be tested using the following regular expression, which determines assignment from key to value:

.. code-block:: ruby

   assignment_re: /^\s*([^=]*?)\s*=\s*(.*?)\s*$/
