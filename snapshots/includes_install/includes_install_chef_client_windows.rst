.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To install the chef-client on Microsoft Windows, do the following:

#. Go to http://www.chef.io/chef/install.

#. Click the **Chef Client** tab.

#. Select **Windows**, a version, and an architecture.

#. Under **Downloads**, select the version of the chef-client to download, and then click the link that appears below to download the package.

#. Ensure that the MSI is on the target node.

#. Run the MSI package and use all the default options:

   .. image:: ../../images/step_install_windows_01.png

then:

   .. image:: ../../images/step_install_windows_02.png

then:

   .. image:: ../../images/step_install_windows_03.png

   .. note:: The chef-client must be run as a service for it to be able to regularly check in with the Chef server. Select the **Chef Client Service** option to have the MSI configure the chef-client as a service.

then:

   .. image:: ../../images/step_install_windows_04.png

then:

   .. image:: ../../images/step_install_windows_05.png

then:

   .. image:: ../../images/step_install_windows_06.png

