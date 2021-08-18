Run scans against your GCP account infrastructure using Chef Automate. Set up Chef Automate to detect and scan the nodes in your Google Cloud Platform (GCP) account by providing your GCP Credentials and creating a _GCP Node Manager_. To create a GCP Node Manager, navigate to _Node Integrations_, select `Create Integration`, and you should see _Google Cloud_ as one of your node management service options. See the Chef InSpec documentation for more infomation about [GCP resources](https://docs.chef.io/inspec/resources/#gcp).

To run a GCP scan in Chef Automate:

1. Add a GCP-API Node Manager using a service account json credential
1. The service adds a node reference in the database for the project tied to the service account credential
1. Execute a profile against the project reference with a scan job

This information is required to detect all subscriptions available to your Azure account. Chef Automate creates a nodes reference for each subscription in your account.

Note: The service account json credential requires the following fields:
`type`, `project_id`, `client_id`, `private_key_id`, `private_key`, `client_email`, `auth_uri`, `token_uri`, `auth_provider_x509_cert_url`, `client_x509_cert_url`

![Chef Automate Create GCP-API Integration](/images/automate/add-gcp-api-integration.png)

Set up Chef Automate to detect and monitor the nodes in your AWS EC2 and Azure accounts by providing your credentials in the *Node Credentials** page in the Settings tab and creating a node manager. Chef Automate creates a node reference for each instance in your account. Associate your EC2 and Azure instances with ssh and WinRM credentials using tags--the values support wildcard match--in your node manager. Run scan jobs with your node manager reference and you're suddenly running an `inspec exec` across your instances. Every two hours Chef Automate queries your AWS or Azure account to see the current state of all your nodes, if they are running, stopped, or terminated, and then updates Chef Automate accordingly. If the node manager finds an instance that used to be running and reachable, but which no is--if the node is stopped, terminated, or a transition state--it updates the status of that node in Chef Automate accordingly.

### Create a Scan Job Targeting Your GCP Account Configuration

From the **Scan Jobs** tab, select the "Create new job" button.

Filter the regions for the scan job by specifying regions to include or exclude.

![Chef Automate Create GCP-API Scan Job](/images/automate/add-gcp-api-scanjob.png)
