.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ kitchen verify

Returns:

.. code-block:: bash

   apache
     is awesome
     is installed (FAILED - 1)
   
     Failures:
   
       1) apache is installed
         Failure/Error: expect(package("httpd")).to be_installed
           expected Package "httpd" to be installed
           /bin/sh -c rpm\ -q\ httpd
           package httpd is not installed
