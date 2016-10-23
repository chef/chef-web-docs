.. THIS PAGE IS IDENTICAL TO docs.chef.io/server_configure_saml.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/automate/ PATH.

=====================================================
Configuring for SAML Authentication
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

Chef Manage can support logging in users via SAML authentication. In order to do so, there must be a Chef Automate Server that is configured to act as a SAML Identity Provider (IdP). When the Chef Automate Server is configured to do so, it will provide an OpenID Connect (OIDC) protocol end-point that Chef Manage can use to initiate authentication.

Configuring Chef Manage
=====================================================

To configure the Chef server management console, add the following code to ``/etc/chef-manage/manage.rb``:

.. code-block:: none

   saml.enabled true
   saml.issuer_url '<AUTOMATE OIDC ENDPOINT>'
   saml.client_id '<CLIENT ID>'
   saml.client_secret '<CLIENT SECRET>'
   saml.verify_tls false

The ``issuer_url`` property should be set to something like 'https://<yourChefAutomateDomain>/api/v0'. Also, the ``client_id`` must be known to the Chef Automate server. For development purposes only, you may also need to turn off the TLS verification for the OIDC client as shown in the settings above.

Run ``chef-manage-ctl reconfigure`` to apply these settings.

.. warning:: You cannot have both LDAP and SAML authentication enabled at the same time. If you do, the reconfigure will fail with an appropriate error message.

Configuring the Chef Automate Server
=====================================================

See :doc:`Integrate Chef Automate with SAML </integrate_chef_automate_saml>` for information on how to configure it to act like an OpenID Connect server.
