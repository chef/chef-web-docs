=====================================================
Release Notes: Chef Development Kit 0.19 - 1.4
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_chefdk.rst>`__

Chef Development Kit is released on a monthly schedule with new releases the third Monday of every month. Below are the major changes for each release. For a detailed list of changes see the `Chef DK on Github <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md>`__

What's New in 1.4
=====================================================

InSpec 1.25.1
-------------
* Consistent hashing for InSpec profiles
* Add platform info to json formatter
* Allow mysql_session to test databases on different hosts
* Add an oracledb_session resource
* Support new Chef Automate compliance backend
* Add command-line completions for fish shell

Cookstyle 1.3.1
---------------
* Disabled Style/DoubleNegation rule, which can be necessary in not_if / only_if blocks


What's New in 1.3
=====================================================

Chef Client 12.19
-----------------------------------------------------

ChefDK now ships with Chef 12.19. Check out `Release Notes <https://docs.chef.io/release_notes.html>`_ for all the details of this new release.

Workflow Build Cookbooks
-----------------------------------------------------

Build cookbooks generated via ``chef generate build-cookbook`` will no longer depend on the delivery_build or delivery-base cookbook. Instead, the Test Kitchen instance will use ChefDK as the standard workflow runner setup.

The build cookbook generator will not overwrite your ``config.json`` or ``project.toml`` if they exist already on your project.

ChefSpec 6.0
-----------------------------------------------------

ChefDK includes the new ChefSpec 6.0 release with improvements to the ServerRunner behavior. Rather than creating a Chef Zero instance for each ServerRunner test context, a single Chef Zero instance is created that all ServerRunner test contexts will leverage. The Chef Zero instance is reset between each test case, emulating the existing behavior without needing a monotonically increasing number of Chef Zero instances.

Additionally, if you are using ChefSpec to test a pre-defined set of Cookbooks, there is now an option to upload those cookbooks only once, rather than before every test case. To take advantage of this performance enhancer, simply set the ``server_runner_clear_cookbooks`` RSpec configuration value to ``false`` in your ``spec_helper.rb``.

.. code-block:: ruby

   RSpec.configure do |config|
     config.server_runner_clear_cookbooks = false
   end

Setting ``server_runner_clear_cookbooks`` value to ``false`` has been shown to increase the ServerRunner performance by 75%, improve stability on Windows, and make the ServerRunner as fast as SoloRunner.

This new release also includes three new matchers: ``dnf_package``, ``msu_package``, and ``cab_package`` and utilizes the new Fauxhai 4.0 release. This release adds several new platforms and removes many older end-of-life platforms. See `PLATFORMS.md <https://github.com/customink/fauxhai/blob/master/PLATFORMS.md>`_ for a list of all supported platforms for use in ChefSpec.

InSpec
-----------------------------------------------------

InSpec has been updated to 1.19.1 with the following new functionality:

- Better filter support for the `processes resource <http://inspec.io/docs/reference/resources/processes/>`_.
- New ``packages``, ``crontab``, ``x509_certificate``, and ``x509_private_key`` resources
- New ``inspec habitat profile create`` command to create a Habitat artifact for a given InSpec profile.
- Functional JUnit reporting
- A new command for generating profiles has been added

Foodcritic
-----------------------------------------------------

Foodcritic has been updated to 10.2.2. This release includes the following new functionality

- FC003, which required gating certain code when running on Chef Solo has been removed
- FC023, which preferred conditional (only_if / not_if) code within resources has been removed as many disagreed with this coding style
- False positives in FC007 and FC016 have been resolved
- New rules have been added requiring the license (FC068), supports (FC067), and chef_version (FC066) metadata properties in cookbooks

Kitchen EC2 Driver
-----------------------------------------------------

Kitchen-ec2 has been updated to 1.3.2 with support for Windows 2016 instances

Cookbook generator improvements
-----------------------------------------------------

``chef generate cookbook`` has been updated to better generate cookbooks for sharing with the Chef community. Generated cookbooks now require Chef client 12.1+, include the chef_version metadata, and use SPDX standard license strings.

Notable Updated Gems
-----------------------------------------------------

