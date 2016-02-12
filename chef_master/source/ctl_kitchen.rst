=====================================================
|kitchen_cli| (executable)
=====================================================

.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen.rst

.. note:: This topic details functionality that is packaged with |chef dk|. See http://kitchen.ci/docs/getting-started/ for more information about |kitchen|.

Fuzzy Matching
=====================================================
Fuzzy matching can be used with all commands because |kitchen_cli| uses regular expressions to search. For example, a fully qualified name:

.. code-block:: bash

   $ kitchen list default-ubuntu-1404 --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404

A partial name:

.. code-block:: bash

   $ kitchen list ubuntu --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404
   server-ubuntu-1404

A short string:

.. code-block:: bash

   $ kitchen list ub --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404
   server-ubuntu-1404

An integer:

.. code-block:: bash

   $ kitchen list 4 --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404
   server-ubuntu-1404

A single-quoted |ruby| regular expression:

.. code-block:: bash

   $ kitchen list '^cli.*-65$' --bare

will return something similar to:

.. code-block:: bash

   client-centos-65


.. kitchen console
.. =====================================================
.. .. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_console.rst
.. 
.. Syntax
.. -----------------------------------------------------
.. .. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_console_syntax.rst
.. 
.. Options
.. -----------------------------------------------------
.. This subcommand does not have any options.
.. 
.. Examples
.. -----------------------------------------------------
.. None.

kitchen converge
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_converge.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_converge_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_converge_options.rst

Examples
-----------------------------------------------------

**Converge the default CentOS instance**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_converge_centos_default.rst

**Converge the default Ubuntu instance**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_converge_ubuntu_default.rst


kitchen create
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_create.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_create_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_create_options.rst

Examples
-----------------------------------------------------

**Create the default CentOS instance**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_create_centos_default.rst

**Create the default Ubuntu instance**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_create_ubuntu_default.rst

kitchen destroy
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_destroy.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_destroy_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_destroy_options.rst

Examples
-----------------------------------------------------
None.

kitchen diagnose
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_diagnose.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_diagnose_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_diagnose_options.rst

Examples
-----------------------------------------------------

**Diagnose an instance**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_diagnose.rst

**Diagnose an instance using --instances option**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_diagnose_instances.rst

**Diagnose an instance using --loader option**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_diagnose_loader.rst

kitchen driver create
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_driver_create.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_driver_create_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_driver_create_options.rst

Examples
-----------------------------------------------------
None.

kitchen driver discover
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_driver_discover.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_driver_discover_syntax.rst

Options
-----------------------------------------------------
This subcommand does not have any options.

Examples
-----------------------------------------------------
None.

kitchen exec
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_exec.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_exec_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_exec_options.rst

Examples
-----------------------------------------------------
None.

kitchen init
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_init.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_init_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_init_options.rst

Examples
-----------------------------------------------------

**Create the Kitchen environment**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_init.rst

kitchen list
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_list.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_list_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_list_options.rst

Examples
-----------------------------------------------------

**View a list of Kitchen instances**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_list.rst

kitchen login
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_login.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_login_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_login_options.rst

Examples
-----------------------------------------------------
.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_login_ubuntu_default.rst

kitchen setup
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_setup.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_setup_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_setup_options.rst

Examples
-----------------------------------------------------
None.

kitchen test
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_test.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_test_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_test_options.rst

Examples
-----------------------------------------------------

**Test the default Ubuntu instance**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_test_ubuntu_default.rst

**Test an instance using --concurrency option**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_test_concurrency.rst

kitchen verify
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_verify.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_verify_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_verify_options.rst

Examples
-----------------------------------------------------

**Verify the default Ubuntu instance**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_verify_ubuntu_default.rst

kitchen version
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_version.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen_version_syntax.rst

Options
-----------------------------------------------------
This subcommand does not have any options.

Examples
-----------------------------------------------------

**Verify the version of Kitchen**

.. include:: ../../step_ctl_kitchen/step_ctl_kitchen_version.rst