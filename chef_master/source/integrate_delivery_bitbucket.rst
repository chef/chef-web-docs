=====================================================
Integrate Chef Automate Workflow with Bitbucket
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_delivery_bitbucket.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

Bitbucket integration with Chef Automate allows Bitbucket to be used as the canonical git repository for projects while at the same time benefiting from Chef Automate workflow and pipeline automation. When Bitbucket integration is enabled for a project in Bitbucket, you will be able to:

* Review pull requests and make code comments in the Bitbucket webui
* Browse code (including in-flight changes in the Chef Automate pipeline) using Bitbucket
* Have the target branch (usually master) of a Bitbucket project repository be managed by Chef Automate. When a change is approved in Chef Automate, it will perform the merge in Bitbucket

Bitbucket integration is designed for use with Bitbucket 3.x or 4.x and supports connecting a Chef Automate enterprise with a single Bitbucket server URL. Chef Automate does not support Bitbucket project repositories that are hosted at https://bitbucket.org at this time. Chef Automate communicates with Bitbucket using the Bitbucket REST API and HTTP-based git protocol. Chef Automate authenticates with Bitbucket with a user account over HTTP basic authentication. It is recommended that the connection be protected using SSL.

Trust SSL Certificate
=====================================================
Run the following steps to set up self-signed certificates for Chef Automate.

.. note:: This is only required if the Bitbucket uses a self-signed SSL certificate or an internal certificate authority.

Debian
-----------------------------------------------------
For the Debian platform, do the following:

#. Log into the Chef Automate server as root.
#. Run the following command:

   .. code-block:: bash

      cd /usr/local/share/ca-certificates

#. Run the following command:

   .. code-block:: bash

      openssl s_client -showcerts -connect {BITBUCKET_SERVER}:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >{BITBUCKET_SERVER}.crt

#. Run the following command:

   .. code-block:: bash

      update-ca-certificates

RHEL, Centos
-----------------------------------------------------
For Red Hat Enterprise Linux (6.x and higher) and CentOS (6.x and higher), do the following:

#. Log into the Chef Automate server as root.
#. Run the following command:

   .. code-block:: bash

      yum install ca-certificates

   .. note:: For 6.x servers, run this command only once.

#. Run the following command:

   .. code-block:: bash

      update-ca-trust force-enable

   .. note:: For 6.x servers, run this command only once.

#. Run the following command:

   .. code-block:: bash

      cd /etc/pki/ca-trust/source/anchors/

#. Run the following command:

   .. code-block:: bash

      openssl s_client -showcerts -connect {BITBUCKET_SERVER}:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >{BITBUCKET_SERVER}.crt

#. Run the following command:

   .. code-block:: bash

      update-ca-trust extract

Set up Integration
=====================================================
Bitbucket integration with Chef Automate has the following requirements:

#. Shell access with ``sudo`` permission to the Chef Automate server
#. A Chef Automate user account with ``admin`` role in the Chef Automate enterprise used for this integration
#. The URL for the Bitbucket instance
#. The username and password of a Bitbucket user to use as the service account. This user must have full access (read/write) to the projects you wish to add to Chef Automate

Add to Chef Automate
-----------------------------------------------------
In the Chef Automate web UI, open the SCM setup page, and then complete the following fields:

* **Bitbucket URL** - The URL for your Bitbucket instance.
* **Bitbucket Username** - The username of the service account that Chef Automate will use to interact with Bitbucket.
* **Bitbucket Password** - The password for the service account.

Then submit the form to complete this step.

Remove from Chef Automate
-----------------------------------------------------
To remove integration with Bitbucket:

#. Update all projects that are integrated with Bitbucket to be integrated with Chef Automate.
#. In the Chef Automate webui, open the **SCM Setup** page.
#. Click the **Remove Link** button.

Update Integration
-----------------------------------------------------
To update integration with Bitbucket:

#. In the Chef Automate web UI, open the **SCM Setup** page, and update Bitbucket credentials and make changes to the appropriate information.
#. Click the **Update** button.

Create a Project
=====================================================
Repeat these steps for each Bitbucket project to be added to Chef Automate:

