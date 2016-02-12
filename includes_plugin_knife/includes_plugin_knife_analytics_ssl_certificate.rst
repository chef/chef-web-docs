.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |subcommand knife analytics| subcommand requires the |ssl| certificate for |chef analytics| to be present on the workstation from which commands will be run. Fetch the |ssl| certificate from |chef analytics| by using the |subcommand knife ssl_fetch| command:

.. code-block:: bash

   $ knife ssl fetch ANALYTICS_URL

For example:

.. code-block:: bash

   $ knife ssl fetch https://ec2-52-27-166-146.us-west-2.compute.amazonaws.com
