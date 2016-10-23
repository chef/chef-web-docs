.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use Nginx to monitor for services that may be returning 504 errors. Use the following command on a front-end machine:

.. code-block:: bash

   $ grep 'HTTP/1.1" 504' /var/log/opscode/nginx/access.log

and then extract the URLs and sort them by ``uniq`` count:

.. code-block:: bash

   $ grep 'HTTP/1.1" 504' nginx-access.log | cut -d' ' -f8 | sort | uniq -c | sort

In a large installation, restricting these results to a subset of results may be necessary:

.. code-block:: bash

   $ tail -10000 nginx-access.log | grep 'HTTP/1.1" 504' | cut -d' ' -f8 | sort | uniq -c | sort