- berkshelf 5.6.0 -> 5.6.4
- chef-provisioning 2.1.0 -> 2.2.1
- chef-provisioning-aws 2.1.0 -> 2.2.0
- chef-zero 5.2.0 -> 5.3.1
- chef 12.18.31 -> 12.19.36
- cheffish 4.1.0 -> 5.0.1
- chefspec 5.3.0 -> 6.2.0
- cookstyle 1.2.0 -> 1.3.0
- fauxhai 3.10.0 -> 4.1.0
- foodcritic 9.0.0 -> 10.2.2
- inspec 1.11.0 -> 1.19.1
- kitchen-dokken 1.1.0 -> 2.1.2
- kitchen-ec2 1.2.0 -> 1.3.2
- kitchen-vagrant 1.0.0 -> 1.0.2
- mixlib-install 2.1.11 -> 2.1.12
- opscode-pushy-client 2.1.2 -> 2.2.0
- specinfra 2.66.7 -> 2.67.7
- test-kitchen 1.15.0 -> 1.16.0
- train 0.22.1 -> 0.23.0

What's New in 1.2
=====================================================

Delivery CLI
-----------------------------------------------------

- The ``project.toml`` file, which can be used to execute `local phases </delivery_cli.html#delivery-local>`_, now supports:

  - An optional ``functional`` phase.
  - New ``remote_file`` option to specify a remote ``project.toml``.
  - The ability to run stages (collection of phases).
- Fixed bug where the generated ``project.toml`` file did not include the prefix `chef exec` for some phases.
- Project git remotes will now update automatically, if applicable, based on the values in the ``cli.toml`` or options provided through the command-line.
- Project names specified in project config (``cli.toml``) or options provided through the command-line will now be honored.

Policyfiles
-----------------------------------------------------

- Added a ``chef_server`` default source option to `Policyfiles </config_rb_policyfile.html#settings>`_.

Automate Workflow Adopts SSH for Cookbook Generation
-----------------------------------------------------

The ``chef generate cookbook`` command now uses the SSH based job dispatch system as its default behavior. For more details on this new system and how to use it, see `Job Dispatch Docs <https://docs.chef.io/runners.html>`_

FIPS (Windows and RHEL only)
-----------------------------------------------------
- ChefDK now comes bundled with the Stunnel tool and the FIPS OpenSSL module for users who need to enforce FIPS compliance.
- Support for FIPS options in `delivery` CLI's ``cli.toml`` was added to handle communication with the Automate Server when FIPS mode is enabled.

Notable Updated Gems
-----------------------------------------------------

- berkshelf 5.2.0 -> 5.5.0
- chef 12.17.44 -> 12.18.31
- chef-provisioning 2.0.2 -> 2.1.0
- chef-vault 2.9.0 -> 2.9.1
- chef-zero 5.1.0 -> 5.2.0
- cheffish 4.0.0 -> 4.1.0
- cookstyle 1.1.0 -> 1.2.0
- foodcritic 8.1.0 -> 8.2.0
- inspec 1.7.2 -> 1.10.0
- kitchen-dokken 1.0.9 -> 1.1.0
- kitchen-vagrant 0.21.1 -> 1.0.0
- knife-windows 1.7.1 -> 1.8.0
- mixlib-install 2.1.9 -> 2.1.10
- ohai 8.22.1 -> 8.23.0
- test-kitchen 1.14.2 -> 1.15.0
- train 0.22.0 -> 0.22.1
- winrm 2.1.0 -> 2.1.2

What's New in 1.1
=====================================================

New InSpec Test Location
-----------------------------------------------------

To address bugs and confusion with the previous ``test/recipes`` location, all newly generated
cookbooks and recipes will place their InSpec tests in ``test/smoke/default``. This
placement creates the association of the `smoke` phase in Chef Automate and the `default` Test Kitchen suite
where the tests are run.

Default Docker image in kitchen-dokken is now official Chef image
------------------------------------------------------------------

`chef/chef <https://hub.docker.com/r/chef/chef>`_ is now the default Docker image used in `kitchen-dokken <https://github.com/someara/kitchen-dokken>`_.

New Test Kitchen driver caching mechanisms
-----------------------------------------------------

Test Kitchen will automatically cache downloaded chef-client packages for use between provisions.
For people who use the ``kitchen-vagrant`` driver to run Chef, it will automatically consume the
new caching mechanism to share the client packages to the guest VM, meaning that you no longer
have to wait for the client to download on every guest provision.

In addition, if the chef-client packages are already cached, then it is now possible to use
Test Kitchen completely off-line.

Cookstyle 1.1.0 with new code linting Cops
-----------------------------------------------------

Cookstyle has been updated from ``0.0.1`` to ``1.1.0``, which upgrades the RuboCop engine from ``0.39``
to ``0.46``, and enables several new cops. This will most likely result in Cookstyle warnings on
cookbooks that previously passed.

**Newly Disabled Cops:**

