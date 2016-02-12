.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following syntax:

.. code-block:: bash

   $ inspec detect (options)

For example, if the configuration on the target is:

.. code-block:: bash

   id=$( docker run -dti ubuntu:14.04 /bin/bash )

the following command:

.. code-block:: bash

   $ inspec detect -t docker://$id

will return:

.. code-block:: javascript

   {"family":"ubuntu","release":"14.04","arch":null}
