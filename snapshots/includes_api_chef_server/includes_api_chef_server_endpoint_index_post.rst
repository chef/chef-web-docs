.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``POST`` method is used to return partial search results. For example, if a node has the following:

.. code-block:: none

   { 
     'x' => 'foo', 
     'kernel' => { 'a' => 1, 'foo' => 'bar', 'version' => [ 1, 2, 3 ] }
   }

a partial search query can be used to return something like:

.. code-block:: none

   { 'kernel_version' => [ 1, 2, 3 ] }

This method has the following parameters:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Parameter
     - Description
   * - ``q``
     - The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.
   * - ``rows``
     - The number of rows to be returned.
   * - ``sort``
     - The order in which search results are to be sorted.
   * - ``start``
     - The row at which return results begin.

**Request**

.. code-block:: none

   GET /organizations/NAME/search

with a request body similar to:

.. code-block:: none

   {
     'name' => [ 'name' ],
     'ip'   => [ 'ipaddress' ],
     'kernel_version' => [ 'kernel', 'version' ]
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "name": "latte",
     "ip": "123.4.5.6789",
     "kernel_version": {"linux": "1.2.3"}
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.
