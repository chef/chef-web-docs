Set up Chef Automate to detect and monitor the nodes in your AWS EC2 and Azure accounts by providing your credentials and creating a node manager. Chef Automate creates a node reference for each instance in your account. Associate your EC2 and Azure instances with ssh and WinRM credentials using tags--the values support wildcard matching--in your node manager. Run scan jobs with your node manager reference and you're suddenly running an `inspec exec` across your instances. Every two hours Chef Automate queries your AWS or Azure account to see the current state of all your nodes to determine if they are running, stopped, or terminated, and then updates Chef Automate accordingly. If the node manager finds an instance that used to be running and reachable but which no longer is (the node stopped, terminated, or is in a transition state), the node manager updates the status of that node in Chef Automate accordingly.

Access the _Node Integrations_ page from the **Settings** tab.

![Node Integrations](/images/automate/node-integrations.png)

## Add an AWS EC2 Node Manager

Set up Chef Automate to detect and scan the nodes in your AWS EC2 account by providing your AWS Credentials and creating an _AWS EC2 Node Manager_ from the **Node Credentials** page in the **Settings** tab. Chef Automate requires your information to detect the nodes in your AWS EC2 account. Chef Automate creates a node reference for each EC2 instance in your account and collects all of the tags associated with each instance.

InSpec 2+ supports running scan jobs against your AWS account configuration, such as CloudWatch or IAM, [see more here](https://docs.chef.io/inspec/resources/#aws). Set up Chef Automate to run these scan jobs by providing your AWS Credentials and creating an _AWS API Node Manager_ in the **Node Integrations** page in the **Settings**  tab.

To create an AWS EC2 Node Manager, you need the following information:

1. A name for your manager
1. Your AWS credentials (access key ID and secret access key)
1. The default region to target (if `us-east-1` is not desired)

![Chef Automate Create AWS-EC2 Manager](/images/automate/node-integrations-full.png)

You can use associate your `ssh` or `WinRM` credentials with your EC2 instances using tag keys or values, using the option at the bottom of the screen. This feature supports wildcard matching, which is useful for grouping nodes. Chef Automate detects your nodes immediately after any update to the Node Manager, and maintains a current list of your node status. The following example uses tag with the key 'Name' and the value 'vj-' to associate those nodes with the 'ssh ec22' credential.

Filter instances for scanning by specifying either regions or tags by their keys and values.

![Chef Automate Instance Credentials](/images/automate/instance-credentials.png)

### AWS EC2 Node Discovery

The service makes these API calls:

* `STS-GetCallerIdentity`
* `EC2-DescribeRegions`
* `EC2-DescribeInstances`
* `EC2-DescribeInstanceStatus`
* `IAM-ListAccountAliases`

Chef Automate's Node Manager discovers EC2 instances using polling and scan jobs.

Polling
: Chef Automate's Node Manager calls out to the AWS `DescribeInstanceStatus` API every two hours and discovers the state of all the instances in the account. If the node manager finds any instances that are not in its database, it adds them. This sometimes results in "bare bones info" and stopped instances in the database. The node manager updates node information in the database after an instance returns to a running state and a scan job has run on the node.

Scan Jobs
: Whenever a scan job is triggered, the node manager queries the AWS API for all nodes. Any scan reports created for nodes that are not already in the database results in creating a new node in the database.

### Create a Scan Job Targeting Your AWS Account Configuration

![Chef Automate Create AWS-API Scan Job](/images/automate/create-aws-api-scanjob.png)

### AWS API Scanning Endpoints

The service makes calls to these APIs:

* `STS-GetCallerIdentity`
* `EC2-DescribeRegions`
* `IAM-ListAccountAliases`
* `IAM-GetAccountSummary`
* `IAM-ListUsers`

Permissions: You'll need at least a global read permission; `arn:aws:iam::aws:policy/ReadOnlyAccess`

## AWS Credential-less Scanning with Chef Automate

For users running Chef Automate 2 in EC2, we invite you to try out our "AWS-EC2 Credential-less Scanning"!
Please note that credential-less scanning is not supported for AWS GovCloud.

### Ensure Minimum Permissions

Ensure the policy attached to the role used by the instance you have Chef Automate running on has at least these permissions:

```bash
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ssm:*",
                "ec2:DescribeRegions",
                "sts:GetCallerIdentity",
                "ec2:DescribeInstanceStatus",
                "iam:ListAccountAliases",
                "iam:GetAccountSummary",
                "iam:ListUsers",
            ],
            "Resource": "*"
        }
    ]
}
```

`"ssm:*"` uses a wildcard match on the AWS EC2 Systems Manager (SSM); You may wish to use a more restrictive policy.

### Install AWS EC2 Systems Manager on Instances

Please follow the instructions on [AWS](https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html)

### Enable AWS EC2 Systems Manager on Instances

To use the SSM scan job functionality, your instances must have access to `AmazonEC2RoleforSSM`, or `arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM`.

### Adding an AWS EC2 Node Manager Using IAM Credentials

When running in EC2, AWS has the ability to use the IAM role associated with your instance to create and use temporary credentials for accessing the AWS API. If you enable this feature, then you will not need to provide credentials for your AWS account. You will only be required to provide a name for your node manager. Chef Automate creates a node reference for each EC2 instance in your account, collecting all tags associated with each instance. Chef Automate calls the Amazon System Manager (SSM) to describe instance information and to get ping status for the SSM agent on all instances. A detect job is *not* run on the instances; all instances with an SSM ping status of "Online" will be marked as reachable.

### Create a Scan Job Targeting Your AWS EC2 Instances using AWS SSM

The `ssm` Scan Job:

1. Installs the latest stable InSpec from `packages.chef.io`
1. Executes InSpec locally, providing InSpec with the `fqdn` of Chef Automate and a data collector token, so each instance reports directly back to Chef Automate

Your Automate instance must be reachable (open to incoming traffic) from the instances being scanned in order for the SSM scanning to work. You can filter the instances to be scanned by specifying tag key/value matches or regions.

![Chef Automate Create AWS-EC2 Scan Job](/images/automate/create-aws-ec2-scanjob.png)

### AWS Credential-less Scanning

The service makes these API calls:

* `STS-GetCallerIdentity`
* `EC2-DescribeRegions`
* `EC2-DescribeInstances`
* `EC2-DescribeInstanceStatus`
* `SSM-DescribeInstanceInformation`
* `SSM-SendCommand`
* `SSM-ListCommands`
