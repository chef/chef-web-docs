=====================================================
Integrate Chef Compliance w/Chef Server
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_compliance_chef_server.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

.. tag EOL_compliance_server

.. warning:: The standalone Chef Compliance server is deprecated. The standalone Chef Compliance server's end-of-life date is December 31, 2018. `Chef Automate 2 <https://www.chef.io/automate/>`__ has all of the functionality of Chef Compliance Server and also includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features not found in Chef Compliance Server. 

.. end_tag

.. tag compliance_integrate_chef_server

Integrate Chef Compliance with the Chef server to allow:

* Users of Chef Compliance to log in using their Chef server credentials
* Nodes under management by Chef to download Chef Compliance profiles, run them on nodes, and then send the results back to Chef Compliance

.. end_tag

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Prerequisites
=====================================================
An integration between Chef Compliance and the Chef server requires:

* Chef Compliance server, version 1.0 (or later), with a DNS-resolvable hostname
* Chef server, version 12.4.1 (or later), configured as a standalone server
* A time synchronization policy is in place, such as Network Time Protocol (NTP); authentication algorithms are sensitive to time drift
* Chef Compliance and Chef server to allow bidirectional communication via port TCP/443; this enables single sign-on (SSO) and auditing use cases

Integration steps
=====================================================
To complete the integration between Chef Compliance and the Chef server, shell access to both Chef Compliance and the Chef server is required.

Prepare Chef Compliance
-----------------------------------------------------
To prepare Chef Compliance for integration with the Chef server, do the following:

