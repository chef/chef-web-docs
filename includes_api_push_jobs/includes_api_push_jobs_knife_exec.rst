.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The easiest way to send commands to the |chef server| from your workstation is to use the ``knife exec`` subcommand.
Here is an example of making a basic ``knife exec`` command against a RESTful JSON API.

.. code-block:: bash

   $ knife exec -E 'api.get("/organizations/ORG_NAME/pushy/jobs/JOB_ID")'

For some |api push jobs| endpoints, you need to specify certain headers. To do that you simply pass a hash into the command.

.. code-block:: bash

   $ knife exec -E 'api.get("/organizations/ORG_NAME/pushy/jobs/JOB_ID/output/NODE_NAME/stdout", RAW, {"Accept" => "application/event-stream"})'

where ``RAW`` is a boolean indicating whether you want the raw body returned, or JSON inflated. For |api push jobs| endpoints, we recommend ``false``.

See `knife exec <https://docs.chef.io/knife_exec.html>`_ for detailed information on usage.
