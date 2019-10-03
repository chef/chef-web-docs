=====================================================
Delivery CLI
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/delivery_cli.rst>`__

.. meta::
    :robots: noindex

The Delivery CLI is the command-line interface for the workflow capabilities in Chef Automate. It sits in-between a local git repository and the Chef Automate server.

Install Delivery CLI
=====================================================
.. tag delivery_cli_install

The Delivery CLI is required for the workstation and for many Chef Automate functions. It is included in ChefDK and can be obtained by `installing the latest version </install_dk.html>`__.

.. note:: You must delete your old Delivery CLI if you installed it prior to it being included in ChefDK.

.. end_tag

Configure Delivery CLI
=====================================================
.. tag delivery_cli_configure

Before you use the Delivery CLI from a workstation, you need to provide it with details such as the URL of the Chef Automate server, and the names of the relevant enterprise, organization, and user. The ``delivery setup`` subcommand creates a configuration file named ``.delivery/cli.toml`` with the required information.

The placement of the ``.delivery`` directory in your file hierarchy is significant. Like git, Delivery CLI commands search the current directory and parent directories to locate server settings. Because server settings are unique to an organization, we recommend that you create a directory for each organization you belong to and run the ``delivery setup`` command from that directory.

.. code-block:: bash

   $ delivery setup --server=DELIVERY_SERVER_IP_ADDR --ent=ENTERPRISE --org=ORGANIZATION --user=USERNAME

The following settings may be added to the ``.delivery/cli.toml`` file:

``auto_bump``
   Bumps the cookbook metadata version number automatically when ``delivery review`` is run. Default value: ``false``.

.. end_tag

Run Delivery CLI in FIPS Mode
=====================================================
.. tag fips_intro

Federal Information Processing Standards (FIPS) are federal standards for computer systems used by contractors of government agencies and non-military government agencies.

FIPS 140-2 is a specific federal government security standard used to approve cryptographic modules. Chef Automate uses the OpenSSL FIPS Object Module, which satisfies the requirements of software cryptographic modules under the FIPS 140-2 standard. The OpenSSL Object Module provides an API for invoking FIPS approved cryptographic functions from calling applications.

.. end_tag

See the main `FIPS documentation </fips.html>`__ for more information on what FIPS is and how to enable it.

.. tag delivery_cli_fips

How to enable FIPS mode for the Chef Automate server
==================================================================

Prerequisites
------------------------------------------------------------------
* Supported Systems - CentOS or Red Hat Enterprise Linux 6 or later
* Chef Automate version ``0.7.100`` or greater

Configuration
------------------------------------------------------------------
If you have FIPS compliance enabled in the operating system at the kernel level
and install or reconfigure the Chef Automate server then it will default to
running in FIPS mode.

A Chef Automate server running in FIPS mode can only communicate with workstations that are
also running in FIPS mode.

If you do need to use FIPS mode, there are a few steps to get it up and running in Delivery CLI on your workstation.

Check if Chef Automate server has enabled FIPS mode
-----------------------------------------------------

You can see if your Chef Automate server is in FIPS mode by running ``delivery status``. It will say ``FIPS mode: enabled`` if it is enabled as well as output some instructions on how to set up
your ``cli.toml`` to enable FIPS mode locally. If ``delivery status`` reports either ``FIPS mode: disabled`` or FIPS is missing completely from the report, please see `FIPS kernel settings </fips.html#fips-kernel-settings>`_ on how to enable FIPS mode in your Chef Automate server before proceeding.

Enable FIPS mode in your cli.toml file
-----------------------------------------------------

Now that you have confirmed that the Chef Automate server is in FIPS mode, you must enable FIPS mode locally on your workstation for Delivery CLI.
This can be done by adding the following to your ``.delivery/cli.toml``:

.. code-block:: none

   fips = true
   fips_git_port = "OPEN_PORT"
   fips_custom_cert_filename = "/full/path/to/your/certificate-chain.pem" # optional

Replace ``OPEN_PORT`` with any port that is free locally on localhost.

If you are using a custom certificate authority or a self-signed certificate then you will need the third option. This file should contain to the entire certificate chain in `pem` format. See `FIPS Certificate Management </fips#certificate_management>`_ for an example on how to generate the file.

How to enable FIPS mode for workstations
==================================================================

A workstation is a computer running Chef Workstation that is used to author cookbooks, interact with the Chef Infra Server, and interact with nodes.