#. From a command shell, run the following command:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl connect chef-server

   When promoted, either confirm the default values (recommended) or provide custom values.

   The following shows sample output for a Chef Compliance server with a ``compliance.test`` hostname. SSL validation is not included because of the self-signed certificate used by the Chef Compliance server:

   .. code-block:: bash

      Please confirm or provide values for:
       * Chef Server (OCID) APP-ID for Compliance [compliance_server]:
       * Name for Chef Server Authentication in Chef Compliance [Chef Server]:
       * Allow Self-signed SSL certificates [false]: true
       * Compliance Server URL [https://compliance.test]:

      Generating new shared secret for chef-gate...
        Successfully generated secret for chef-gate
      Please reconfigure Chef Compliance by running this command:
      chef-compliance-ctl reconfigure

      Please run the command delimited by --- on the Chef Server node as administrator:
      ---
      CHEF_APP_ID="compliance_server" AUTH_ID="Chef Server" COMPLIANCE_URL="https://compliance.test"\n
      INSECURE_SSL="true" CHEF_GATE_COMPLIANCE_SECRET="7fef11649f95d4de9e9334b103144f58e3e1fde12f49e\n
      5a70579143a7b48f7ebf25a0dab9c58b86460e392cb942a95b345bb" OIDC_CLIENT_ID="l0IL_ak15qZzkQtP_Orc5\n
      E0Gdka_3CYFVWHIjLKoh5o=@compliance.test" bash <( curl -k https://compliance.test/static/chef-gate.sh )
      ---

   The command may also be run in non-interactive mode:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl connect chef-server --non-interactive true --chef-app-id 'compliance_server'\n
      --auth-id 'Chef Server' --insecure true --compliance-url 'https://compliance.test'

#. Copy the command delimited by ``---``, and then run:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl reconfigure

   This will create a file under ``/opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET``

#. Restart the Chef Compliance ``core`` service now:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl restart core

Configure the Chef Server
-----------------------------------------------------
To configure the Chef server for integration with Chef Compliance, do the following:

#. From the Chef server shell, run the command delimited by ``---`` from the previous section. For example:

   .. code-block:: bash

      sudo -i
      CHEF_APP_ID="compliance_server" AUTH_ID="Chef Server" COMPLIANCE_URL="https://compliance.test"\n
      INSECURE_SSL="true" CHEF_GATE_COMPLIANCE_SECRET="7fef11649f95d4de9e9334b103144f58e3e1fde12f49e\n
      5a70579143a7b48f7ebf25a0dab9c58b86460e392cb942a95b345bb" OIDC_CLIENT_ID="l0IL_ak15qZzkQtP_Orc5\n
      E0Gdka_3CYFVWHIjLKoh5o=@compliance.test" bash <( curl -k https://compliance.test/static/chef-gate.sh )

   This will install a ``chef-gate`` service on the Chef server that enables the Chef server to act as an OpenID Connect (OIDC) resource server, plus enables the chef-client to request Chef Compliance profiles, and then report back to Chef Compliance the results of profile scans.

#. When finished, a command will be printed at the end of the output similar to:

   .. code-block:: bash

      chef-compliance-ctl auth add --client-id "50b3447fd3db4f59d0160611eb25703f348887b6760482df5\n
      bd3ae2303f93c2d" --client-secret "3880ed856a14fce2201459e93d667da8fcd22f8ebbc1ad94d8a0a1195\n
      9834b91" --id "Chef Server" --type ocid  --chef-url https://chef.compliance.test --insecure true

   Copy this line. It will be used in the next section.

Configure Chef Compliance
-----------------------------------------------------
To configure Chef Compliance for integration with the Chef server, do the following:

#. From the Chef Compliance shell, run the command that was printed at the end of the output while configuring the Chef server. For example:

   .. code-block:: bash

      chef-compliance-ctl auth add --client-id "50b3447fd3db4f59d0160611eb25703f348887b6760482df5\n
      bd3ae2303f93c2d" --client-secret "3880ed856a14fce2201459e93d667da8fcd22f8ebbc1ad94d8a0a1195\n
      9834b91" --id "Chef Server" --type ocid  --chef-url https://chef.compliance.test --insecure true

#. When finished, reconfigure Chef Compliance:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl reconfigure

Test Integration
-----------------------------------------------------
Go to the Chef Compliance web interface and click the **Use a different provider** link. The default provider is ``Compliance Server``. Switch it to ``Chef Server``, and then accept the authorization request. Only nodes under management by Chef that successfully run ``audit::default`` will show up in Chef Compliance.

Scan Managed Nodes
=====================================================

Once the integration is complete, the ``audit`` cookbook allows Chef Compliance profiles to be run as part of a chef-client run. Profiles are downloaded from Chef Compliance. Audit results are sent back to Chef Compliance, which uses the Chef server as a proxy.

The ``audit`` cookbook must be uploaded to the Chef server, and then added to one (or more) recipes before the chef-client can run profiles on a node.

Upload the audit Cookbook
-----------------------------------------------------
The ``audit`` cookbook is available at the following locations:

* https://supermarket.chef.io/cookbooks/audit
* https://github.com/chef-cookbooks/audit

Download it from one of those locations, and then upload it to the Chef server using the same workflow as any other cookbook.

.. tag audit_cookbook_420

.. note:: Audit Cookbook version 4.2.0 or later requires InSpec 1.25.1 or later. You can upgrade your InSpec package in several different ways: by upgrading Automate, by upgrading the Chef Development Kit, by upgrading Chef Client, or by setting the ``node['audit']['inspec_version']`` attribute in your cookbook.

.. end_tag

Use the audit Cookbook
-----------------------------------------------------
There are two ways to use the ``audit`` cookbook:

* Use the custom resources in the ``audit`` cookbook directly in recipes
* Add the ``audit::default`` recipe to the run-list

The ``default`` recipe requires a ``node['audit']['profiles']`` attribute to be set. For example, defined as part of a JSON-based role or environment file:

.. code-block:: bash

   "audit": {
     "profiles": [
       {
         "name": "ssh",
         "compliance": "base/ssh"
       },
       {
         "name": "linux",
         "compliance": "base/linux"
       }
     ],
     "reporter": "chef-server"
   }

.. note:: The ``audit`` cookbook requires a time synchronization policy to be in place, such as Network Time Protocol (NTP).

The example above is using audit cookbook version 2.0. Further information is available at `Reporting to Chef Compliance via Chef Server <https://github.com/chef-cookbooks/audit#reporting-to-chef-compliance-via-chef-server.html>`__. For more configuration examples supported ``audit`` cookbook 4.0.0 and later, see `Setup Data Collection </data_collection.html>`__ and for supported audit cookbook configurations, see `Audit Cookbook </audit_cookbook.html>`__. For more information and examples on how to use the audit cookbook, see the `audit project repo in GitHub <https://github.com/chef-cookbooks/audit.html>`__.

The audit cookbook and Chef Client Audit Mode
-----------------------------------------------------

The audit cookbook and Chef's own **Audit Mode** are not compatible due to global state management done by RSpec, which is used by both implementations. To prevent unexpected results, the audit cookbook will prevent Chef from continuing if Audit Mode is not disabled.

You can use the `chef-client cookbook <https://supermarket.chef.io/cookbooks/chef-client>`_ to disable Audit Mode on all of your nodes, which will permit use of the audit cookbook. As an example, when using the chef-client cookbook you can add this configuration to the ``default_attributes`` section of a role, and then add the chef-client cookbook to the run list:

.. code-block:: bash

      "chef_client": {
        "config": {
          "audit_mode": ":disabled"
        }
      },

Run the chef-client
-----------------------------------------------------
After the ``audit`` cookbook is uploaded to the Chef server and it has been added to recipes and/or the run-list, the chef-client run will do the following:

* Download the targeted profiles from Chef Compliance, and then run them locally on the node via InSpec.
* Log a summary of the audit execution.
* Submit the full report back to the Chef Compliance server. These reports are saved in a Chef Compliance Organization that has the same name as the Organization to which the node belongs on the Chef server.
