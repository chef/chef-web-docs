A Test Kitchen _driver_ configures the compute instance that Test Kitchen uses for isolated cookbook testing.
A driver targets a local hypervisor, a hypervisor abstraction layer such as Vagrant, or a cloud service such as Amazon EC2.

{{< note >}}

Chef Workstation includes many common Test Kitchen drivers.

{{< /note >}}

Most drivers have driver-specific settings that you add to the `kitchen.yml` file before Test Kitchen can use that platform.
Driver availability depends on the Ruby environment that runs `kitchen`.
To confirm that a driver is available, list its gem before you rely on it:

```shell
# System Ruby
gem list kitchen-vagrant

# Chef Workstation
chef gem list kitchen-vagrant
```

If a driver isn't installed, add its gem to that same environment.

## Supported drivers

The following drivers have dedicated configuration pages:

- **[kitchen-azurerm](/workstation/25/tools/kitchen/drivers/azurerm/)**: Provisions virtual machines on Microsoft Azure.
- **[kitchen-digitalocean](/workstation/25/tools/kitchen/drivers/digitalocean/)**: Provisions droplets on DigitalOcean. This driver ships with Chef Workstation.
- **[kitchen-dokken](/workstation/25/tools/kitchen/drivers/dokken/)**: Runs fast cookbook tests using Docker. This driver ships with Chef Workstation.
- **[kitchen-ec2](/workstation/25/tools/kitchen/drivers/ec2/)**: Provisions instances on Amazon EC2. This driver ships with Chef Workstation.
- **[kitchen-google](/workstation/25/tools/kitchen/drivers/google/)**: Provisions instances on Google Compute Engine. This driver ships with Chef Workstation.
- **[kitchen-hyperv](/workstation/25/tools/kitchen/drivers/hyperv/)**: Provisions virtual machines on Microsoft Hyper-V. This driver ships with Chef Workstation.
- **[kitchen-openstack](/workstation/25/tools/kitchen/drivers/openstack/)**: Provisions instances on OpenStack. This driver ships with Chef Workstation.
- **[kitchen-vagrant](/workstation/25/tools/kitchen/drivers/vagrant/)**: Provisions local virtual machines with HashiCorp Vagrant. This driver ships with Chef Workstation.
- **[kitchen-vcenter](/workstation/25/tools/kitchen/drivers/vcenter/)**: Provisions virtual machines on VMware vCenter.
- **[kitchen-vra](/workstation/25/tools/kitchen/drivers/vra/)**: Provisions machines through VMware vRealize Automation.

## Additional drivers

The following drivers are also available. For configuration details, see each driver's repository:

- **[kitchen-cloudstack](https://github.com/test-kitchen/kitchen-cloudstack)**: Apache CloudStack.
- **[kitchen-docker](https://github.com/test-kitchen/kitchen-docker)**: Docker containers.
- **[kitchen-dsc](https://github.com/test-kitchen/kitchen-dsc)**: Windows PowerShell Desired State Configuration (DSC).
- **[kitchen-habitat](https://github.com/test-kitchen/kitchen-habitat)**: Chef Habitat packages.
- **[kitchen-opennebula](https://github.com/test-kitchen/kitchen-opennebula)**: OpenNebula.
- **[kitchen-rackspace](https://github.com/test-kitchen/kitchen-rackspace)**: Rackspace Cloud.
- **[kitchen-vcair](https://github.com/test-kitchen/kitchen-vcair)**: VMware vCloud Air.
- **[kitchen-vro](https://github.com/test-kitchen/kitchen-vro)**: VMware vRealize Orchestrator.

For the full list of maintained drivers, see the [Test Kitchen drivers reference](https://kitchen.ci/docs/drivers/).