Prerequisites
------------------------------------------------------------------
* Supported Systems - Windows, CentOS and Red Hat Enterprise Linux

Now that FIPS mode is enabled in your ``.delivery/cli.toml``, running any project-specific Delivery CLI command will automatically use FIPS-compliant encrypted git traffic between your
workstation and the Chef Automate server. As long as the Chef Automate server is in FIPS mode, no other action is needed on your part to operate Delivery CLI in FIPS mode.
If you ever stop using FIPS mode on the Chef Automate server, simply delete the above two lines from your ``.delivery/cli.toml`` file and Delivery CLI will stop running in FIPS mode.

.. note:: You could also pass ``--fips`` and ``--fips-git-port=OPEN_PORT`` into project specific commands if you do not wish to edit your ``.delivery/cli.toml``. See list of commands below for details..

.. end_tag

.. _delivery-cli-api:

delivery api
=====================================================
Use the ``api`` subcommand to make an HTTP request to the Chef Automate API using the ``--data`` option to specify the JSON that contains the data in the request. This request must be authorized using a token generated by the ``token`` subcommand.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery api METHOD PATH (options)

where:

* ``METHOD`` is an HTTP method (``GET``, ``POST``, ``PUT``, ``DELETE``) that is supported by the Chef Automate API
* ``PATH`` is an endpoint in the Chef Automate API scoped to the specified Chef Automate enterprise

Options
-----------------------------------------------------
This subcommand has the following options:

``--api-port=PORT``
   The HTTP port on which the Chef Automate API is listening.

``--config-path=PATH``
   The path for the directory in which configuration is written.

``-d=DATA``, ``--data=DATA``
   The JSON data to submit to the Chef Automate API.

``-e=ENTERPRISE``, ``--ent=ENTERPRISE``
   A configured Chef Automate enterprise.

``-o=ORGANIZATION``, ``--org=ORGANIZATION``
   An organization inside a Chef Automate enterprise.

``-s=SERVER``, ``--server=SERVER``
   The server on which Chef Automate is running. This must be the FQDN for the Chef Automate server. For example: ``delivery.example.com``.

``-u=USER``, ``--user=USER``
   A Chef Automate user name. This user must exist in the specified enterprise (``--ent``).

Examples
-----------------------------------------------------
A GitHub user name must be associated with Chef Automate in order for changes piped to Chef Automate created by GitHub pull requests to be associated with the corresponding Chef Automate user.

.. note:: Two GitHub accounts may not be linked to a single Chef Automate user. Two Chef Automate users may not share a single GitHub user name.

.. note:: You must have previously setup GitHub integration in order for this command to work.

**Link a GitHub enterprise user name**

.. To link a GitHub.com user name:

.. code-block:: bash

   $ delivery api put users/$DELIVERY_NAME/set-oauth-alias --data='{"app":"github-enterprise","alias":"$GITHUB_NAME"}'

**Link a GitHub.com user name**

.. To link a GitHub enterprise user name:

.. code-block:: bash

   $ delivery api put users/$DELIVERY_NAME/set-oauth-alias --data='{"app":"github","alias":"$GITHUB_NAME"}'

**Get list of blocked projects**

.. To get a list of blocked projects:

.. code-block:: bash

   $ delivery api get blocked_projects --ent ENTERPRISE --server URL

delivery checkout
=====================================================
Use the ``checkout`` subcommand to check out an open change on an existing project.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery checkout CHANGE (options)

where:

* ``CHANGE`` is the name of a feature branch

Options
-----------------------------------------------------
This subcommand has the following options:

``--fips``
   Runs command in FIPS mode. This proxies all git traffic through Stunnel FIPS encryption.

``--fips-git-port=PORT``
   The port Stunnel listens locally on when proxying git traffic.

``--fips-custom-cert-filename=PATH_TO_PEM``
   The path to a pem file that contains a self-signed certificate or certificate chain. Use this setting only when you have a custom certificate authority or a self-signed certificate.

``-P=NUMBER``, ``--patchset=NUMBER``
   The patchset number. Default value: ``latest``.

``--pipeline=PIPELINE``
   The name of a Chef Automate pipeline.

Examples
-----------------------------------------------------
None.

delivery clone
=====================================================
Use the ``clone`` subcommand to clone a Chef Automate project.

