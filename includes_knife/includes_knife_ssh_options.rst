.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-a SSH_ATTR``, ``--attribute SSH_ATTR``
   |attribute ssh| The default attribute is the |fqdn| of the host. Other possible values include a public IP address, a private IP address, or a hostname.

``-A``, ``--forward-agent``
   |forward_agent|

``-C NUM``, ``--concurrency NUM``
   |concurrency|

``-e``, ``--exit-on-error``
   Use to exit immediately upon error.

``-G GATEWAY``, ``--ssh-gateway GATEWAY``
   |ssh_gateway|

``-i IDENTITY_FILE``, ``--identity-file IDENTIFY_FILE``
   |identity-file|

``-m``, ``--manual-list``
   |manual_list| If there is more than one item in the list, put quotes around the entire list. For example: ``--manual-list "server01 server 02 server 03"``

``--[no-]host-key-verify``
   |no_host_key_verify| Default setting: ``--host-key-verify``.

``OTHER``
   The shell type. Possible values: ``interactive``, ``screen``, ``tmux``, ``macterm``, or ``cssh``. (``csshx`` is deprecated in favor of ``cssh``.)

``-p PORT``, ``--ssh-port PORT``
   |ssh_port|

``-P PASSWORD``, ``--ssh-password PASSWORD``
   |ssh_password|

``SEARCH_QUERY``
   |search_query ssh|

``SSH_COMMAND``
   |ssh_command|

``-x USER_NAME``, ``--ssh-user USER_NAME``
   |ssh_user|

