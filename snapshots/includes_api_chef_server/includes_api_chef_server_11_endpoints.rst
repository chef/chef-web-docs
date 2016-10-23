.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Each authentication request must include ``/organizations/NAME`` as part of the name for the endpoint. For example, the full endpoint for getting a list of roles:

.. code-block:: html

   GET /organizations/NAME/roles

and for the same request, but to the open source Chef server:

.. code-block:: html

   GET /roles
