=====================================================
Configuring for SAML Authentication
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_configure_saml.rst>`__

.. meta:: 
    :robots: noindex 

.. tag EOL_manage

.. warning:: Chef Manage is `deprecated </versions.html#deprecated-products-and-versions>`__. The `Chef Enterprise Automation Stack <https://www.chef.io/products/enterprise-automation-stack>`_ allows you to define infrastructure, security policies, and application dependencies as code, deliver the stack via an automated pipeline to any platform, and deploy, observe, and manage the stack over its lifecycle. Chef Automate is included as part of the Chef license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

Chef Manage can support logging in users via SAML authentication. In order to do so, there must be a Chef Automate Server that is configured to act as a SAML Identity Provider (IdP). When the Chef Automate Server is configured to do so, it will provide an OpenID Connect (OIDC) protocol end-point that Chef Manage can use to initiate authentication.

Configuring Chef Manage
=====================================================

To configure the Chef Infra Server management console, first add the following code to ``/etc/chef-manage/manage.rb``:

.. code-block:: ruby

   saml.enabled true
   saml.issuer_url '<AUTOMATE OIDC ENDPOINT>'

Second, store your OIDC client credentials with using the `Secrets Management </ctl_chef_server.html#ctl-chef-server-secrets-management>`__ commands:

.. code-block:: bash

   $ chef-server-ctl set-secret saml client_id '<CLIENT ID>'
   $ chef-server-ctl set-secret saml client_secret '<CLIENT SECRET>'

The ``issuer_url`` property should be set to something like ``'https://<yourChefAutomateDomain>/api/v0'``. Also, the ``client_id`` must be known to the Chef Automate server. For development purposes only, you may also need to turn off the TLS verification for the OIDC client by adding

.. code-block:: ruby

   saml.verify_tls false

to your Chef Manage configuration.

Finally, run ``chef-manage-ctl reconfigure`` to apply these settings.

.. warning:: You cannot have both LDAP and SAML authentication enabled at the same time. If you do, the reconfigure will fail with an appropriate error message.

