.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|kitchen| may be used to test |policyfile| files. Add the following to |kitchen yml|:

.. code-block:: yaml

   provisioner:
     name: policyfile_zero

A named run-list may be used on a per-suite basis:

.. code-block:: yaml

   suites:
     - name: client
       provisioner:
         named_run_list: test_client_recipe
     - name: server
       provisioner:
         named_run_list: test_server_recipe

or globally:

.. code-block:: yaml

   provisioner:
     name: policyfile_zero
     named_run_list: integration_test_run_list
