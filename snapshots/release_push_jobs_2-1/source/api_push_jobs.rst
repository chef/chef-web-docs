.. THIS PAGE DOCUMENTS Push Jobs version 2.1

=====================================================
Push Jobs API
=====================================================

The Push Jobs API is used to create jobs and retrieve status using Chef push jobs, a tool that pushes jobs against a set of nodes in the organization.
All requests are signed using the Chef server API and the validation key on the workstation from which the requests are made.

Endpoints
=====================================================
Each authentication request must include ``/organizations/organization_name/pushy/`` as part of the name for the endpoint.
For example: ``/organizations/organization_name/pushy/jobs/ID`` or ``/organizations/organization_name/pushy/node_states``.

.. note:: The easiest way to send commands to the Chef server from your workstation is to use the ``knife exec`` subcommand.
          Here is an example of making a basic ``knife exec`` command against a RESTful JSON API.
          
          .. code-block:: bash
          
             $ knife exec -E 'api.get("/organizations/ORG_NAME/pushy/jobs/JOB_ID")'
          
          For some Push Jobs API endpoints, you need to specify certain headers. To do that you simply pass a hash into the command.
          
          .. code-block:: bash
          
             $ knife exec -E 'api.get("/organizations/ORG_NAME/pushy/jobs/JOB_ID/output/NODE_NAME/stdout", RAW, {"Accept" => "application/event-stream"})'
          
          where ``RAW`` is a boolean indicating whether you want the raw body returned, or JSON inflated. For Push Jobs API endpoints, we recommend ``false``.
          
          See `knife exec <https://docs.chef.io/knife_exec.html>`_ for detailed information on usage.


connect/NODE_NAME
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_node_name.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_node_name_get.rst


jobs
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_post_2-1.rst


jobs/ID
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_id.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_id_get_2-1.rst


jobs/ID/output/NODE_NAME/CHANNEL
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_output.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_output_get.rst


jobs_status_feed
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_status_feed.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_status_feed_get.rst


jobs_status_feed/JOBID
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_status_feed_id.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_jobs_status_feed_id_get.rst


node_states
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_node_states.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_node_states_get.rst


node_states/NODE_NAME
-----------------------------------------------------
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_node_name.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_push_jobs/includes_api_push_jobs_endpoint_node_name_get.rst
