=====================================================
Profile Store
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/profile_store.rst>`__

.. tag profile_store

The Profile Store is the page for compliance tests that are provided by Chef. It provides an easily searchable repository with a user-friendly web interface. Profiles that are part of the Profile Store are accessible by any Chef Automate user.

There are two ways of using the Profile Store:

* The public Profile Store is available under the Chef Automate's Compliance tab.
* A private Profile Store may be installed on-premise behind the firewall on the internal network. 

.. end_tag

Public Profile Store
=====================================================
The public Profile Store is supplied by Chef as part of the Chef Automate installation.

The Profile Store is located under Chef Automate's **Compliance** tab

.. image:: ../../images/profile_store.png
   :width: 700px
   :align: center


Updating the Profile Store
=====================================================
Profile Store updates are part of the `Chef Automate upgrade process </upgrade_chef_automate>`_; however, installed compliance profiles are not automatically updated.

Installing Profiles
=====================================================
To install Chef Automate Compliance profiles, navigate to the Profile Store under the **Compliance** tab and select the **Available** tab, which is located in the body of the page.

You will then see a list of available profiles. For more information about the controls within a profile, click the blue arrow on the right side of the profile entry.  To select a profile and then install it, click on the radial button on the left side of the profile entry followed by clicking the "Get" button on the right side of the page, which is located directly above the list of available profiles.

Once the profile is installed, you will be able to use it to perform a compliance scan.  For help on performing a compliance scan, see :doc:`Perform a Compliance Scan in Chef Automate </perform_compliance_scan>`.

Updating Profiles
=====================================================
After a Chef Automate upgrade, any available profile updates for installed profiles will appear under the **Profiles** tab on the body of the page. Select the `available updates` button to download updated profiles.

The updated profiles have already been validated by Chef and can be added directly to your compliance controls. If you would prefer to compare the updated and original profiles, add the updated profile to your compliance cookbook, run them both, and compare the results. For help on performing a compliance scan, see :doc:`Perform a Compliance Scan in Chef Automate </perform_compliance_scan>`.