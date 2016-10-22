=====================================================
knife bootstrap
=====================================================

.. include:: ../../includes_chef_client/includes_chef_client_bootstrap_node.rst

.. include:: ../../includes_knife/includes_knife_bootstrap.rst

.. note:: .. include:: ../../includes_notes/includes_notes_knife_bootstrap_use_knife_ssl_fetch.rst

.. note:: .. include:: ../../includes_notes/includes_notes_knife_bootstrap_on_windows.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_bootstrap_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

.. include:: ../../includes_knife/includes_knife_bootstrap_options.rst

.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Validatorless Bootstrap
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_bootstrap_no_validator.rst

``knife bootstrap`` Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_vault/includes_chef_vault_knife_bootstrap_options.rst

FIPS Mode
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_fips_mode.rst

**Bootstrap a node using FIPS**

.. include:: ../../step_knife/step_knife_bootstrap_node_fips.rst

Custom Templates
=====================================================
.. include:: ../../includes_knife/includes_knife_bootstrap_template.rst

Template Locations
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_bootstrap_template_location.rst

Ubuntu 14.04
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_bootstrap_example_ubuntu.rst

Debian and Apt
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_bootstrap_example_debian.rst

Microsoft Windows
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_bootstrap_example_windows.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Bootstrap a node**

.. include:: ../../step_knife/step_knife_bootstrap_node.rst

**Use an SSH password**

.. include:: ../../step_knife/step_knife_bootstrap_use_ssh_password.rst

**Use a file that contains a private key**

.. include:: ../../step_knife/step_knife_bootstrap_use_file_with_private_key.rst

**Fetch and execute an installation script from a URL**

.. include:: ../../step_knife/step_knife_bootstrap_fetch_install_script_from_url.rst

**Specify options when using cURL**

.. include:: ../../step_knife/step_knife_bootstrap_options_with_curl.rst

**Specify options when using GNU Wget**

.. include:: ../../step_knife/step_knife_bootstrap_options_with_gnu_wget.rst

**Specify a custom installation command sequence**

.. include:: ../../step_knife/step_knife_bootstrap_custom_install_command_sequence.rst
