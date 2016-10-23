.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


psql is the management tool for PostgreSQL. It can be used to obtain information about data stored in PostgreSQL. For more information about psql, see http://www.postgresql.org/docs/manuals/, and then the doc set appropriate for the version of PostgreSQL being used.

To connect to the PostgreSQL database, run the following command:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/postgresql/
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     bin/psql -U opscode_chef

.. warning:: Connecting to the PostgreSQL database should only be done when directed by Chef support services.


