.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Kitchen uses a driver plugin architecture to enable Kitchen to simulate testing on cloud providers, such as Amazon EC2, OpenStack, and Rackspace, and also on non-cloud platforms, such as Microsoft Windows. Each driver is responsible for managing a virtual instance of that platform so that it may be used by Kitchen during cookbook testing.

.. note:: The Chef development kit includes the ``kitchen-vagrant`` driver.

Most drivers have driver-specific configuration settings that must be added to the .kitchen.yml file before Kitchen will be able to use that platform during cookbook testing. For information about these driver-specific settings, please refer to the driver-specific documentation.

Some popular drivers:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Driver Plugin
     - Description
   * - `kitchen-all <https://rubygems.org/gems/kitchen-all>`__
     - A driver for everything, or "all the drivers in a single Ruby gem".
   * - `kitchen-bluebox <https://github.com/blueboxgroup/kitchen-bluebox>`__
     - A driver for Blue Box.
   * - `kitchen-cloudstack <https://github.com/test-kitchen/kitchen-cloudstack>`__
     - A driver for CloudStack.
   * - `kitchen-digitalocean <https://github.com/test-kitchen/kitchen-digitalocean>`__
     - A driver for DigitalOcean.
   * - `kitchen-docker <https://github.com/portertech/kitchen-docker>`__
     - A driver for Docker.
   * - `kitchen-dsc <https://github.com/test-kitchen/kitchen-dsc>`__
     - A driver for Windows PowerShell Desired State Configuration (DSC).
   * - `kitchen-ec2 <https://github.com/test-kitchen/kitchen-ec2>`__
     - A driver for Amazon EC2.
   * - `kitchen-fog <https://github.com/TerryHowe/kitchen-fog>`__
     - A driver for Fog, a Ruby gem for interacting with various cloud providers.
   * - `kitchen-google <https://github.com/anl/kitchen-google>`__
     - A driver for Google Compute Engine.
   * - `kitchen-hyperv <https://github.com/test-kitchen/kitchen-hyperv>`__
     - A driver for Hyper-V Server.
   * - `kitchen-joyent <https://github.com/test-kitchen/kitchen-joyent>`__
     - A driver for Joyent.
   * - `kitchen-opennebula <https://github.com/test-kitchen/kitchen-opennebula>`__
     - A driver for OpenNebula.
   * - `kitchen-openstack <https://github.com/test-kitchen/kitchen-openstack>`__
     - A driver for OpenStack.
   * - `kitchen-pester <https://github.com/test-kitchen/kitchen-pester>`__
     - A driver for Pester, a testing framework for Microsoft Windows.
   * - `kitchen-rackspace <https://github.com/test-kitchen/kitchen-rackspace>`__
     - A driver for Rackspace.
   * - `kitchen-vagrant <https://github.com/test-kitchen/kitchen-vagrant>`__
     - A driver for Vagrant. The default driver packaged with the Chef development kit.