#. A project repository in Bitbucket with at least one commit.
#. The service account used by Chef Automate must have full access to this repository.
#. All team members should have read-only access to this repository. Chef Automate will manage creation of pull requests and merging of pull requests to Bitbucket.

Add an Empty Project
-----------------------------------------------------
Use the following steps to add an empty project from the Chef Automate web UI:

#. Open the page for the organization in the Chef Automate webui, and then click **Add a New Project**.
#. Select the **Bitbucket** option from the **Source Code Provider** bar, and then and enter the Bitbucket project key, repository, and target branch.
#. Click **Save & Close**.

Import Project
-----------------------------------------------------
You can repeat these steps for each Bitbucket project to be added to Chef Automate:

#. Create a local clone of the project **from Bitbucket** and ``cd`` into it.
#. Create a ``.delivery/cli.toml`` using ``delivery setup``:

   .. code-block:: bash

      $ delivery setup --ent=$DELIVERY_ENTERPRISE --org=$DELIVERY_ORG --user=$DELIVERY_USER_NAME --server=$DELIVERY_SERVER

#. Run ``delivery init`` to push the code to the empty project in Chef Automate (as created above). After importing the code, this command will generate a ``.delivery/config.json`` file, create a build cookbook, and submit a change to Chef Automate to initialize a pipeline for the project. Changes are opened in the Chef Automate web UI. At this point, a corresponding pull request is shown in Bitbucket.

   .. tag delivery_cli_init_bitbucket_project

   To initialize a project using a Bitbucket repository, run a command similar to:

   .. code-block:: bash

      $ delivery init --bitbucket PROJECT_KEY -r REPO_NAME

   where ``PROJECT_KEY`` is the name of the project key in Bitbucket and ``REPO_NAME`` is the name of the repository in Bitbucket. For example to initialize the ``anagrams`` repository in Bitbucket with the ``TEST`` project key:

   .. code-block:: bash

      $ delivery init --bitbucket TEST -r anagrams

   and returns output similar to:

   .. code-block:: none

      Chef Delivery
      Loading configuration from /Users/justinc/chef/delivery/organizations/sandbox/anagrams
      Is /Users/justinc/chef/delivery/organizations/sandbox/anagrams a git repo?  yes
      Creating bitbucket project: anagrams  created
      adding remote delivery: ssh://justinc@Chef@delivery.chef.co:8989/Chef/sandbox/anagrams
      Remote 'delivery' added to git config!
      Checking for content on the git remote delivery: No upstream content
      Pushing local content to server:
      To ssh://justinc@Chef@delivery.chef.co:8989/Chef/sandbox/anagrams
      *   refs/heads/master:refs/heads/master [new branch]
      Branch master set up to track remote branch master from delivery.
      Done

      Creating and checking out add-delivery-config feature branch: done
      Generating build cookbook skeleton
      Using cached copy of build-cookbook generator "/Users/justinc/.delivery/cache/generator-cookbooks/pcb"
      Build-cookbook generated: "chef" "generate" "cookbook" ".delivery/build-cookbook" "-g" "/Users/justinc/.delivery/cache/generator-cookbooks/pcb"
      Adding and committing build-cookbook: done
      Writing configuration to /Users/justinc/chef/delivery/organizations/sandbox/anagrams/.delivery/config.json
      New delivery configuration
      --------------------------
      {
        "version": "2",
        "build_cookbook": {
          "name": "build-cookbook",
          "path": ".delivery/build-cookbook"
        },
        "skip_phases": [],
        "build_nodes": {},
        "dependencies": []
      }
      Git add and commit delivery config: done
      Chef Delivery
      Loading configuration from /Users/justinc/chef/delivery/organizations/sandbox/anagrams
      Review for change add-delivery-config targeted for pipeline master
      Created new patchset
      https://delivery.chef.co/e/Chef/#/organizations/sandbox/projects/anagrams/changes/695f2bb9-ab21-4adf-a6e0-b9fc79854478
        anagrams git:(add-delivery-config)

   .. end_tag

Convert Project to Bitbucket
-----------------------------------------------------
To convert a project that is integrated with Chef Automate to one that is integrated with Bitbucket:

