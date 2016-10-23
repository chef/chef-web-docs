.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to start a job.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/ORG_NAME/pushy/jobs

with a request body similar to:

.. code-block:: javascript

   {
     "command": "bash $PUSHY_JOB_FILE",
     "run_timeout": 300,
     "nodes": ["NODE1", "NODE2", "NODE3", "NODE4", "NODE5", "NODE6"],
     "quorum":
     "user": "rebecca",
     "dir": "/home/rebecca",
     "env": {
       "FOO": "bears"
     },
     "file": "raw:#!/bin/bash\necho \"Hello, I am $USER and I like $FOO\""
     "capture_output": true
   }

where:

* ``command`` is the command to be executed during the run.
* ``run_timeout`` is the number of seconds to wait for the run to complete.
* ``nodes`` is the list of node names you wish to run the job on.
* ``quorum`` is the number of nodes from ``nodes`` that must acknowledge the request in order for the job to run.
* ``user`` is the user you wish to run the job as on the node.
* ``dir`` is the directory you wish to run the job from on the node.
* ``env`` is a JSON object of key-value pairs to assign to the environment.
* ``file`` is a string that will be stored as a file on each node, with the path provided to the command as an environment variable.

    .. note:: The string has a required prefix of ``raw:`` or ``base64:``, indicating the encoding (if any) of the contents. The path to this file will be made available via the ``CHEF_PUSH_JOB_FILE`` environment variable.

* ``capture_output`` is a boolean indicating whether to capture the STDOUT and STDERR for this job. Capture is enabled on a per-job basis, meaning that it will affect all nodes that run the job. It is not possible to enable capture on a per-node basis.

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "id": "aaaaaaaaaaaa25fd67fa8715fd547d3d"
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.
