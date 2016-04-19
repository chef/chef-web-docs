=====================================================
Integrate Compliance w/Chef Server
=====================================================

.. include:: ../../includes_compliance/includes_compliance_integrate_chef_server.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Prerequisites
=====================================================
An integration between |chef compliance| and the |chef server| requires:

* |chef compliance| server, version 1.0 (or later), with a |dns|-resolvable hostname
* |chef server|, version 12.4.1 (or later), configured as a standalone server
* A time synchronization policy is in place, such as |ntp|; authentication algorithms are sensitive to time drift
* |chef compliance| and |chef server| to allow bidirectional communication via port TCP/443; this enables single sign-on (SSO) and auditing use cases


Integration steps
=====================================================
To complete the integration between |chef compliance| and the |chef server|, shell access to both |chef compliance| and the |chef server| is required.


Prepare |chef compliance|
-----------------------------------------------------
To prepare |chef compliance| for integration with the |chef server|, do the following:

#. From a command shell, run the following command:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl connect chef-server

   When promoted, either confirm the default values (recommended) or provide custom values.

   The following shows sample output for a |chef compliance| server with a ``compliance.test`` hostname. SSL validation is not included because of the self-signed certificate used by the |chef compliance| server:

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

#. Restart the |chef compliance| ``core`` service now:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl restart core


Configure the |chef server_title|
-----------------------------------------------------
To configure the |chef server| for integration with |chef compliance|, do the following:

#. From the |chef server| shell, run the command delimited by ``---`` from the previous section. For example:

   .. code-block:: bash

      sudo -i
      CHEF_APP_ID="compliance_server" AUTH_ID="Chef Server" COMPLIANCE_URL="https://compliance.test"\n
      INSECURE_SSL="true" CHEF_GATE_COMPLIANCE_SECRET="7fef11649f95d4de9e9334b103144f58e3e1fde12f49e\n
      5a70579143a7b48f7ebf25a0dab9c58b86460e392cb942a95b345bb" OIDC_CLIENT_ID="l0IL_ak15qZzkQtP_Orc5\n
      E0Gdka_3CYFVWHIjLKoh5o=@compliance.test" bash <( curl -k https://compliance.test/static/chef-gate.sh )

   This will install a ``chef-gate`` service on the |chef server| that enables the |chef server| to act as an |open id connect| resource server, plus enables the |chef client| to request |chef compliance| profiles, and then report back to |chef compliance| the results of profile scans.

#. When finished, a command will be printed at the end of the output similar to:

   .. code-block:: bash

      chef-compliance-ctl auth add --client-id "50b3447fd3db4f59d0160611eb25703f348887b6760482df5\n
      bd3ae2303f93c2d" --client-secret "3880ed856a14fce2201459e93d667da8fcd22f8ebbc1ad94d8a0a1195\n
      9834b91" --id "Chef Server" --type ocid  --chef-url https://chef.compliance.test --insecure true

   Copy this line. It will be used in the next section.


Configure |chef compliance|
-----------------------------------------------------
To configure |chef compliance| for integration with the |chef server|, do the following:

#. From the |chef compliance| shell, run the command that was printed at the end of the output while configuring the |chef server|. For example:

   .. code-block:: bash

      chef-compliance-ctl auth add --client-id "50b3447fd3db4f59d0160611eb25703f348887b6760482df5\n
      bd3ae2303f93c2d" --client-secret "3880ed856a14fce2201459e93d667da8fcd22f8ebbc1ad94d8a0a1195\n
      9834b91" --id "Chef Server" --type ocid  --chef-url https://chef.compliance.test --insecure true

#. When finished, reconfigure |chef compliance|:

   .. code-block:: bash

      sudo -i
      chef-compliance-ctl reconfigure

Test Integration
-----------------------------------------------------
Go to the |chef compliance| web interface and click the **Use a different provider** link. The default provider is ``Compliance Server``. Switch it to ``Chef Server``, and then accept the authorization request. Only nodes under management by |chef| that successfully run ``audit::default`` will show up in |chef compliance|.

Scan Managed Nodes
=====================================================
Once the integration is complete, the ``audit`` cookbook allows |chef compliance| profiles to be run as part of a |chef client| run. Profiles are downloaded from |chef compliance|. Audit results are sent back to |chef compliance|, which uses the |chef server| as a proxy.

The ``audit`` cookbook must be uploaded to the |chef server|, and then added to one (or more) recipes before the |chef client| can run profiles on a node.

Upload the audit Cookbook
-----------------------------------------------------
The ``audit`` cookbook is available at the following locations:

* https://supermarket.chef.io/cookbooks/audit
* https://github.com/chef-cookbooks/audit

Download it from one of those locations, and then upload it to the |chef server| using the same workflow as any other cookbook.

Use the audit Cookbook
-----------------------------------------------------
There are two ways to use the ``audit`` cookbook:

* Use the custom resources in the ``audit`` cookbook directly in recipes
* Add the ``audit::default`` recipe to the run-list

The ``default`` recipe requires a ``node['audit']['profiles']`` attribute to be set. For example, defined as part of a |json|-based role or environment file:

.. code-block:: bash

   "audit": {
     "profiles": {
       "base/ssh": true,
       "base/linux": true
     }
   }

.. note:: The ``audit`` cookbook requires a time synchronization policy to be in place, such as |ntp|.

Run the |chef client|
-----------------------------------------------------
After the ``audit`` cookbook is uploaded to the |chef server| and it has been added to recipes and/or the run-list, the |chef client| run will do the following:

* Download the targeted profiles from |chef compliance|, and then run them locally on the node via |inspec|.
* Log a summary of the audit execution.
* Submit the full report back to the |chef compliance| server. These reports are saved in a |chef compliance| Organization that has the same name as the Organization to which the node belongs on the |chef server|.
