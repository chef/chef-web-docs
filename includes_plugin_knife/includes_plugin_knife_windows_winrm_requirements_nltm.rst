.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


When |knife| is executed from a |windows| system, it is no longer necessary to make additional configuration of the |windows remote management| listener on the target node to enable successful authentication from the workstation. It is sufficient to have a |windows remote management| listener on the remote node configured to use the default configuration for ``winrm quickconfig``. This is because |subcommand knife windows| supports the |windows| negotiate protocol, including |ntlm| authentication, which matches the authentication requirements for the default configuration of the |windows remote management| listener.

.. note:: To use |microsoft negotiate| or |ntlm| to authenticate as the user specified by the ``--winrm-user`` option, include the user's |windows| domain, using the format ``domain\user``, where the backslash (``\``) separates the domain from the user.

For example:

.. code-block:: bash

   $ knife bootstrap windows winrm web1.cloudapp.net -r 'server::web' -x 'proddomain\webuser' -P 'password'

and:

.. code-block:: bash

   $ knife bootstrap windows winrm db1.cloudapp.net -r 'server::db' -x '.\localadmin' -P 'password'
