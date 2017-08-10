====================================================================
Send Node Notifications to a Custom Webhook
====================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_node_notifications_webhook.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

.. tag chef_automate_beta_disclaimer

.. important:: The new functionality described in this topic is currently in Beta. To enable it in the Chef Automate UI, make sure your cursor is not in any text box or field, and type ``beta``. A new ``Notifications`` menu item will appear under the **Nodes** tab in the UI.

.. end_tag

Chef Automate can be configured to post JSON messages to any compatible webhook when it detects certain issues with the nodes you are managing. Currently, those messages include:

* A Chef client run failure on any node in your fleet.
* A critical InSpec compliance scan failure on any node in your fleet.

To use this Chef Automate integration, you need a webserver or service end-point that accepts POSTs and is accessible from Chef Automate. The message payload format is given below for both InSpec compliance and Chef client run failures. These webhook notifications sent by Chef Automate will respect any outbound proxy settings that you may have configured in your ``delivery.rb``. For more information on the proxy settings in Chef Automate, see `Proxy Settings <https://docs.chef.io/config_rb_delivery.html#proxy-settings>`_.

.. note:: Notifications sent to custom webhooks by Chef Automate do not support retries; therefore, notifications sent while your particular webhook end-point is experiencing API issues, outages, or some other unplanned downtime may never be received. Undelivered notifications are not re-sent. Attempts to send notifications do generate log messages in your Chef Automate server.

Add a Webhook to Chef Automate
=====================================================
To add a custom webhook for Chef Automate:

#. On the Chef Automate server, select **Notifications** under the **Nodes** tab.
#. Click **Create Notification** and select **Add webhook notification** from the drop-down menu.
#. Pick the event you want to be notified about. Currently, you can choose to be notified on any Chef client run failures or any InSpec compliance scan failures.
#. Pick a meaningful name for the webhook, and then type in the URL of the webhook you wish to be notified at.
#. Click **Send Test**. If a test notification is successful, click **Save**. If the test is unsuccessful, make sure the Slack webhook URL was copied correctly and then try sending a test notification again.

Edit custom Notifications
=====================================================
To edit a custom webhook for Chef Automate:

#. On the Chef Automate server, select **Notifications** under the **Nodes** tab.
#. Use the navigation bar at the bottom of the page if necessary to scroll through the list of all notifications.
#. Click the pencil icon to edit the webhook and change the appropriate fields.
#. Click **Save** to store your changes.

Delete custom Notifications
=====================================================
To delete a custom webhook for Chef Automate:

#. On the Chef Automate server, select **Notifications** under the **Nodes** tab.
#. Use the navigation bar at the bottom of the page if necessary to scroll through the list of all notifications.
#. Click the trashcan icon and confirm your intent to delete the notification.

Custom Notification Schema
=====================================================

Notifications will be sent as an HTTP POST to the given webhook URL. Examples of the POST body for each notification type are shown below. Also included is an example of a test message that can be sent when you configure your notification.

**Chef Client Run Failure**

.. code-block:: json

	{
		"type": "node_failure",
		"timestamp_utc": "2017-07-20T16:51:02.000000Z",
		"start_time_utc": "2017-07-20T16:51:02.000000Z",
		"node_name": "chef-client.solo",
		"failure_snippet": "Chef client run failure on [localhost] chef-client.solo : https://automate.chef.io/viz/#/nodes/your_node_url\nError executing action `create` on resource 'directory[/tmp/exists/missing/missing]'\ndirectory[/tmp/exists/missing/missing] (test-cookbook::dir_recipe line 3) had an error: Chef::Exceptions::EnclosingDirectoryDoesNotExist: Parent directory /tmp/exists/missing does not exist, cannot create /tmp/exists/missing/missing \n",
		"exception_title": "Error executing action `create` on resource 'directory[/tmp/exists/missing/missing]'",
		"exception_message": "directory[/tmp/exists/missing/missing] (test-cookbook::dir_recipe line 3) had an error: Chef::Exceptions::EnclosingDirectoryDoesNotExist: Parent directory /tmp/exists/missing does not exist, cannot create /tmp/exists/missing/missing",
		"exception_backtrace": "/opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/chef-12.18.31/lib/chef/mixin/why_run.rb:240:in `run'\n/opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/chef-12.18.31/lib/chef/mixin/why_run.rb:321:in `block in run'\n...",
		"end_time_utc": "2017-07-20T16:51:03.000000Z",
		"automate_fqdn": "https://automate.chef.io",
		"automate_failure_url": "https://automate.chef.io/viz/#/nodes/your_node_url"
	}

