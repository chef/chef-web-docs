Test Kitchen uses a driver plugin architecture to enable Test Kitchen to
test instances on cloud providers such as Amazon EC2, Google Compute
Engine, and Microsoft Azure. You can also test on multiple local
hypervisors, such as VMware, Hyper-V, or VirtualBox.

{{< note >}}

Chef Workstation includes many common Test Kitchen drivers.

{{< /note >}}

Most drivers have driver-specific configuration settings that you must
add to the `kitchen.yml` file before Test Kitchen can use that platform
during cookbook testing. For information about these driver-specific
settings, refer to the driver's documentation.

Driver availability depends on the Ruby environment that runs `kitchen`.
A system Ruby install and Chef Workstation can each provide a different
set of installed driver gems. To confirm that a driver is available in
the environment you're using, list its gem before you rely on it:

```shell
# System Ruby
gem list kitchen-vagrant

# Chef Workstation
chef gem list kitchen-vagrant
```

If a driver isn't installed, add its gem to that same environment.

The following drivers are the most common ways to test cookbooks with
Test Kitchen:

- **[kitchen-azurerm](https://github.com/test-kitchen/kitchen-azurerm)**: A driver for Microsoft Azure.
- **[kitchen-cloudstack](https://github.com/test-kitchen/kitchen-cloudstack)**: A driver for Apache CloudStack.
- **[kitchen-digitalocean](https://github.com/test-kitchen/kitchen-digitalocean)**: A driver for DigitalOcean. This driver ships in Chef Workstation.
- **[kitchen-docker](https://github.com/test-kitchen/kitchen-docker)**: A driver for Docker containers.
- **[kitchen-dokken](https://github.com/test-kitchen/kitchen-dokken)**: A driver for Docker that's optimized for fast Chef Infra Client testing. This driver ships in Chef Workstation.
- **[kitchen-dsc](https://github.com/test-kitchen/kitchen-dsc)**: A driver for Windows PowerShell Desired State Configuration (DSC).
- **[kitchen-ec2](https://github.com/test-kitchen/kitchen-ec2)**: A driver for Amazon EC2. This driver ships in Chef Workstation.
- **[kitchen-google](https://github.com/test-kitchen/kitchen-google)**: A driver for Google Compute Engine. This driver ships in Chef Workstation.
- **[kitchen-habitat](https://github.com/test-kitchen/kitchen-habitat)**: A driver for testing Chef Habitat packages.
- **[kitchen-hyperv](https://github.com/test-kitchen/kitchen-hyperv)**: A driver for Microsoft Hyper-V Server. This driver ships in Chef Workstation.
- **[kitchen-opennebula](https://github.com/test-kitchen/kitchen-opennebula)**: A driver for OpenNebula.
- **[kitchen-openstack](https://github.com/test-kitchen/kitchen-openstack)**: A driver for OpenStack. This driver ships in Chef Workstation.
- **[kitchen-rackspace](https://github.com/test-kitchen/kitchen-rackspace)**: A driver for Rackspace Cloud.
- **[kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant)**: A driver for HashiCorp Vagrant. This driver ships in Chef Workstation.
- **[kitchen-vcair](https://github.com/test-kitchen/kitchen-vcair)**: A driver for VMware vCloud Air.
- **[kitchen-vcenter](https://github.com/chef/kitchen-vcenter)**: A driver for VMware vCenter.
- **[kitchen-vra](https://github.com/test-kitchen/kitchen-vra)**: A driver for VMware vRealize Automation.
- **[kitchen-vro](https://github.com/test-kitchen/kitchen-vro)**: A driver for VMware vRealize Orchestrator.

Other drivers exist across the Test Kitchen ecosystem. For the current
list of maintained drivers, see the [Test Kitchen drivers reference](https://kitchen.ci/docs/drivers/).
