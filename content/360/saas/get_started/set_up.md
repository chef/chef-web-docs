+++
title = "Set up your Chef 360 SaaS environment"

[menu.cloud]
title = "Set up Chef 360 SaaS"
identifier = "chef_cloud/360/get_started/set_up"
parent = "chef_cloud/360/get_started"
weight = 30
+++

This document describes how to login and configure Chef 360 SaaS, add users, and add a license.

## Prerequisites

- If you don't already have one, you'll need a [Chef 360 SaaS account](https://www.chef.io/products/chef-360-saas) before you can get started.
- Review the [system requirements]({{< relref "system_requirements" >}}).

## Login

After signing up for a Chef 360 SaaS account, you'll receive three emails with information for logging in and setting up your account. an email with your Progress Chef license key, an email to set your user password, and an email notifying you of the organization you've been added to and the role you've been given.

To login and set your license, follow these steps:

1. Open the link in the email titled _Set Password_.

1. In the Chef 360 SaaS login page, enter your onetime password and a new replacement password.

   The login page shows a message indicating that your password was successfully set.

1. Login using your new password and email address.

1. In the **Welcome** page, select the tenant you're logging into and the **tenant-admin** role, then select **Proceed**.

   You are now logged into Chef 360 SaaS with the Tenant Admin role.

## Add users

To add a new user to Chef 360 SaaS, follow these steps:

1. From the Chef 360 SaaS web user interface, select **Tenant Management**.

1. In the left navigation menu, select **User Management**.

1. Select **Invite User** on the right side of the User Management page.

1. In the **Invite User** dialog, enter the user's email address and user role, then select **Send Invite**.

The new user will receive an email with instructions for logging in and setting a password.

## Troubleshooting

### Setting your password failed

If your login failed because you forgot your password or you missed the five minute window to set your password, you can reset it by following these steps:

1. At your organization's login page (**`https://CUSTOMER_SUBDOMAIN.cloud.chef.io/app/hub`**), select **Forgot Password** and enter the email address you used sign up with Chef 360 SaaS.

1. You'll receive an email with a link to reset your password. You have five minutes follow the link and create a new password.
