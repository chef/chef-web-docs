+++
title = "Profile Store"
draft = false

aliases = "/profile_store.html"

[menu]
  [menu.docs]
    title = "Profile Store"
    identifier = "legacy/chef_automate_1/compliance/profile_store.md Profile Store"
    parent = "legacy/chef_automate_1/compliance"
    weight = 30
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/profile_store.rst)

<meta name="robots" content="noindex">

{{% profile_store %}}

Profile Store [profile-store-1]
=============

The Profile Store is supplied by Chef as part of the Chef Automate
installation.

The Profile Store is located under Chef Automate's **Compliance** tab

<img src="/images/profile_store.png" class="align-center" width="700" alt="image" />

Updating the Profile Store
==========================

Profile Store updates are part of the [Chef Automate upgrade
process](/upgrade_chef_automate/); however, installed compliance
profiles are not automatically updated.

Installing Profiles
===================

To install Chef Automate Compliance profiles, navigate to the Profile
Store under the **Compliance** tab and select the **Available** tab,
which is located in the body of the page.

You will then see a list of available profiles. For more information
about the controls within a profile, click the blue arrow on the right
side of the profile entry. To select a profile and then install it,
click on the radial button on the left side of the profile entry
followed by clicking the **Get** button on the right side of the page,
which is located directly above the list of available profiles.

Once the profile is installed, you will be able to use it to perform a
compliance scan. For help on performing a compliance scan, see [Perform
a Compliance Scan in Chef Automate](/perform_compliance_scan/).

Updating Profiles
=================

Installed profiles are not updated during a Chef Automate upgrade.
Available profile updates for installed profiles will appear under the
**Profiles** tab on the body of the page. Select the **view** button to
examine and install updated profiles.

Chef validates the profiles in the Profile Store for use in compliance
scans. To compare the updated and original profiles, add the updated
profile to your compliance cookbook, run them both, and compare the
results.

<img src="/images/profile_store_update.png" class="align-center" width="700" alt="image" />