.. note:: There is a **clone** command in the Chef Automate web UI on the page for an existing project.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery clone PROJECT (options)

where:

* ``PROJECT`` is the Chef Automate project to be cloned

Options
-----------------------------------------------------
This subcommand has the following options:

``-e=ENTERPRISE``, ``--ent=ENTERPRISE``
   A configured Chef Automate enterprise.

``--fips``
   Runs command in FIPS mode. This proxies all git traffic through Stunnel FIPS encryption.

``--fips-git-port=PORT``
   The port Stunnel listens locally on when proxying git traffic.

``--fips-custom-cert-filename=PATH_TO_PEM``
   The path to a pem file that contains a self-signed certificate or certificate chain. Use this setting only when you have a custom certificate authority or a self-signed certificate.

``-g=URL``, ``--git-url=URL``
   The raw git URL for the specified project. This URL is used as the remote target for the local git checkout. If this option is used, the ``--ent``, ``--org``, ``--server``, and ``--user`` options are ignored.

``-o=ORGANIZATION``, ``--org=ORGANIZATION``
   An organization inside a Chef Automate enterprise.

``-s=SERVER``, ``--server=SERVER``
   The server on which Chef Automate is running.

``-u=USER``, ``--user=USER``
   A Chef Automate user name.

Examples
-----------------------------------------------------
None.

delivery diff
=====================================================
Use the ``diff`` subcommand to perform a ``git diff`` between the change and the pipeline.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery diff CHANGE (options)

where:

* ``CHANGE`` is the name of the feature branch associated with the change

Options
-----------------------------------------------------
This subcommand has the following options:

``--fips``
   Runs command in FIPS mode. This proxies all git traffic through Stunnel FIPS encryption.

``--fips-git-port=PORT``
   The port Stunnel listens locally on when proxying git traffic.

``--fips-custom-cert-filename=PATH_TO_PEM``
   The path to a pem file that contains a self-signed certificate or certificate chain. Use this setting only when you have a custom certificate authority or a self-signed certificate.

``-l``, ``--local``
   Run a diff against the local branch ``HEAD``.

``-P=NUMBER``, ``--patchset=NUMBER``
   The patchset number. Default value: ``latest``.

``--pipeline=PIPELINE``
   The name of a Chef Automate pipeline.

Examples
-----------------------------------------------------
None.