**InSpec Compliance Scan Failure**

.. code-block:: json

  {
    "type": "compliance_failure",
    "node_uuid": "aaaaaaaa-709a-475d-bef5-zzzzzzzzzzzz",
    "node_name": "chef-client.solo",
    "inspec_version": "1.24.0",
    "version": "1",
    "end_time_utc": "2017-07-27T16:46:52.000000Z",
    "timestamp_utc": "2017-07-27T16:46:52.000000Z",
    "automate_fqdn": "automate.chef",
    "automate_failure_url": "https://automate.chef/viz/#/compliance/reporting/nodes",
    "failure_snippet": "InSpec found a critical control failure on [chef-client.solo](https://automate.chef/viz/#/compliance/reporting/nodes)",
    "total_number_of_tests": 13,
    "total_number_of_skipped_tests": 3,
    "total_number_of_passed_tests": 2,
    "total_number_of_failed_tests": 8,
    "number_of_failed_critical_tests": 5,
    "number_of_critical_tests": 10,
    "failed_critical_profiles": [
        {
          "version": "0.1.1",
          "title": "/tmp Compliance Profile",
          "name": "tmp_compliance_profile",
          "summary": "An Example Compliance Profile",
          "sha256": "70c2ac3386e599d4ebbf7890ccfe46ec6b7c3b2951af506f46229b5cba8c1f71",
          "doc_version": "1",
          "copyright_email": "",
          "copyright": "Nathen Harvey <nharvey@chef.io>",
          "maintainer": "Nathen Harvey <nharvey@chef.io>",
          "license": "Apache 2.0 License",
          "attributes": [],
          "supports": [],
          "number_of_controls": 1,
          "controls": [
              {
                "id": "tmp-1.1",
                "title": "/tmp directory is owned by the root user",
                "status": "failed",
                "impact": 1.0,
                "desc": "The /tmp directory must be owned by the root user",
                "source_location": {
                    "ref": "/chef-client/cache/cookbooks/test-cookbook/recipes/../files/default/compliance_profiles/tmp_compliance_profile/controls/tmp.rb",
                    "line": 12
                },
                "tags": "{\"production\":null,\"development\":null,\"identifier\":\"value\",\"remediation\":\"https://github.com/chef-cookbooks/audit\"}",
                "refs": "[{\"url\":\"https://pages.chef.io/rs/255-VFB-268/images/compliance-at-velocity2015.pdf\",\"ref\":\"Compliance Whitepaper\"}]",
                "code": "control 'tmp-1.1' do\n  impact 1\n  title '/tmp directory is owned by the root user'\n  desc 'The /tmp directory must be owned by the root user'\n  tag 'production','development'\n  tag identifier: 'value'\n  tag remediation: 'https://github.com/chef-cookbooks/audit'\n  ref 'Compliance Whitepaper', url: 'https://pages.chef.io/rs/255-VFB-268/images/compliance-at-velocity2015.pdf'\n  describe file '/tmp' do\n    it { should be_owned_by 'root1' }\n  end\nend\n",
                "number_of_tests": 1,
                "number_of_failed_tests": 1,
                "results": [
                    {
                      "status": "failed",
                      "run_time": 0.017561,
                      "message": "expected `File /tmp.owned_by?(\"root\")` to return true, got false",
                      "code_desc": "File /tmp should be owned by \"root\""
                    }
                ]
              }
          ]
        },
        {
          "version": "2.7.0",
          "title": "Mylinux Failure Success",
          "name": "mylinux-failure-success",
          "summary": "Demonstrates the use of InSpec Compliance Profile",
          "sha256": "fe62cb47135b12acb22d03a3ca80cb3015bb806ee0526e32a00ae07d026d88e8",
          "maintainer": "Chef Software, Inc.",
          "license": "Apache 2 license",
          "doc_version": "1",
          "copyright_email": "support@chef.io",
          "copyright": "Chef Software, Inc.",
          "attributes": [],
          "supports": [
              {
                "os-family": "unix"
              }
          ],
          "number_of_controls": 4,
          "controls": [
              {
                "title": "Check /etc/missing4.rb",
                "status": "failed",
                "impact": 0.82,
                "id": "Checking /etc/missing4.rb existence",
                "desc": "File test in failure-success.rb",
                "code": "control 'Checking /etc/missing4.rb existence' do\n  impact 0.82\n  title \"Check /etc/missing4.rb\"\n  desc \"File test in failure-success.rb\"\n  describe file('/etc/missing4.rb') do\n    it { should be_file }\n  end\nend\n",
                "refs": "[]",
                "tags": "{}",
                "source_location": {
                    "ref": "/chef-client/cache/cookbooks/test-cookbook/recipes/../files/default/compliance_profiles/mylinux-failure-success/controls/failure-success.rb",
                    "line": 11
                },
                "number_of_tests": 1,
                "number_of_failed_tests": 1,
                "results": [
                    {
                      "status": "failed",
                      "run_time": 1.45e-4,
                      "message": "expected `File /etc/missing4.rb.file?` to return true, got false",
                      "code_desc": "File /etc/missing4.rb should be file"
                    }
                ]
              },
              {
                "title": "Check /etc/missing6.rb",
                "tags": "{}",
                "status": "failed",
                "source_location": {
                    "ref": "/chef-client/cache/cookbooks/test-cookbook/recipes/../files/default/compliance_profiles/mylinux-failure-success/controls/failure-success.rb",
                    "line": 29
                },
                "results": [
                    {
                      "status": "failed",
                      "run_time": 9.84e-4,
                      "message": "\nexpected: 663\n     got: nil\n\n(compared using ==)\n",
                      "code_desc": "File /etc/missing6.rb mode should eq 663"
                    }
                ],
                "refs": "[]",
                "number_of_tests": 1,
                "number_of_failed_tests": 1,
                "impact": 0.7,
                "id": "Checking /etc/missing6.rb existence",
                "desc": "File test in failure-success.rb",
                "code": "control 'Checking /etc/missing6.rb existence' do\n  impact 0.7\n  title \"Check /etc/missing6.rb\"\n  desc \"File test in failure-success.rb\"\n  describe file('/etc/missing6.rb') do\n    its('mode') { should eq 663 }\n  end\nend\n"
              },
              {
                "title": "Check /etc/hosts and /etc/missing7.rb",
                "tags": "{}",
                "status": "failed",
                "source_location": {
                    "ref": "/chef-client/cache/cookbooks/test-cookbook/recipes/../files/default/compliance_profiles/mylinux-failure-success/controls/failure-success.rb",
                    "line": 38
                },
                "results": [
                    {
                      "status": "passed",
                      "run_time": 1.43e-4,
                      "code_desc": "File /etc/hosts should be file"
                    },
                    {
                      "status": "failed",
                      "run_time": 1.38e-4,
                      "message": "expected `File /etc/missing7.rb.file?` to return true, got false",
                      "code_desc": "File /etc/missing7.rb should be file"
                    }
                ],
                "refs": "[]",
                "number_of_tests": 2,
                "number_of_failed_tests": 1,
                "impact": 0.95,
                "id": "Checking /etc/hosts and /etc/missing7.rb existence",
                "desc": "File test in failure-success.rb",
                "code": "control 'Checking /etc/hosts and /etc/missing7.rb existence' do\n  impact 0.95\n  title \"Check /etc/hosts and /etc/missing7.rb\"\n  desc \"File test in failure-success.rb\"\n  describe file('/etc/hosts') do\n    it { should be_file }\n  end\n  describe file('/etc/missing7.rb') do\n    it { should be_file }\n  end\nend\n"
              },
              {
                "title": "Check /etc/group",
                "tags": "{}",
                "status": "failed",
                "source_location": {
                    "ref": "/chef-client/cache/cookbooks/test-cookbook/recipes/../files/default/compliance_profiles/mylinux-failure-success/controls/failure-success.rb",
                    "line": 50
                },
                "results": [
                    {
                      "status": "passed",
                      "run_time": 1.48e-4,
                      "code_desc": "File /etc/group should be file"
                    },
                    {
                      "status": "failed",
                      "run_time": 0.014969,
                      "message": "\nexpected: 1\n     got: 0\n\n(compared using ==)\n",
                      "code_desc": "Command pwd exit_status should eq 1"
                    }
                ],
                "refs": "[]",
                "number_of_tests": 2,
                "number_of_failed_tests": 1,
                "impact": 1.0,
                "id": "Checking /etc/group existence",
                "desc": "File test in failure-success.rb",
                "code": "control 'Checking /etc/group existence' do\n  impact 1\n  title \"Check /etc/group\"\n  desc \"File test in failure-success.rb\"\n  describe file('/etc/group') do\n    it { should be_file }\n  end\n  describe command('pwd') do\n    its('exit_status') { should eq 1 }\n  end\nend\n"
              }
          ]
        }
    ]
  }

**Test message from the UI**

.. code-block:: json

  {
    "username": "Chef_Automate",
    "attachments": [
      {
        "fallback": "Test message from Chef Automate!",
        "text": "Test message from Chef Automate!"
      }
    ]
  }
