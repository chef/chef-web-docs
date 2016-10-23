.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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

``-x USER_NAME``, ``--ssh-user USER_NAME``
   The SSH user name.

