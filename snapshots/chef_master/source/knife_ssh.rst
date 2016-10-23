=====================================================
knife ssh 
=====================================================

.. include:: ../../includes_knife/includes_knife_ssh.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_ssh_syntax.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

This subcommand has the following options:

``-a SSH_ATTR``, ``--attribute SSH_ATTR``
   The attribute used when opening an SSH connection. The default attribute is the FQDN of the host. Other possible values include a public IP address, a private IP address, or a hostname.

``-A``, ``--forward-agent``
   Enable SSH agent forwarding.

``-C NUM``, ``--concurrency NUM``
   The number of allowed concurrent connections.

``-e``, ``--exit-on-error``
   Use to exit immediately upon error.

``-G GATEWAY``, ``--ssh-gateway GATEWAY``
   The SSH tunnel or gateway that is used to run a bootstrap action on a machine that is not accessible from the workstation.

``-i IDENTITY_FILE``, ``--identity-file IDENTIFY_FILE``
   The SSH identity file used for authentication. Key-based authentication is recommended.

``-m``, ``--manual-list``
   Define a search query as a space-separated list of servers. If there is more than one item in the list, put quotes around the entire list. For example: ``--manual-list "server01 server 02 server 03"``

``--[no-]host-key-verify``
   Use ``--no-host-key-verify`` to disable host key verification. Default setting: ``--host-key-verify``.

``OTHER``
   The shell type. Possible values: ``interactive``, ``screen``, ``tmux``, ``macterm``, or ``cssh``. (``csshx`` is deprecated in favor of ``cssh``.)

``-p PORT``, ``--ssh-port PORT``
   The SSH port.

``-P PASSWORD``, ``--ssh-password PASSWORD``
   The SSH password. This can be used to pass the password directly on the command line. If this option is not specified (and a password is required) knife prompts for the password.

``SEARCH_QUERY``
   The search query used to return a list of servers to be accessed using SSH and the specified ``SSH_COMMAND``. This option uses the same syntax as the search subcommand.

``SSH_COMMAND``
   The command to be run against the results of a search query.

``-t SECONDS``, ``--ssh-timeout SECONDS``
   The amount of time (in seconds) to wait for an SSH connection time out.

``--tmux-split``
   Split the Tmux window. Default value: ``false``.

``-x USER_NAME``, ``--ssh-user USER_NAME``
   The SSH user name.


.. note:: .. include:: ../../includes_knife/includes_knife_common_see_all_config_options.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Find server uptime**

.. include:: ../../step_knife/step_knife_ssh_find_uptime.rst

**Run the chef-client on all nodes**

.. include:: ../../step_knife/step_knife_ssh_run_chef_client_on_all_nodes.rst

**Force a chef-client run**

.. include:: ../../step_knife/step_knife_ssh_force_chef_run.rst

**Run a command based on search query**

.. include:: ../../step_knife/step_knife_ssh_query_for_nodes.rst

**Upgrade all nodes**

.. include:: ../../step_knife/step_knife_ssh_upgrade_nodes.rst

**Specify the shell type**

.. include:: ../../step_knife/step_knife_ssh_shell_type.rst
