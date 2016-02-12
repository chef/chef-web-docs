.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The standalone installation of |chef compliance| server creates a working installation on a single server. This installation is also useful when you are installing |chef compliance| in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

To install the |chef compliance| server:

#. Download the package from http://downloads.chef.io/compliance/.
#. Upload the package to the machine that will run the |chef compliance| server, and then record its location on the file system. The rest of these steps assume this location is in the ``/tmp`` directory
#. Install the |chef compliance| package on the server, using the name of the package provided by |company_name|. These commands require ``root`` privileges.

   For |redhat| and |centos| 6:

   .. code-block:: bash

      $ rpm -Uvh /tmp/chef-compliance-<version>.rpm

   For |ubuntu|:

   .. code-block:: bash

      $ dpkg -i /tmp/chef-compliance-<version>.deb

   After a few minutes, the |chef compliance| will be installed.

#. Run the following to start all of the services:

   .. code-block:: bash

      $ chef-compliance-ctl reconfigure

#. Access the |chef compliance| setup wizard.  Build the URL by prepending ``https://`` and appending ``/#/setup`` to the IP address or public hostname that was automatically assigned when the |amazon ami| was launched.  For example, ``https://<fqdn>/#/setup``.

#. Run through the setup wizard, and then log in to |chef compliance| webui ``https://<fqdn>``.
