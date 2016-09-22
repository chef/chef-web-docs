.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This configuration file has the following settings:

``core.licensed_node_count``
   The number of node licenses. Default value: ``25``.

``core.log_level``
   Changes the log level of |chef compliance| from the default value of ``'debug'``, which is the most verbose. These are all the supported levels, sorted by verbosity: ``'debug'``, ``'info'``, ``'notice'``, ``'warning'``, ``'error'`` and ``'critical'``. Requires |chef compliance| version ``1.5.13`` or newer.

``ssl.certificate``
   Full path to the |ssl| certificate file that is used by the |chef compliance| web UI. Default value: ``/var/opt/chef-compliance/ssl/ca/HOSTNAME.crt``.

``ssl.certificate_key``
   Full path to the ssl certificate key file to use by the |chef compliance| web UI. Default value: ``/var/opt/chef-compliance/ssl/ca/HOSTNAME.key``.

``verify_tls``
   Verify the TLS certificate when |chef compliance| connects locally to get the refresh token. Default value: ``false``.

Here's an example content for ``/etc/chef-compliance/chef-compliance.rb``:

.. code-block:: bash

   core.licensed_node_count 100
   core.log_level      'info'
   ssl.certificate     '/etc/chef-compliance/ssl/my.crt'
   ssl.certificate_key '/etc/chef-compliance/ssl/my.key'
   verify_tls          true

.. note:: You can see all available settings along with their default values in ``/etc/chef-compliance/chef-compliance-running.json``.
