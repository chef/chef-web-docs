.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To verify if the alphabetic parts of a FQDN are all lowercase, run the following command:

.. code-block:: bash

   $ hostname -f | grep -E '^([[:digit:]]|[[:lower:]]|\.|-|_)+$' && echo yes

If the hostname is all lowercase, it will return something like:

.. code-block:: bash

   mychefserver.example.com
   yes

If the hostname's alphabetic parts are not all lowercase, it must be configured so that they are.
