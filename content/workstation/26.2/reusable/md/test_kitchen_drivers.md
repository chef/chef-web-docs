Test Kitchen uses a driver plugin architecture to enable Test Kitchen to
test instances on cloud providers such as Amazon EC2, Google Compute
Engine, and Microsoft Azure. You can also test on multiple local
hypervisors, such as VMware, Hyper-V, or VirtualBox.

{{< note >}}

Chef Workstation includes many common Test Kitchen drivers.

{{< /note >}}

Most drivers have driver-specific configuration settings that must be
added to the `kitchen.yml` file before Test Kitchen will be able to use
that platform during cookbook testing. For information about these
driver-specific settings, please refer to the driver-specific
documentation.

Some popular drivers:

- **[kitchen-azurerm](https://github.com/test-kitchen/kitchen-azurerm)**: A driver for Microsoft Azure.
- **[kitchen-cloudstack](https://github.com/test-kitchen/kitchen-cloudstack)**: A driver for CloudStack.
- **[kitchen-digitalocean](https://github.com/test-kitchen/kitchen-digitalocean)**: A driver for DigitalOcean. This driver ships in Chef Workstation.
- **[kitchen-dokken](https://github.com/test-kitchen/kitchen-dokken)**: A driver for Docker. This driver ships in Chef Workstation.
- **[kitchen-dsc](https://github.com/test-kitchen/kitchen-dsc)**: A driver for Windows PowerShell Desired State Configuration (DSC).
- **[kitchen-ec2](https://github.com/test-kitchen/kitchen-ec2)**: A driver for Amazon EC2. This driver ships in Chef Workstation.
- **[kitchen-google](https://github.com/test-kitchen/kitchen-google)**: A driver for Google Compute Engine. This driver ships in Chef Workstation
- **[kitchen-hyperv](https://github.com/test-kitchen/kitchen-hyperv)**: A driver for Microsoft Hyper-V Server. This driver ships in Chef Workstation.
- **[kitchen-openstack](https://github.com/test-kitchen/kitchen-openstack)**: A driver for OpenStack. This driver ships in Chef Workstation.
- **[kitchen-rackspace](https://github.com/test-kitchen/kitchen-rackspace)**: A driver for Rackspace.
- **[kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant)**: A driver for HashiCorp Vagrant. This driver ships in Chef Workstation.
