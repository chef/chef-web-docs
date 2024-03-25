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

Single sign-on (SSO) is an authentication method that enables you to securely authenticate and use all services with just one set of credentials. The steps are as follows:

1. Login to automate. Once done, open the [https://your_automate_url/sso](https://your_automate_url/sso) URL in a new tab.

1. The above URL will redirect you to the SAML setup page, where you(the admin) can set up the Single sign-on configuration using the UI provided.

1. The Chef SaaS SSO feature currently supports only SAML-based IDP authentication and will support IDPs according to the [Automate Documentation](https://docs.chef.io/automate/saml/).

## IDP Configuration

Chef SaaS SSO feature supports primary SAML authentication as per the current supported IDP of Automate. Following are the sample steps to configure the IDPs based on the tried test use cases:

* [OKTA IDP configuration for SSO](https://chefio.atlassian.net/wiki/spaces/CPSK/pages/2720694589/OKTA+IDP+configuration+for+SSO)

* [Microsoft 365 and Azure AD IDP configuration for SSO](https://chefio.atlassian.net/wiki/spaces/CPSK/pages/2712142486/Azure+AD+and+Microsoft+365+IDP+configuration+for+SSO)

## User SSO Integration Journey

### Prerequisites

* The User SSO Integration Journey feature is accessible only to the SaaS admins.

* Supported IDP is up and ready.

### Enable SSO for Chef-SaaS

1. To access the Single sign-on UI, navigate to your [Chef Automate UI](https://your_automate_url).

1. Log in as an admin user.

1. Modify your browser URL with SSO.

    * Remove everything after `https://your_automate_url/` from your automate URL and add `/sso`. For Example: `https://your_automate_url/dashboard/event-feed` will become `https://your_automate_url/sso`

    * When you navigate to `https://your_automate_url/sso,` you will be authenticated and authorized for admin-level privileges and redirected to the Chef-SaaS SSO UI.

    {{< figure src="/images/navigate-to-sso-saas.png" alt="Navigate to SSO">}}

1. Fill the form fields with the values provided by your IDP.

    * **SSO URL:** Single Sign-On URL is provided by your IDP.

    * **Email Attribute:** The attribute is set up in IDP for user e-mail.

    * **Username Attribute:** The attribute is set up in IDP for the username.

    * **Entity Issuer URL:** The value will be `https://your_automate_url/dex/callback`.

    * **CA Certificate:** Ca certificate provided by the IDP. The value should include the following markers:

    ```sh
    -----BEGIN CERTIFICATE----- and -----END CERTIFICATE-----
    ```

    Validate the certificates for syntactical or semantical errors before submitting the config.

1. Refer to the [link](https://chefio.atlassian.net/wiki/spaces/CPSK/pages/2666037294) if any error or validation failures arise.

1. Select **Submit** to set the SSO config. The submit button will enable it if the form validation passes.

1. An indication icon will run until the setup process is completed. Refer to the image below:

    {{< figure src="/images/indication-icon-saas.png" alt="Indication Icon">}}

1. When the request is completed, you can see if your setup is complete or if configuration errors exist.

    * If the request is completed, the user will see the SSO Request is complete. Config applied successfully.

    * If the request fails, the user will see SSO Request Failed with an appropriate message.

### Delete the SSO integration

The steps to delete the SSO integration are as follows:

1. Remove the **Configuration** button. Once the configuration is present, it will be enabled. Select to remove the configuration.

1. A popup will appear to confirm whether a user wants to remove the config.

    {{< figure src="/images/popup-to-remove-config.png" alt="Popup to Remove Config">}}

1. Select **Remove** to start the config removal process.

    * An indication icon will be present until the configuration is removed. The admin will see that the SSO request is complete and That the Configuration Has Been removed Successfully.

    * In case of an error, the admin will see SSO Request Failed with an appropriate message.

1. Select Cancel to avoid config removal.

Assuming the admin has set up its IDP, the admin can provide the necessary information on the SSO UI page.

1. **SSO URL:** Your IDP provides a Single Sign-On URL. Ensure that it is valid.

1. **Email Attribute:** This attribute refers to the user’s email. The attribute configured in IDP for user email can be passed here.

1. **Username Attribute:** This attribute refers to a username. The attribute configured in IDP for the username can be passed here.

1. **Entity Issuer URL:** It contains the value of the Identifier (Entity ID). This should be your automate URL with dex callback. Ensure that this is a valid URL. The sample URL is [https://your_automate_url/dex/callback](https://your_automate_url/dex/callback).

1. **CA Certificate:** This is the (Base64) Certificate value generated by your IDP on app configuration. Ensure that this certificate has -----BEGIN CERTIFICATE----- and -----END CERTIFICATE----- markers. This value should be used as it is and should not contain /n sequences.

1. **Group Attribute:** This field is optional, but if not provided, users authenticating via SSO will not be members of any teams.

1. **Allowed Groups:** This field is optional. It provides a single sign-in for members of the listed groups and discards all user groups that are not on the list. Groups must be on the allowed_groups list to access Chef Automate.

1. **Name Id Policy Format:** When provided, Chef Automate will request a name ID of the configured format in the SAML AuthnRequest.
This is a mandatory field for Microsoft365 and Azure AD IDPs Defaults to `urn:oasis:names:tc:SAML:2.0:nameid-format:persistent`.

### Undo your Changes

Admins can now select **Cancel** to override the edited field data.

#### For use with Okta

1. Visit the [Okta](https://okta.com) page and log in to your account.

1. Select Applications to create your **SAML** application.

1. Select on Create App Integration.

1. Select **SAML 2.0**, and select next.

1. You will be redirected to a page where you can create your app.

1. Fill in the config information as shown in the below image and select next.

    * Single sign-on URL: This should be the URL for your automate server plus /dex/callback. For example [https://your_automate_url/dex/callback](https://your_automate_url/dex/callback)

    * Audience URI: This will be the same URL as the Single sign-on URL

    * Default RelayState should be blank

    * Name ID format should be Unspecified

    * Application username should be Email

    * Under attributes, you’ll want to create two:

        * Name: email | Value: user.email

        * Name: username | Value: user.login

    IMAGE

1. Select I'm an Okta customer, add an internal app, and select **Finish**.

1. Add users who can log in using this app.

    * Select Assignments, then Assign and then assign to people. Select users from the list to add users to the app.

    IMAGE

1. Your app will be created. Select view SAML setup instructions as shown below image:

    IMAGE

1. Your Okta account is set up now. You can use the config provided by Okta to set up SAML on automate.

Multiple options can be selected for use with Azure AD

### Before You Start

This guide assumes you have the following setup:

1. Azure AD / Microsoft 365 with Azure AD access

    * Admin Rights to the Instance

1. Chef Automate 2.0 or later version

The steps are as follows:

1. Create an Application in Azure.

    * Go Azure AD portal ([https://portal.azure.com]) and log in to it.

    * Under Enterprise applications, Select New Application and then select Create your application to create a new application.

    * Provide a name for the application.

    * Select the Non-Gallery Application option.

    * After creating it, select single sign-on and select SAML.

    IMAGE

    * Under the Single Sign-On option, fill out the following information:

        * In section 1 – Basic SAML Configuration, enter the following:

          IMAGE

            * Identifier (Entity ID): [https://{your-chef-automate-fqdn}/dex/callback](https://{your-chef-automate-fqdn}/dex/callback)

            * Reply URL (Assertion Consumer Service URL): [https://{your-chef-automate-fqdn}/dex/callback](https://{your-chef-automate-fqdn}/dex/callback)

        * In section 2: User Attributes and Claims, check the defaults that are there:

          IMAGE

            * Required Claim:

                * Unique User Identifier (Name ID)

                * Source attribute: user.userprincipalname

            * Additional Claims

                * givenname

                    * Namespace: [http://schemas.xmlsoap.org/ws/2005/05/identity/claims](http://schemas.xmlsoap.org/ws/2005/05/identity/claims)

                    * Source attribute: user:givenname

                * name

                    * Namespace: [http://schemas.xmlsoap.org/ws/2005/05/identity/claims](http://schemas.xmlsoap.org/ws/2005/05/identity/claims)

                    * Source attribute: user:userprincipalname

                * surname

                    * Namespace: [http://schemas.xmlsoap.org/ws/2005/05/identity/claims](http://schemas.xmlsoap.org/ws/2005/05/identity/claims)

                    * Source attribute: user:surname

            * Add additional claims (you may need to delete existing entries for the e-mail address and username if they exist).

                * emailaddress

                    * Namespace: leave namespace blank

                    * Source attribute: user.mail

                * username

                    * Namespace: leave namespace blank

                    * Source attribute: user.mail

        * In section 3 – SAML Signing certificate.

          IMAGE

        Download the certificate (Base64).

        * Note the following values from Section 4:

            * Login URL.

            * Azure AD Identifier.

            * Logout URL.

    * After setup, go to Users and Groups to assign users and groups to the application.

    Select `Add user/group` to assign users and groups to the application.

1. Configure SAML on the Chef Automate via SSO UI

    * Log into chef-automate and then switch to SSO UI, i.e. [https://{your-chef-automate-fqdn}/sso](https://{your-chef-automate-fqdn}/sso).

    * Fill in the required values:

        * **CA Information:** This is the X.509 Certificate from section 3 above. Copy the downloaded certificate contents and paste them as the value for CA Information.

        * **SSO URL:** This is the value for the Identity Provider Single Sign-On URL. Use the Login URL value from Section 4 above.

        IMAGE

        * **Email Attribute:** This is the name of the email claim. (e.g., In our case, it is emailaddress)

        * **Username Attribute:** This is the name of the claim for the username. (e.g., In our case, it is username)

        * **Entity Issuer:** This should be the URL provided in section 1 for Identifier (Entity ID). (for example: In our case, it is [https://{your-chef-automate-fqdn}/dex/callback](https://{your-chef-automate-fqdn}/dex/callback))

        * **Name Id Policy Format:** This should be the Unique User Identifier (Name ID) value from the value column for Name ID present in square brackets. eg:- user.
        userprincipalname [nameid-format:emailAddress] and add it to the end of `urn:oasis:names:tc:SAML:1.1:`.

        IMAGE

        So it should look like this urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress

Azure AD lets you choose the NameID field and apply transformations to it. The SAML configuration setting of the selected value in “Choose name identifier format” in Azure AD must match the name_id_policy_format configuration in Chef Automate.

These values are accepted for name_id_policy_format:

* urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress

* urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified

* urn:oasis:names:tc:SAML:1.1:nameid-format:X509SubjectName

* urn:oasis:names:tc:SAML:1.1:nameid-format:WindowsDomainQualifiedName

* urn:oasis:names:tc:SAML:2.0:nameid-format:encrypted

* urn:oasis:names:tc:SAML:2.0:nameid-format:entity

* urn:oasis:names:tc:SAML:2.0:nameid-format:kerberos

* urn:oasis:names:tc:SAML:2.0:nameid-format:persistent

* urn:oasis:names:tc:SAML:2.0:nameid-format:transient

Select **Submit** button to patch the SSO settings on the chef-automate Multiple options can be selected.
