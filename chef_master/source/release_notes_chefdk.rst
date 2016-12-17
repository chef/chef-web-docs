=====================================================
Release Notes: Chef Development Kit 0.19 - 1.1
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_chefdk.rst>`__

Chef Development Kit is released on a monthly schedule with new releases the third Monday of every month. Below are the major changes for each release. For a detailed list of changes see the `Chef CHANGELOG.md <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md>`__

What's New in 1.1
=====================================================

The following items are new for chef-dk 1.1 and/or are changes from previous versions.

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
sign-offs on a per repository basis and also allows you to retroactively sign off all commits on
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

Changelog
=====================================================
https://github.com/chef/chef-dk/blob/master/CHANGELOG.md
