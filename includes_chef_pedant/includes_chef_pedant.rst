.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|chef pedant| is an integration test suite for |chef server|. |chef pedant| has a series of built-in integration tests that can be used to validate the initial installation and configuration of the |chef server|. In certain cases, using |chef pedant| at the request of |company_name| support will help to debug issues. Generally, |chef pedant| is not a tool that will run on a regular basis in a production environment.

The ``test`` sub-command in the ``chef-server-ctl`` tool can be used to execute |chef pedant|. By default, only a subset of the available test are run unless the ``-all`` flag is included in the command. For example:

.. code-block:: bash

   chef-server-ctl test

or:

.. code-block:: bash

   chef-server-ctl test --all


