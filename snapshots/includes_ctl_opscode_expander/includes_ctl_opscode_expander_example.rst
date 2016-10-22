.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For example, to view the aggregate queue backlog, enter the following:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/opscode-expander/
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     bin/opscode-expanderctl queue-depth

to return something similar to:

.. code-block:: bash

       total messages:       0
       average queue depth:  0.0
       max queue depth:      0
       min queue depth:      0