#. Ensure that a project repository exists in Bitbucket with at least one commit.
#. Ensure that the service account used by Chef Automate has full access to this project repository.
#. Ensure that team members who will use this project have read-only access to this project repository. (Chef Automate will manage the creation and merging of pull requests.)
#. In the Chef Automate web user interface, open the **Organizations** page.
#. Click the pencil button for the project to be updated.
#. Click the **Bitbucket** tab.
#. Enter the project key and the project repository name.
#. Click **Save and Close**.

Convert Project to Chef Automate
-----------------------------------------------------
To convert a project that is integrated with Bitbucket to one that is integrated with Chef Automate:

#. Merge or close all open changes for the project.
#. In the Chef Automate webui, open the **Organizations** page.
#. Click the pencil button for the project to be updated.
#. Click the **Chef Delivery** tab.
#. Click **Save and Close**.

Update Bitbucket Project
-----------------------------------------------------
To update the information for a project that is integrated with Bitbucket:

#. In the Chef Automate web UI, open the **Organizations** page.
#. Click the pencil button for the project to be updated.
#. Click the **Bitbucket** tab.
#. Edit the project key and the project repository name.
#. Click **Save and Close**.

Workflow w/Bitbucket
=====================================================
This section describes the setup and workflow for a team member who will interact with a Bitbucket project that is integrated with Chef Automate. It is assumed that the initial project is created, imported, and that a Chef Automate pipeline already exists.

Delivery CLI
-----------------------------------------------------
Perform the following steps to install the Delivery CLI and setup your project:

#. `Install the Delivery CLI </delivery_cli.html#install-delivery-cli>`__.
#. In the command shell, create or navigate to the directory in which project repositories are located.
#. Use the ``delivery setup`` command with the following arguments to create the ``.delivery/cli.toml`` file:

   .. code-block:: bash

      $ delivery setup --ent=$DELIVERY_ENTERPRISE --org=$DELIVERY_ORG --user=$DELIVERY_USER --server=$DELIVERY_SERVER

#. Create a local clone of the project repository:

   .. code-block:: bash

      $ delivery clone $PROJECT

   If the project is cloned from Bitbucket (or if a pre-existing clone is used), add it using ``delivery remote``. The URL for ``delivery clone`` can be found on the project's page in the Chef Automate web UI.

#. Create a remote with the following:

   .. code-block:: bash

      $ git remote add delivery $DELIVERY_CLONE_URL

Create a Change
-----------------------------------------------------
Use the following steps to create a change in Chef Automate:

#. Create and check out a topic branch for the change, based on the current state of your project's pipeline (usually from ``master``). For example: ``git checkout -b great-feature``.
#. Make and commit changes to the project as normal.
#. Submit the change to Chef Automate with the command ``delivery review``. This command will open a URL at which details and progress of the change may be viewed from the Chef Automate web UI.
#. Verification of changes will begin automatically and a corresponding pull request will be opened in Bitbucket.

Code Review
-----------------------------------------------------
You may conduct a code review using either Chef Automate or Bitbucket. However, merging a pull request is handled by Chef Automate and occurs when a change in Chef Automate is approved. You cannot merge the pull request from within Bitbucket.

To perform code review using Chef Automate:

#. Use the URL created by ``delivery review`` to go directly to the change in the Chef Automate web UI, or browse to the change from the Chef Automate dashboard.
#. Click the **Review** tab.
#. Browse the changes and make comments.

Approve a Change
-----------------------------------------------------
When verification is finished in Chef Automate and the code has been reviewed and is ready to be merged, approve the change. The pull request will be merged and closed in Bitbucket. The feature branch will also be deleted in Bitbucket.

#. Use the URL created by ``delivery review`` to go directly to the change in the Chef Automate web UI, or browse to the change from the Chef Automate dashboard.
#. Click the **Review** tab.
#. Click **Approve**.

Delete a Change
-----------------------------------------------------
When verification is finished in Chef Automate, the code has been reviewed, and it is decided the change should never be approved, delete the change in Chef Automate; the pull request will be declined and closed in Bitbucket. The feature branch will also be deleted in Bitbucket.

Use the URL created by ``delivery review`` to go directly to the change, or browse to the change from the dashboard in the Chef Automate web UI.

#. Click the **Review** tab.
#. Click **Delete**.
