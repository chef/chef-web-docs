=====================================================
Chef Software Inc Packages
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/packages.rst>`__

Packages for Chef Software Inc. products may be installed using platform-native package repositories or the Chef install script. Both installation methods support the following release channels:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Channel
     - Description
   * - ``stable``
     - A build from this channel is an "official" release that has passed full user acceptance testing. Artifacts in this channel are retained indefinitely.
   * - ``current``
     - A build from this channel is an "integration" build that has passed full testing, but has not been officially released. Artifacts in this channel are retained for 30 days and then removed automatically.

Chef recommends using the stable channel when installing any of these products on production systems.

Package Repositories
=====================================================
The ``stable`` and ``current`` release channels support the following package repositories:

* Apt (Debian and Ubuntu platforms)
* Yum (Enterprise Linux platforms)

Chef Software Inc. GPG public key is can be downloaded `here <https://packages.chef.io/chef.asc>`_.

Debian / Ubuntu
-----------------------------------------------------
To set up an Apt package repository for Debian and Ubuntu platforms:

#. Enable Apt to fetch packages over HTTPS:

   .. code-block:: bash

      $ sudo apt-get install apt-transport-https

#. Install the public key for Chef Software Inc:

   .. code-block:: bash

      $ wget -qO - https://packages.chef.io/chef.asc | sudo apt-key add -

#. Create the Apt repository source file:

   .. code-block:: bash

      $ echo "deb https://packages.chef.io/repos/apt/<CHANNEL> <DISTRIBUTION> main" > chef-<CHANNEL>.list

   Replace ``<CHANNEL>`` with the release channel: ``stable`` or ``current``.

   Replace ``<DISTRIBUTION>`` with the appropriate distribution name:

   * For Debian 8: ``jessie``
   * For Debian 9: ``stretch``
   * For Ubuntu 14.04: ``trusty``
   * For Ubuntu 16.04: ``xenial``
   * For Ubuntu 18.04: ``bionic``

#. Update the package repository list:

   .. code-block:: bash

      $ sudo mv chef-stable.list /etc/apt/sources.list.d/

#. Update the cache for the package repository:

   .. code-block:: bash

      $ sudo apt-get update

Enterprise Linux
-----------------------------------------------------
To set up a Yum package repository for Enterprise Linux platforms:

#. Install the public key for Chef Software Inc:

   .. code-block:: bash

      $ sudo rpm --import https://packages.chef.io/chef.asc

#. Create the Yum repository source file:

   .. code-block:: bash

      $ cat >chef-<CHANNEL>.repo <<EOL
      [chef-<CHANNEL>]
      name=chef-<CHANNEL>
      baseurl=https://packages.chef.io/repos/yum/<CHANNEL>/el/<VERSION>/\$basearch/
      gpgcheck=1
      enabled=1
      EOL

   Replace ``<CHANNEL>`` with the release channel: ``stable`` or ``current``.

   Replace ``<VERSION>`` with your Enterprise Linux version; the allowable versions are ``6``, or ``7``.

#. Update the package repository list:

   .. code-block:: bash

      $ sudo yum-config-manager --add-repo chef-stable.repo

   Note that the ``yum-config-manager`` command requires the ``yum-utils`` package, which is not installed on CentOS by default. You can install the package by running ``sudo yum install yum-utils``, or you can use the ``mv`` command to add the repository to the ``/etc/yum.repos.d/`` directory:

   .. code-block:: bash		     
  		  
      $ sudo mv chef-stable.repo /etc/yum.repos.d/

Chef Install Script
=====================================================
.. tag packages_install_script

The Chef install script does the following:

* Detects the platform, version, and architecture of the machine on which the installer is to be executed
* Fetches the appropriate package, for the requested product and version
* Validates the package content by comparing SHA-256 checksums
* Installs the package

.. end_tag

Run the Chef Install Script
-----------------------------------------------------
.. tag packages_install_script_run

The Chef install script can be run on UNIX, Linux, and Microsoft Windows platforms.

.. end_tag

UNIX and Linux
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag packages_install_script_run_unix_linux

On UNIX and Linux systems the Chef install script is invoked with:

.. code-block:: bash

   curl -L https://omnitruck.chef.io/install.sh | sudo bash

and then enter the local password when prompted.

.. end_tag

Microsoft Windows
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag packages_install_script_run_windows

On Microsoft Windows systems the Chef install script is invoked using Windows PowerShell:

.. code-block:: none

   . { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install

.. end_tag

Chef install Script Options
-----------------------------------------------------
.. tag packages_install_script_options

In addition to the default install behavior, the Chef install script supports the following options:

``-c`` (``-channel`` on Microsoft Windows)
   The release channel from which a package is pulled. Possible values: ``current`` or ``stable``. Default value: ``stable``.

``-d`` (``-download_directory`` on Microsoft Windows)
   The directory into which a package is downloaded. When a package already exists in this directory and the checksum matches, the package is not re-downloaded. When ``-d`` and ``-f`` are not specified, a package is downloaded to a temporary directory.

``-f`` (``-filename`` on Microsoft Windows)
   The name of the file and the path at which that file is located. When a filename already exists at this path and the checksum matches, the package is not re-downloaded. When ``-d`` and ``-f`` are not specified, a package is downloaded to a temporary directory.

``-P`` (``-project`` on Microsoft Windows)
   The product name to install. A list of valid product names can be found at https://omnitruck.chef.io/products. Default value: ``chef``.

``-v`` (``-version`` on Microsoft Windows)
   The version of the package to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. A two-part version (x.y) is also allowed. For more information about application versioning, see http://semver.org/.

.. end_tag

Examples
-----------------------------------------------------
.. tag packages_install_script_examples

The following examples show how to use the install script.

To install chef-client version 14.4.56:

.. code-block:: bash

   $ curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 14.4.56

To install the latest version of the Chef development kit on Microsoft Windows from the ``current`` channel:

.. code-block:: none

   . { iwr -useb https://omnitruck.chef.io/install.ps1 } | iex; install -channel current -project chefdk

.. end_tag
