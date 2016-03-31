=====================================================
Integrate |chef compliance| with |chef server_title|
=====================================================

Integrating |chef compliance| with |chef server_title| will provide these benefits:

* Login to |chef compliance| with existing |chef server_title| users.
* Nodes managed by |chef server_title| will be able to download |chef compliance| profiles, run them and report back the results.

Software prerequisites
=====================================================

* |chef compliance| server version 1.0 or newer.
* Standalone |chef server_title| version 12.4.1 or newer. HA support will be provided in the near future.
* A service like ``ntp`` to ensure time is up-to-date on the servers. Authentication algorithms are sensitive to time drift.

You can either install these versions or upgrade your existing installations to meet these requirements.

Network prerequisites
=====================================================

* |chef compliance| and |chef server_title| communicate between each other over port TCP/443. This needs to be allowed bidirectionally in order to support both |chef server| Single Sign-on and |chef client| audit user-cases.

Integration steps
=====================================================

To complete the integration you need shell access to |chef server_title| and |chef compliance| servers and go through these steps:

Prepare |chef compliance|
-----------------------------------------------------

Run this command from the shell, confirm or provide values when prompted:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl connect chef-server


The [default] values should work for most users. Here's a sample output received for a |chef compliance| server with a ``compliance.test`` hostname. I'm skipping SSL validation here due to the self-signed certificate used by the |chef compliance| server:

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
   CHEF_APP_ID="compliance_server" AUTH_ID="Chef Server" COMPLIANCE_URL="https://compliance.test" INSECURE_SSL="true" CHEF_GATE_COMPLIANCE_SECRET="7fef11649f95d4de9e9334b103144f58e3e1fde12f49e5a70579143a7b48f7ebf25a0dab9c58b86460e392cb942a95b345bb" OIDC_CLIENT_ID="l0IL_ak15qZzkQtP_Orc5E0Gdka_3CYFVWHIjLKoh5o=@compliance.test" bash <( curl -k https://compliance.test/static/chef-gate.sh )
   ---

You can also run the command in a non-interactive mode, here's an example:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl connect chef-server --non-interactive true --chef-app-id 'compliance_server' --auth-id 'Chef Server' --insecure true --compliance-url 'https://compliance.test'

Copy the command delimited by --- and run:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl reconfigure

This will create a file under ``/opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET``

Restart the |chef compliance| core service now:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl restart core


Configure |chef server_title|
-----------------------------------------------------

From the |chef server_title| shell, run the ``---`` delimited command from the previous step, in my case:

.. code-block:: bash

   sudo -i
   CHEF_APP_ID="compliance_server" AUTH_ID="Chef Server" COMPLIANCE_URL="https://compliance.test" INSECURE_SSL="true" CHEF_GATE_COMPLIANCE_SECRET="7fef11649f95d4de9e9334b103144f58e3e1fde12f49e5a70579143a7b48f7ebf25a0dab9c58b86460e392cb942a95b345bb" OIDC_CLIENT_ID="l0IL_ak15qZzkQtP_Orc5E0Gdka_3CYFVWHIjLKoh5o=@compliance.test" bash <( curl -k https://compliance.test/static/chef-gate.sh )

This will install a ``chef-gate`` service on the |chef server_title| to enable two main use-cases:

1. |chef server_title| to act as an OpenID Connect (OIDC) resource server.
2. |chef client| to request |chef compliance| profiles and report back.

When successful, you will see an installation line at the very end like:

.. code-block:: bash

   chef-compliance-ctl auth add --client-id "50b3447fd3db4f59d0160611eb25703f348887b6760482df5bd3ae2303f93c2d" --client-secret "3880ed856a14fce2201459e93d667da8fcd22f8ebbc1ad94d8a0a11959834b91" --id "Chef Server" --type ocid  --chef-url https://chef.compliance.test --insecure true

Copy this line and use it for the next step.

Configure |chef compliance|
-----------------------------------------------------

Execute the ``chef-compliance-ctl auth add ...`` command provided during the previous step in the |chef compliance| shell.

When done, it will ask you to run ``chef-compliance-ctl reconfigure``.

Test the OCID auth integration
-----------------------------------------------------

Go to the |chef compliance| web interface and click the ``Use a different provider`` link. You'll be presented with these options:

 * ``Chef Server``, the OCID authentication using the configured |chef server|. Accept the authorization request when prompted.
 * ``Compliance Server``, the native |chef compliance| authentication option

Compliance scan of |chef server_title| managed nodes
=====================================================

Once the integration is complete, the ``audit`` cookbook allows you to run |chef compliance| profiles as part of a |chef client| run. It downloads configured profiles from |chef compliance| and reports audit results to |chef compliance|, using |chef server_title| as a proxy.
The ``audit`` cookbook has been created with custom resources to allow for |chef compliance| profiles execution and reporting.

Here's how this is done:

Upload cookbook to Chef Server
-----------------------------------------------------

The ``audit`` cookbook is available at [Chef Supermarket](https://supermarket.chef.io/cookbooks/audit) or in [GitHub](https://github.com/chef-cookbooks/audit)

Use your existing workflow to upload it to your |chef server_title|.

Using the cookbook on the |chef server_title| managed nodes
-----------------------------------------------------

You can either use the custom resources provided by the cookbook or add the ``audit::default`` recipe to the run-list of the nodes. The ``default`` recipe requires a ``node['audit']['profiles']`` attribute to be set. Here's an example of how do define it as part of a Chef json based role or environment file:

.. code-block:: bash

   "audit": {
     "profiles": {
       "base/ssh": true,
       "base/linux": true
     }
   }

.. note:: This cookbook requires up-to-date time on the nodes. Use ``ntp`` or similar software to prevent time drift.

|chef client| run
-----------------------------------------------------

With the above steps completed, a |chef client| run will:
 * Download the targeted profiles from |chef compliance| and run them locally via |inspec|.
 * Log a summary of the audit execution.
 * Submit the full report back to the |chef compliance| server. The reports will be saved in a |chef compliance| Organization with the same name as the Organization the server belongs to in |chef server|.
