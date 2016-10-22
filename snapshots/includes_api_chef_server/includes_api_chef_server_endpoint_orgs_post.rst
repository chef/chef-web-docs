.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``POST`` method is used to create an organization on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations

with a request body similar to:

.. code-block:: javascript

   {
     "name": "chef",
     "full_name": "Chef Software, Inc.",
   }

where:

* ``name`` must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``.
* ``full_name`` must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``Chef Software, Inc.``.

.. note:: An organization isn't usable until a user that belongs to the ``admins`` group is associated with the organization.

**Response**

The response is similar to:

.. code-block:: javascript

   { "org_name": "https://url/for/org_name" }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Unauthorized. The user who made the request is not authorized to perform the action.
