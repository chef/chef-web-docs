.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To start orgmapper:

Log in to the server that is hosting the back-end. (In a high availability configuration, this should be the current primary server in that configuration.)

.. code-block:: bash

   $ /opt/opscode/bin/orgmapper

Next, query organizations, users, and so on similar to the following examples

.. code-block:: ruby

   orgmapper:0 > pp ORGS.all

or:

.. code-block:: ruby

   orgmapper:0 > pp ORGS['ORGNAME']

or:

.. code-block:: ruby

   orgmapper:0 > pp USERS.all

or:

.. code-block:: ruby

   orgmapper:0 > pp USERS['USER']

where (in each of the previous examples) ``ORGNAME`` is the name of the organization and ``USER`` is the name of the user.
