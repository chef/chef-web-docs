+++
title = "Configure SSO for Chef SaaS"
draft = false

[menu]
  [menu.saas]

    title = "Configure SSO"
    identifier = "chef_infra/Configure SSO"
    parent = "chef_saas"
    weight = 40
+++

Single sign-on (SSO) is an authentication method that enables you to securely authenticate and use all services with just one set of credentials.

## Chef SaaS SAML configuration

Chef SaaS users can login using a SAML-based external identity provider (IdP).

Chef SaaS supports the following IDps:

{{< readfile file="content/automate/reusable/md/saml_supported_identity_providers.md" >}}

### Add SAML configuration

It's crucial to note that your account must hold the Administrator policy to access the SSO user interface. This policy is automatically granted to members of the admin team.

Use the following instructions to add a SAML configuration in Chef SaaS.

1. Login to your Chef SaaS account and append `/sso` to your fully qualified domain name in your browser toolbar. For example, `https://automate.example.com/sso`.

1. On the Chef SaaS SSO page, enter the following information:

   SSO URL
   : The single sign-on URL provided by the IDP.
   : _Required_

   Email Attribute
   : The user email attribute is set in the IDP.
   : _Required_

   Username Attribute
   : The username attribute set in the IdP.
   : _Required_

   Entity Issuer URL
   : The authorization callback URL of your Chef SaaS deployment. The URL is your Chef SaaS deployment's fully qualified domain name appended with `dex/callback`. For example, `https://automate.example.com/dex/callback`.
   : _Required_

   CA Certificate
   : The full certificate provided by the IDP. Include `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----` at the beginning and end of the certificate string.
   : _Required_

   Group Attribute
   : The group attribute in the SAML assertion.
     If not provided, users authenticating with SSO will not be a member of any [team]({{< relref "/automate/teams" >}}).
   : _Optional_

   Allowed Groups
   : The groups in the IDP that have single sign-on access to Chef SaaS.
   : _Optional_

   Name ID Policy Format
   : The name identifier format used in the SAML AuthnRequest.
   : _Required for Microsoft 365 and Azure AD_
   : Default value: `urn:oasis:names:tc:SAML:2.0:nameid-format:persistent`.
   : Possible values:
     - `urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress`
     - `urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified`
     - `urn:oasis:names:tc:SAML:1.1:nameid-format:X509SubjectName`
     - `urn:oasis:names:tc:SAML:1.1:nameid-format:WindowsDomainQualifiedName`
     - `urn:oasis:names:tc:SAML:2.0:nameid-format:encrypted`
     - `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`
     - `urn:oasis:names:tc:SAML:2.0:nameid-format:kerberos`
     - `urn:oasis:names:tc:SAML:2.0:nameid-format:persistent`
     - `urn:oasis:names:tc:SAML:2.0:nameid-format:transient`

1. After entering these fields, select **Submit** to add the user SSO configuration. After Chef SaaS validates all form values, the **Submit** button is enabled.

   The SSO page refreshes, showing the filled-in SAML configuration fields with a message at the top that says, "SSO Request is complete. Config applied successfully."

If the new SSO configuration fails, you can edit and submit the form again.

### Delete SAML configuration

Your account must have the [Administrator policy]({{< relref "/automate/policies" >}}) to access the SSO user interface. Members of the [admins team]({{< relref "/automate/teams" >}}) have this by default.

As a user with the Administrator policy, you have the power to manage your SSO configurations. Here's how you can remove an existing SAML configuration in Chef SaaS.

1. Login to your Chef SaaS account and append `/sso` to your fully qualified domain name in your browser toolbar. For example, `https://automate.example.com/sso`.

1. Select the **Remove Configuration** button on the Chef SaaS SSO page.

1. A dialog box asks you to confirm that you want to remove the configuration. Select **Remove** to remove the SSO configuration.

   The SSO page refreshes, showing empty SAML configuration fields and a message at the top that says, "SSO Request is complete. Config removed successfully."
