.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``knife exec`` subcommand can be used to make authenticated API requests to the |chef server| using the following methods:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Method
     - Description
   * - ``api.delete``
     - Use to delete an object from the |chef server|.
   * - ``api.get``
     - Use to get the details of an object on the |chef server|.
   * - ``api.post``
     - Use to add an object to the |chef server|.
   * - ``api.put``
     - Use to update an object on the |chef server|.

These methods are used with the ``-E`` option, which executes that string locally on the workstation using |chef shell|. These methods have the following syntax:

.. code-block:: bash

   $ knife exec -E 'api.method(/endpoint)'

where:

* ``api.method`` is the corresponding authentication method --- ``api.delete``, ``api.get``, ``api.post``, or ``api.put``
* ``/endpoint`` is an endpoint in the |api chef server|

For example, to get the data for a node named "Example_Node":

.. code-block:: bash

   $ knife exec -E 'puts api.get("/nodes/Example_Node")'

and to ensure that the output is visible in the console, add the ``puts`` in front of the API authorization request:

.. code-block:: bash

   $ knife exec -E 'puts api.get("/nodes/Example_Node")'

where ``puts`` is the shorter version of the ``$stdout.puts`` predefined variable in |ruby|.

The following example shows how to add a client named "IBM305RAMAC" and the ``/clients`` endpoint, and then return the private key for that user in the console:

.. code-block:: bash

   $ client_desc = {
       "name"  => "IBM305RAMAC",
       "admin" => false
     }
     
     new_client = api.post("/clients", client_desc)
     puts new_client["private_key"]
