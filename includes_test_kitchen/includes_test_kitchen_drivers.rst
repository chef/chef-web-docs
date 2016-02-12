.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|kitchen| uses a driver plugin architecture to enable |kitchen| to simulate testing on cloud providers, such as |amazon ec2|, |openstack|, and |rackspace|, and also on non-cloud platforms, such as |windows|. Each driver is responsible for managing a virtual instance of that platform so that it may be used by |kitchen| during cookbook testing.

.. note:: The |chef dk| includes the ``kitchen-vagrant`` driver.

Most drivers have driver-specific configuration settings that must be added to the |kitchen yml| file before |kitchen| will be able to use that platform during cookbook testing. For information about these driver-specific settings, please refer to the driver-specific documentation.

Some popular drivers:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Driver Plugin
     - Description
   * - `kitchen-all <https://rubygems.org/gems/kitchen-all>`__
     - A driver for everything, or "all the drivers in a single |ruby| |gem|".
   * - `kitchen-bluebox <https://github.com/blueboxgroup/kitchen-bluebox>`__
     - A driver for |bluebox|.
   * - `kitchen-cloudstack <https://github.com/test-kitchen/kitchen-cloudstack>`__
     - A driver for |cloudstack|.
   * - `kitchen-digitalocean <https://github.com/test-kitchen/kitchen-digitalocean>`__
     - A driver for |digital ocean|.
   * - `kitchen-docker <https://github.com/portertech/kitchen-docker>`__
     - A driver for |docker|.
   * - `kitchen-dsc <https://github.com/test-kitchen/kitchen-dsc>`__
     - A driver for |windows powershell| |windows powershell_dsc|.
   * - `kitchen-ec2 <https://github.com/test-kitchen/kitchen-ec2>`__
     - A driver for |amazon ec2|.
   * - `kitchen-fog <https://github.com/TerryHowe/kitchen-fog>`__
     - A driver for |fog|, a |ruby| |gem| for interacting with various cloud providers.
   * - `kitchen-gce <https://github.com/anl/kitchen-gce>`__
     - A driver for |google compute engine|.
   * - `kitchen-hyperv <https://github.com/test-kitchen/kitchen-hyperv>`__
     - A driver for |microsoft hyperv|.
   * - `kitchen-joyent <https://github.com/test-kitchen/kitchen-joyent>`__
     - A driver for |joyent|.
   * - `kitchen-opennebula <https://github.com/test-kitchen/kitchen-opennebula>`__
     - A driver for |opennebula|.
   * - `kitchen-openstack <https://github.com/test-kitchen/kitchen-openstack>`__
     - A driver for |openstack|.
   * - `kitchen-pester <https://github.com/test-kitchen/kitchen-pester>`__
     - A driver for |pester|, a testing framework for |windows|.
   * - `kitchen-rackspace <https://github.com/test-kitchen/kitchen-rackspace>`__
     - A driver for |rackspace|.
   * - `kitchen-vagrant <https://github.com/test-kitchen/kitchen-vagrant>`__
     - A driver for |vagrant|. The default driver packaged with the |chef dk|.
