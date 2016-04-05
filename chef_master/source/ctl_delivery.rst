=====================================================
Delivery CLI
=====================================================

.. include:: ../../includes_ctl_delivery/includes_ctl_delivery.rst

Install Delivery CLI
=====================================================
.. include:: ../../includes_delivery/includes_delivery_cli_install.rst

By platform
-----------------------------------------------------
Use one of the sections below to install the |delivery_cli| CLI on |mac os x|, |ubuntu|, |redhat enterprise linux|/|suse els|, or |windows|:

|mac os x|
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_mac.rst

|ubuntu|
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_ubuntu.rst

RHEL, SUSE
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_rhel.rst

|windows|
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_cli_install_windows.rst

Configure Delivery CLI
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_cli_configure.rst


delivery api
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_api.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_api_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_api_options.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_github_user_names.rst

**Link a Github enterprise user name**

.. include:: ../../step_ctl_delivery/step_ctl_delivery_api_github_username_enterprise.rst

**Link a Github.com user name**

.. include:: ../../step_ctl_delivery/step_ctl_delivery_api_github_username_dotcom.rst

**Get list of blocked projects**

.. include:: ../../step_ctl_delivery/step_ctl_delivery_api_get_list_of_blocked_projects.rst

delivery checkout
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_checkout.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_checkout_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_checkout_options.rst

Examples
-----------------------------------------------------
None.


delivery clone
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_clone.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_clone_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_clone_options.rst

Examples
-----------------------------------------------------
None.


delivery diff
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_diff.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_diff_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_diff_options.rst

Examples
-----------------------------------------------------
None.


delivery init
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_init.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_init_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_init_options.rst

Examples
-----------------------------------------------------

**Adding a build cookbook from a private Supermarket**

The following example shows how to add a build cookbook after the initialization process

.. code-block:: bash

   $ delivery init —skip-build-cookbook

and then update the ``config.json`` file for the ``delivery-truck`` cookbook and the path to the cookbook in a private |supermarket|:

.. code-block:: json

   {
     "version": "2",
     "build_cookbook": {
       "name": "delivery-truck",
       "supermarket": "true",
       "site": "https://private-supermarket.example.com"
     },
     ...
   }


delivery job
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_job.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_job_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_job_options.rst

Examples
-----------------------------------------------------

**Verify a job**

.. include:: ../../step_ctl_delivery/step_ctl_delivery_job_verify_unit.rst


delivery review
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_review.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_review_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_review_options.rst

Examples
-----------------------------------------------------

**Bump version metadata automatically**

.. code-block:: bash

   $ delivery review --auto-bump

will return something similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/salimafiune/delivery/organizations/sandbox/coffee
   Project coffee is a cookbook
   Validating version in metadata
   The version hasn't been updated (0.1.0)
   Bumping version to: 0.1.1
   Review for change black targeted for pipeline master
   Created new patchset
   https://delivery.chef.co/e/URL_FOR_CHANGE


delivery setup
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_setup.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_setup_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_setup_options.rst

Examples
-----------------------------------------------------
None.


delivery token
=====================================================
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_token.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_token_syntax.rst

Options
-----------------------------------------------------
.. include:: ../../includes_ctl_delivery/includes_ctl_delivery_token_options.rst

Examples
-----------------------------------------------------
None.
