.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|postgresql ctl| is the management tool for |postgresql|. It can be used to obtain information about data stored in |postgresql|. For more information about |postgresql ctl|, see http://www.postgresql.org/docs/manuals/, and then the doc set appropriate for the version of |postgresql| being used.

To connect to the |postgresql| database, run the following command:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/postgresql/
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     bin/psql -U opscode_chef

.. warning:: Connecting to the |postgresql| database should only be done when directed by |company_name| support services.