- Metrics/CyclomaticComplexity
- Style/NumericLiterals
- Style/RegexpLiteral in 'tests' directory
- Style/AsciiComments
- Style/TernaryParentheses
- Metrics/ClassLength
- All rails/* cops

**Newly Enabled Cops:**

- Bundler/DuplicatedGem
- Style/SpaceInsideArrayPercentLiteral
- Style/NumericPredicate
- Style/EmptyCaseCondition
- Style/EachForSimpleLoop
- Style/PreferredHashMethods
- Lint/UnifiedInteger
- Lint/PercentSymbolArray
- Lint/PercentStringArray
- Lint/EmptyWhen
- Lint/EmptyExpression
- Lint/DuplicateCaseCondition
- Style/TrailingCommaInLiteral
- Lint/ShadowedException

New DCO tool included
-----------------------------------------------------

We have included a new DCO command-line tool that makes it easier to contribute to projects like
Chef that use the Developer Certificate of Origin. The tool allows you to enable/disable DCO
sign-offs for each repository and also allows you to retroactively sign off all commits on
a branch. See https://github.com/coderanger/dco for details.

Notable Upgraded Gems
-----------------------------------------------------

- chef ``12.16.42`` -> ``12.17.44``
- ohai ``8.21.0`` -> ``8.22.0``
- inspec ``1.4.1`` -> ``1.7.2``
- train ``0.21.1`` -> ``0.22.0``
- test-kitchen ``1.13.2`` -> ``1.14.2``
- kitchen-vagrant ``0.20.0`` -> ``0.21.1``
- winrm-elevated ``1.0.1`` -> ``1.1.0``
- winrm-fs ``1.0.0`` -> ``1.0.1``
- cookstyle ``0.0.1`` -> ``1.1.0``

What's New in 1.0
=====================================================

Version 1.0!
-----------------------------------------------------

We're recognizing ChefDK's continued stability with the honor of a 1.0 tag. There
is nothing in this release that breaks backwards compatibility with previous
installations of ChefDK: it is simply a formal recognition of the stability of
the product.

Foodcritic
-----------------------------------------------------

* Foodcritic constraint updated to require v8.0 or greater.
* Supermarket Foodcritic rules are now disabled by default when you run ``chef generate cookbook``.

Inspec
-----------------------------------------------------

The ``inspec`` command is now included in the PATH managed by ChefDK. Just run
``chef shell-init`` to update your PATH.

knife-opc
-----------------------------------------------------

`Knife OPC <https://github.com/chef/knife-opc>`_ is now bundled with ChefDK adding chef server organization and user commands to knife

Notable Upgraded Gems
-----------------------------------------------------

- chef ``12.15.19`` -> ``12.16.42``
- inspec ``1.2.0`` -> ``1.4.1``
- train ``0.20.1`` -> ``0.21.1``
- kitchen-dokken ``1.0.3`` -> ``1.0.4``
- kitchen-inspec ``0.15.2`` -> ``0.16.1``
- berkshelf ``5.1.0`` -> ``5.2.0``
- fauxhai ``3.9.0`` -> ``3.10.0``
- foodcritic ``7.1.0`` -> ``8.1.0``

What's New in 0.19
=====================================================

InSpec 1.2.0
-----------------------------------------------------
InSpec Updated to v1.2.0. See the `InSpec CHANGELOG <https://github.com/chef/inspec/blob/v1.2.0/CHANGELOG.md>`_ for details.

Mixlib::Install
-----------------------------------------------------

New ``mixlib-install`` command allows you to quickly download Chef binaries. Run ``mixlib-install help`` for command usage.

Delivery CLI
-----------------------------------------------------
* Deprecation of Github V1 backed project initialization.
* Initialization of Github V2 backed projects (``delivery init --github``). Requires Chef Automate server version ``0.5.432`` or above.
* Project name verification with repository name for projects with Source Control Management (SCM) integration.
* Increased clarity of the command structure by introducing the ``--pipeline`` alias for the ``--for`` option.
* Honor custom config on project initialization (``delivery init -c /my/config.json``).
* Build cookbook is now generated using the more appropriate ``chef generate build-cookbook`` on project initialization.
* Support providing your password non-interactively to ``delivery token`` via the ``AUTOMATE_PASSWORD`` environment variable (``AUTOMATE_PASSWORD=password delivery token``).

Notable Upgraded Gems
-----------------------------------------------------

- chef ``12.14.89`` -> ``12.15.19``
- inspec ``1.0.0`` -> ``1.2.0``
- kitchen-dokken ``1.0.0`` -> ``1.0.3``
- knife-windows ``1.6.0`` -> ``1.7.0``
- mixlib-install ``2.0.1`` -> ``2.1.1``
- winrm ``2.0.3`` -> ``2.1.0``


Changelog
=====================================================
https://github.com/chef/chef-dk/blob/master/CHANGELOG.md
