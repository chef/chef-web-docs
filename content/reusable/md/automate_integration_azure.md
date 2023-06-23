Set up Chef Automate to detect and scan the nodes in your Azure account by providing your Azure Credentials and creating an _Azure VM Node Manager_. To add an Azure VM Node Manager, navigate to the **Node Integrations** page in the Settings tab, select `Create Integration`, and you should see _Azure_ as one of your node management service options.

Chef Automate does not support Azure Government Cloud.

<!-- markdownlint-disable-file MD002 -->

### Adding an Azure VM Node Manager

When creating an Azure VM Node Manager, you will be required to provide:

1. A name for your manager
1. Your Azure credentials (client ID, client secret, and tenant ID)

This information is required to detect the nodes in your Azure account. Chef Automate creates a nodes reference for each VM in your account, reading in all tags associated with each instance. Chef Automate detects your nodes immediately after any update to the Node Manager to maintain a current list of your node status. The following example uses a tag with the key 'Name' and the value 'vj-' to associate those nodes with the 'ssh ec2' credential.

![Chef Automate Create Azure-VM Manager](/images/automate/create-azure-vm-mgr.png)

Chef Automate uses Azure's RunCommand functionality to run scan jobs on instances without needing `ssh` and `WinRM` credentials. In order for this functionality to work, the Automate instance must be reachable (open to incoming traffic) from the instances being scanned.

You also have the option of using the traditional `ssh` and `WinRM` scanning by providing such credentials for the VMs. At the bottom of the screen there is an option to associate `ssh` and `WinRM` credentials with your VMs using tag keys and values (supports wildcard match) to group nodes. If the tag key matches, the value of the tag is evaluated against the user provided value:

```txt
- foo* -> tag value has a prefix of "foo" == match
- *foo -> tag value has a suffix of "foo" == match
- *foo* -> tag value contains substring "foo" == match
- foo -> tag value is exactly "foo" == match
```

Chef Automate detects your nodes immediately after any update to the Node Manager, keeping a current view of your nodes' reachability.

![Chef Automate Instance Credentials](/images/automate/instance-credentials.png)

### Create a Scan Job Targeting Your Azure VMs

Filter the regions for the scan job by specifying regions to include or exclude.

Filter instances for scanning by specifying either regions or tags by their keys and values.

![Chef Automate Create Azure-VM Scan Job](/images/automate/create-azure-vm-scanjob.png)

## Use Case: Azure Account Scanning with Chef Automate

InSpec 2+ supports running scan jobs against your Azure account configuration, such as network security groups and ad users. See [Azure resources](https://docs.chef.io/inspec/resources/#azure) for more information.
Set up Chef Automate to run these scan jobs by providing your Azure credentials and creating an _Azure API Node Manager_.

### Adding an Azure API Node Manager

When creating an Azure API Node Manager, you will be required to provide:

1. A name for your manager
2. Your Azure credentials (client ID, client secret, and tenant ID)

This information is required to detect all subscriptions available to your Azure account. Chef Automate creates a nodes reference for each subscription in your account.

### Create a Scan Job Targeting Your Azure Account Configuration

From the **Scan Jobs** tab, select the "Create new job" button.

Filter the regions for the scan job by specifying regions to include or exclude.

![Chef Automate Create Azure-API Scan Job](/images/automate/create-azure-api-scanjob.png)