delivery init
=====================================================
Use the ``init`` subcommand to initialize a Chef Automate project. This will set up a local repository in the Chef Automate server, set up a pipeline, and commit a build cookbook specific to the project. Subsequent changes to this repo should be done using the ``review`` subcommand.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery init (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``--bitbucket=PROJECT_KEY``
   The Bitbucket repository to use for code review with the associated project key.

``--config-path=PATH``
   The path for the directory in which configuration is written.

``-c=PATH``, ``--config-json=PATH``
   The path to a custom ``config.json`` file.

``-e=ENTERPRISE``, ``--ent=ENTERPRISE``
   A configured Chef Automate enterprise.

``--fips``
   Runs command in FIPS mode. This proxies all git traffic through Stunnel FIPS encryption.

``--fips-git-port=PORT``
   The port Stunnel listens locally on when proxying git traffic.

``--fips-custom-cert-filename=PATH_TO_PEM``
   The path to a pem file that contains a self-signed certificate or certificate chain. Use this setting only when you have a custom certificate authority or a self-signed certificate.

``--generator=GENERATOR``
   The path to a local git repo or the URL to a custom ``build-cookbook`` generated by ChefDK. See https://github.com/chef-cookbooks/pcb for more information about using the ``chef generate`` commands in ChefDK to generate a ``build-cookbook``.

``--github=ORGANIZATION``
   The GitHub repository to use for code review with the associated organization. See ``--no-verify-ssl``.

``-l``, ``--local``
   Run locally without the Chef Automate server.

``-n``, ``--no-open``
   Prevent opening a browser that shows the pipeline in Chef Automate web UI.

``--no-verify-ssl``
   Specifies that SSL verification is not used with a GitHub repository. See ``--github``.

``-o=ORGANIZATION``, ``--org=ORGANIZATION``
   An organization inside a Chef Automate enterprise.

``-p=PROJECT``, ``--project=PROJECT``
   A project inside a Chef Automate organization.

``--pipeline=PIPELINE``
   The name of a Chef Automate pipeline.

``-r=REPO_NAME``, ``--repo-name=REPO_NAME``
   The name of the repository. This will vary, depending on whether it's located in git, GitHub, or Bitbucket.

``-s=SERVER``, ``--server=SERVER``
   The server on which Chef Automate is running.

``--skip-build-cookbook``
   Skip the creation of a ``build-cookbook`` when initializing a project.

``<type>``
   The type of project. Default value: ``cookbook``.

``-u=USER``, ``--user=USER``
   A Chef Automate user name.

Examples
-----------------------------------------------------

**Initialize project with Bitbucket repository**

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

**Initialize project with GitHub repository**

To initialize a project using a GitHub repository, run a command similar to:

.. code-block:: bash

   $ delivery init --github ORG_NAME -r REPO_NAME

where ``ORG_NAME`` is the name of the GitHub organization and ``REPO_NAME`` is the name of the repository in GitHub. For example to initialize the ``seapower`` repository in GitHub with the ``chef-cookbooks`` organization:

.. code-block:: bash

   $ delivery init --github chef-cookbooks -r seapower

and returns output similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/albertatom/chef/delivery/organizations/sandbox/seapower
   Is /Users/albertatom/chef/delivery/organizations/sandbox/seapower a git repo?  yes
   Project seapower already exists.
   Creating and checking out add-delivery-config feature branch: done
   Generating build cookbook skeleton
   Using cached copy of build-cookbook generator "/Users/albertatom/.delivery/cache/generator-cookbooks/pcb"
   Build-cookbook generated: "chef" "generate" "cookbook" ".delivery/build-cookbook" "-g" "/Users/albertatom/.delivery/cache/generator-cookbooks/pcb"
   Adding and committing build-cookbook: done
   Writing configuration to /Users/albertatom/chef/delivery/organizations/sandbox/seapower/.delivery/config.json
   New delivery configuration
   --------------------------
   {
     "version": "2",
     "build_cookbook": {
       "path": ".delivery/build-cookbook",
       "name": "build-cookbook"
     },
     "skip_phases": [],
     "build_nodes": {},
     "dependencies": []
   }
   Git add and commit delivery config: done
   Push add-delivery-config branch and create Pull Request

**Add build-cookbook from private Supermarket**

The following example shows how to add a build cookbook after the initialization process

.. code-block:: bash

   $ delivery init —skip-build-cookbook

and then update the ``config.json`` file for the ``delivery-truck`` cookbook and the path to the cookbook in a private Chef Supermarket:

.. code-block:: javascript

   {
     "version": "2",
     "build_cookbook": {
       "name": "delivery-truck",
       "supermarket": "true",
       "site": "https://private-supermarket.example.com"
     },
     ...
   }

**Initialize project with custom pipeline**

To initialize a project using a GitHub repository, run a command similar to:

.. code-block:: bash

   $ delivery init --generator PATH_TO_COOKBOOK -c PATH_TO_CONFIG -f PIPELINE

where ``PATH_TO_COOKBOOK`` is path to the cookbook generator, ``PATH_TO_CONFIG`` is the path to a ``config.json`` file, and ``PIPELINE`` is the name of a pipeline in Chef Automate. For example to initialize a pipeline using the ``bc-generator`` cookbook generator and the ``trunk`` pipeline:

.. code-block:: bash

   $ delivery init --generator https://github.com/albertatom/bc-generator.git -c /Users/albertatom/chef/delivery/.delivery/config.json -f trunk

returns output similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/albertatom/chef/delivery/organizations/sandbox/seapower
   Is /Users/albertatom/chef/delivery/organizations/sandbox/seapower a git repo?  yes
   Creating delivery project: seapower  created
   adding remote delivery: ssh://albertatom@Chef@delivery.chef.co:8989/Chef/sandbox/seapower
   Remote 'delivery' added to git config!
   Checking for content on the git remote delivery: No upstream content
   Pushing local content to server:
   To ssh://albertatom@Chef@delivery.chef.co:8989/Chef/sandbox/seapower
   *   refs/heads/master:refs/heads/master [new branch]
   Branch master set up to track remote branch master from delivery.
   Done

   Creating trunk  pipeline for project: seapower:  created
   Creating and checking out add-delivery-config feature branch: done
   Generating build cookbook skeleton
   Downloading build-cookbook generator from "https://github.com/albertatom/bc-generator.git"
   Build-cookbook generated: "chef" "generate" "cookbook" ".delivery/build-cookbook" "-g" "/Users/albertatom/.delivery/cache/generator-cookbooks/bc-generator"
   Adding and committing build-cookbook: done
   Copying configuration to /Users/albertatom/chef/delivery/organizations/sandbox/seapower/.delivery/config.json
   New delivery configuration
   --------------------------
   {
     "version": "2",
     "build_cookbook": {
       "path": ".delivery/build-cookbook",
       "name": "build-cookbook"
     },
     "skip_phases": [
       "smoke",
       "security",
       "syntax",
       "lint",
       "quality"
     ],
     "build_nodes": {},
     "delivery-truck": {
       "publish": {
         "chef_server": true
       }
     },
     "dependencies": []
   }

   Git add and commit delivery config: done
   Chef Delivery
   Loading configuration from /Users/albertatom/chef/delivery/organizations/sandbox/seapower
   Review for change add-delivery-config targeted for pipeline trunk
   Created new patchset
   https://delivery.chef.co/e/Chef/#/organizations/sandbox/projects/seapower/changes/9e5b6c36-8deb-4c5c-822c-52e2863b8bb6
     seapower git:(add-delivery-config)

delivery job
=====================================================
Use the ``job`` subcommand to execute a Chef Automate phase. This command starts two Chef Infra Client runs: the first is based on the default recipe in a build cookbook and the second is based on the specified Chef Automate phase.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery job STAGE PHASE (options)

where:

* ``STAGE`` is a stage in the Chef Automate pipeline: Verify, Build, Acceptance, Union, Rehearsal, Delivered
* ``PHASE`` is a phase, which runs recipes, in a Chef Automate stage

Options
-----------------------------------------------------
This subcommand has the following options:

``-b=BRANCH``, ``--branch=BRANCH``
   A branch name for a Chef Automate change.

``-C=CHANGE``, ``--change=CHANGE``
   A branch name for a Chef Automate change.

``--change-id=ID``
   The unique identifier for the specified Chef Automate change.

``--docker=IMAGE``
   The Docker image in which the job is run.

``-e=ENTERPRISE``, ``--ent=ENTERPRISE``
   A configured Chef Automate enterprise.

``--fips``
   Runs command in FIPS mode. This proxies all git traffic through Stunnel FIPS encryption.

``--fips-git-port=PORT``
   The port Stunnel listens locally on when proxying git traffic.

``--fips-custom-cert-filename=PATH_TO_PEM``
   The path to a pem file that contains a self-signed certificate or certificate chain. Use this setting only when you have a custom certificate authority or a self-signed certificate.

``-g=URL``, ``--git-url=URL``
   The raw git URL for the specified project. This URL is used as the remote target for the local git checkout when the job is run. If this option is used, the ``--ent``, ``--org``, ``--server``, and ``--user`` options are ignored.

``-j=PATH``, ``--job-root=PATH``
   The path to the job root.

``-l``, ``--local``
   Run locally without the Chef Automate server.

``-n``, ``--no-spinner``
   Disable the spinner.

``-o=ORGANIZATION``, ``--org=ORGANIZATION``
   An organization inside a Chef Automate enterprise.

``-p=PROJECT``, ``--project=PROJECT``
   A project inside a Chef Automate organization.

``-P=NUMBER``, ``--patchset=NUMBER``
   The patchset number. Default value: ``latest``.

``<phase>``
   The name of a Chef Automate phase.

``--pipeline=PIPELINE``
   The name of a Chef Automate pipeline.

``-s=SERVER``, ``--server=SERVER``
   The server on which Chef Automate is running.

``-S=GIT_SHA``, ``--shasum=GIT_SHA``
   The git SHA associated with a patchset.

``--skip-default``
   Skip the ``default.rb`` recipe in the ``build-cookbook``.

``-u=USER``, ``--user=USER``
   A Chef Automate user name.

Examples
-----------------------------------------------------

**Verify a job**

To run your unit tests on your local machine the same way they'd be run on Chef Automate, run the following command:

.. code-block:: bash

   $ delivery job verify unit --local

which will return output similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/adam/src/opscode/delivery/opscode/delivery-cli
   Starting job for verify unit
   Creating workspace
   Cloning repository, and merging adam/job to master
   Configuring the job
   Running the job
   Starting Chef Client, version 11.18.0.rc.1
   resolving cookbooks for run list: ["delivery_rust::unit"]
   Synchronizing Cookbooks:
     - delivery_rust
     - build-essential
   Compiling Cookbooks...
   Converging 2 resources
   Recipe: delivery_rust::unit
     * execute[cargo clean] action run
       - execute cargo clean
     * execute[cargo test] action run
       - execute cargo test

   Running handlers:
   Running handlers complete
   Chef Client finished, 2/2 resources updated in 32.770955 seconds

delivery local
=====================================================
Use the ``local`` subcommand to run a phase or stage of Chef Automate locally, based on settings in the ``project.toml`` file located in the project's ``.delivery`` directory.

.. note:: As of ChefDK 1.2, delivery local now supports options for functional phases, running stages, and specifying a remote ``project.toml``.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery local PHASE|STAGE

where ``PHASE`` is one of the following:

* lint
* syntax
* unit
* provision
* deploy
* smoke
* functional
* cleanup

and ``STAGE`` will execute a series of phases in the following order:
* verify: [lint, syntax, unit]
* acceptance: [provision, deploy, smoke, functional, cleanup]
* all: [lint, syntax, unit, provision, deploy, smoke, functional, cleanup]

Configuration
-----------------------------------------------------

**Phases**

Phases are defined in the ``project.toml`` file in the following format:

.. code-block:: ruby

   [local_phases]
   name_of_phase = "command to execute locally"

Example configuration for commands to run locally:

.. code-block:: ruby

   [local_phases]
   unit = "rspec spec/"
   lint = "cookstyle"
   syntax = "echo skipping syntax phase"

**Remote project.toml**

You can use a ``project.toml`` file located in a remote location by specifying a URI in the following format:

.. code-block:: ruby

   remote_file = "https://url-for-my-project.toml"

This is useful for teams that wish to centrally manage the behavior of the ``delivery local`` command across many different projects. Alternatively, you can provide the URI via the ``-r`` flag:

.. code-block:: bash

   $ delivery local syntax -r https://url-for-my-project.toml

Providing the URI through this manner will take precedence over anything configured in the local ``project.toml``.

Examples
-----------------------------------------------------

**Run Foodcritic**

If the ``project.toml`` file contains:

.. code-block:: ruby

   unit = "rspec spec/"
   lint = "cookstyle"
   syntax = "foodcritic . --exclude spec -f any -t \"~FC064\" -t \"~FC065\""
   provision = "chef exec kitchen create"
   deploy = "chef exec kitchen converge"
   smoke = "chef exec kitchen verify"
   cleanup = "chef exec kitchen destroy"

the command

.. code-block:: bash

   $ delivery local syntax

will run Foodcritic and execute the following command locally:

.. code-block:: bash

   $ foodcritic . --exclude spec -f any -t \"~FC064\" -t \"~FC065\"


**Run Verify Stage**

If the ``project.toml`` file contains:

.. code-block:: ruby

   unit = "rspec spec/"
   lint = "cookstyle"
   syntax = "foodcritic . --exclude spec -f any -t \"~FC064\" -t \"~FC065\""
   provision = "chef exec kitchen create"
   deploy = "chef exec kitchen converge"
   smoke = "chef exec kitchen verify"
   cleanup = "chef exec kitchen destroy"

the command

.. code-block:: bash

   $ delivery local verify

will run lint, syntax and unit phases in that order:

.. code-block:: bash

   Chef Delivery
   Running Verify Stage
   Running Lint Phase
   Inspecting 7 files
   .......

   7 files inspected, no offenses detected
   Running Syntax Phase

   Running Unit Phase
   .........

   Finished in 0.35973 seconds (files took 3.96 seconds to load)
   9 example, 0 failures

delivery review
=====================================================
Use the ``review`` subcommand to submit a feature branch for review as a new patchset. This either creates a new change associated with the feature branch, or adds a new patchset on an existing change in the pipeline. When the new patchset has been created, the Verify stage for the associated change is automatically triggered and runs the unit, lint and syntax phases. By default, this action opens a browser window to show the pipeline in Chef Automate.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery review (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-a``, ``--auto-bump``
   Bumps the cookbook metadata version number automatically when ``delivery review`` is run.

``--edit``
   Edit the title and description for the change.

``--fips``
   Runs command in FIPS mode. This proxies all git traffic through Stunnel FIPS encryption.

``--fips-git-port=PORT``
   The port Stunnel listens locally on when proxying git traffic.

``--fips-custom-cert-filename=PATH_TO_PEM``
   The path to a pem file that contains a self-signed certificate or certificate chain. Use this setting only when you have a custom certificate authority or a self-signed certificate.

``--no-open``
   Prevent opening a browser that shows the pipeline in Chef Automate web UI.

``--pipeline=PIPELINE``
   The name of a Chef Automate pipeline.

Examples
-----------------------------------------------------

**Bump version metadata automatically**

.. To bump version metadata automatically:

.. code-block:: bash

   $ delivery review --auto-bump

will return something similar to:

.. code-block:: none

   Chef Delivery
   Loading configuration from /Users/albertatom/delivery/organizations/sandbox/coffee
   Project coffee is a cookbook
   Validating version in metadata
   The version hasn't been updated (0.1.0)
   Bumping version to: 0.1.1
   Review for change black targeted for pipeline master
   Created new patchset
   https://delivery.chef.co/e/URL_FOR_CHANGE

delivery setup
=====================================================
Use the ``setup`` subcommand to set up the Chef Automate project. This will set up the configuration needed for a project to communicate with the Chef Automate server. Use the ``token`` subcommand to get an API token that allows authorized requests to be made to the server.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery setup (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``--config-path=DIRECTORY``
   The path for the directory in which configuration is written.

``-e=ENTERPRISE``, ``--ent=ENTERPRISE``
   A configured Chef Automate enterprise.

``-o=ORGANIZATION``, ``--org=ORGANIZATION``
   An organization inside a Chef Automate enterprise.

``--pipeline=PIPELINE``
  The name of a Chef Automate pipeline.

``-s=SERVER``, ``--server=SERVER``
   The server on which Chef Automate is running.

``-u=USER``, ``--user=USER``
   A Chef Automate user name.

Examples
-----------------------------------------------------
None.

delivery status
=====================================================
Get status information about the Chef Automate server's ``_status`` endpoint, API response time, and additional information depending on the server's configuration.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery status (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``--api-port=PORT``
   The HTTP port on which the Chef Automate API is listening.

``--json``
   Output in JSON format instead of human readable.

``--no-color``
   Prevent color output.

``-s=SERVER``, ``--server=SERVER``
   The server on which Chef Automate is running.

Examples
-----------------------------------------------------

.. code:: shell

   $ delivery status

   Status information for Automate server automate.example.com...

   Status: up (request took 75 ms)
   Configuration Mode: standalone
   FIPS Mode: enabled
   Upstreams:
   Lsyncd:
     status: not_running
   PostgreSQL:
     status: up
   RabbitMQ:
     status: up
     node_health:
       status: up
     vhost_aliveness:
       status: up

   Your Automate Server is configured in FIPS mode.
   Please add the following to your cli.toml to enable Automate FIPS mode on your machine:

   fips = true
   fips_git_port = "OPEN_PORT"

   Replace OPEN_PORT with any port that is free on your machine.

delivery token
=====================================================
Use the ``token`` subcommand to manage a Chef Automate API token.

.. note:: If you're running this command on Windows in Git Bash with MinTTY you must include ``winpty`` before ``delivery token`` to avoid errors.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ delivery token (options)

.. note:: You can also pass in your Chef Automate password through an environment variable to the `delivery token` subcommand. If this variable is set, you will not be asked to input your password.

   .. code-block:: bash

      $ AUTOMATE_PASSWORD=secret delivery token -s automate.example.com -e myent -u token

Options
-----------------------------------------------------
This subcommand has the following options:

``--api-port=PORT``
   The HTTP port on which the Chef Automate API is listening.

``-e=ENTERPRISE``, ``--ent=ENTERPRISE``
   A configured Chef Automate enterprise.

``--raw``
   Print the raw token.

``-s=SERVER``, ``--server=SERVER``
   The server on which Chef Automate is running.

``-u=USER``, ``--user=USER``
   A Chef Automate user name.

``--verify``
   Verify if a token is a valid token.

Examples
-----------------------------------------------------

**Verify a token**

.. To verify a token:

.. code-block:: bash

   $ delivery token --verify

returns something similar to:

.. code-block:: none

   Chef Delivery
   Loading configuration from /Users/dennisteck/chef/delivery
   token: GmTtD0t7asgy5KZyw//r/6etpXYfw8dfgQccjdeU=
   Verifying Token: valid
