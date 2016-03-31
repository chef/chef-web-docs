=====================================================
Integrate |chef compliance| with |chef server|
=====================================================

Integrating |chef compliance| with |chef server| will provide these benefits:

* Login to |chef compliance| based on the |chef server| users via OCID.
* Nodes connected to the |chef server| will be able to download |chef compliance| profiles, run them and report back the results.

Prerequisites
=====================================================

* A |chef server| version 12.4.1 or newer.
* |chef compliance| server version 1.0 or newer.

You can either install these version or upgrade your existing installations to meet these requirements.

Integration steps
=====================================================

To complete the integration you need shell access to |chef server| and |chef compliance| servers and go through these steps:

Prepare |chef compliance|
-----------------------------------------------------

Run this command from the shell, confirm or provide values when prompted:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl connect chef-server


Here's a sample output received for a |chef compliance| server with a |compliance.test| hostname. I'm skipping SSL validation here due to the self-signed certificate used by the Compliance server:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl connect chef-server
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

Copy run the command delimited by --- and run:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl reconfigure

This will create an ``env`` file under ``/opt/chef-compliance/sv/core/env/CHEF_GATE_COMPLIANCE_SECRET``

Restart the |chef compliance| core service now:

.. code-block:: bash

   sudo -i
   chef-compliance-ctl restart core


Configure |chef server|
-----------------------------------------------------

From the |chef server| shell, run the ``---`` delimited command from the previous step:

.. code-block:: bash

   sudo -i
   CHEF_APP_ID="compliance_server" AUTH_ID="Chef Server" COMPLIANCE_URL="https://compliance.test" INSECURE_SSL="true" CHEF_GATE_COMPLIANCE_SECRET="7fef11649f95d4de9e9334b103144f58e3e1fde12f49e5a70579143a7b48f7ebf25a0dab9c58b86460e392cb942a95b345bb" OIDC_CLIENT_ID="l0IL_ak15qZzkQtP_Orc5E0Gdka_3CYFVWHIjLKoh5o=@compliance.test" bash <( curl -k https://compliance.test/static/chef-gate.sh )

This will install a ``chef-gate`` service on the |chef server| to enable two main use-cases:

1. `chef-server` acting as an OpenID Connect (OIDC) resource server
2. `chef-client` is able to request |chef compliance| profiles and report back

When successful, you will see an installation line at the very end like:

.. code-block:: bash

   chef-compliance-ctl auth add --client-id "50b3447fd3db4f59d0160611eb25703f348887b6760482df5bd3ae2303f93c2d" --client-secret "3880ed856a14fce2201459e93d667da8fcd22f8ebbc1ad94d8a0a11959834b91" --id "Chef Server" --type ocid  --chef-url https://chef.compliance.test --insecure true

Copy this line and use it for the next step.

Configure |chef compliance|
-----------------------------------------------------

Paste the ``chef-compliance-ctl auth add ...`` command provided during the previous step in the |chef compliance| shell. For example:

When done, it will ask you to ``chef-compliance-ctl reconfigure``.

You can now go to https://compliance.test , select a different login provider, and click on Chef Server..................

Run audit cookbook on node
=====================================================

..............
