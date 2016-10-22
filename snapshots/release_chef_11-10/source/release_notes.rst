=====================================================
Release Notes: chef-client 11.10
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

.. Adopted Platforms
.. =====================================================
.. .. include:: ../../includes_adopted_platforms/includes_adopted_platforms_11-10_client.rst

What's New
=====================================================
The following items are new for chef-client 11.10 and/or are changes from previous versions. The short version:

* **Use a recipe with the chef-client local mode** A recipe can now be specified when running the chef-client in local mode
* **New attributes for the group resource** Members can be removed from groups (``excluded_members``) and duplicate group identifiers are allowed (``non_unique``)
* **New compare subcommand for knife environment** Compare cookbook versions for environments
* **New attributes for git resource** The ``checkout_branch`` and ``enable_checkout`` attributes were added to allow greater specificity for branch checkouts

chef-client Options
-----------------------------------------------------
A recipe can be specified when `running the chef-client <https://docs.chef.io/ctl_chef_client.html>`_, typically when running the chef-client in local mode:

``RECIPE_FILE``
   The path to a recipe. For example, if a recipe file is in the current directory, use ``recipe_file.rb``. This is typically used with the ``--local-mode`` option.

The syntax for using this option is:

.. code-block:: bash

   $ chef-client [options] [RECIPE_FILE...]

**group** Attributes
-----------------------------------------------------
The following attributes have been added to the **group** resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``excluded_members``
     - Remove users from a group. May only be used when ``append`` is set to ``true``.
   * - ``non_unique``
     - Allow ``gid`` duplication. May only be used with the ``Groupadd`` provider. Default value: ``false``.

**git** Attributes
-----------------------------------------------------
The following attributes have been added to the **git** resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``checkout_branch``
     - Do a one-time checkout from git **or** use when a branch in the upstream repository is named ``deploy``. To prevent the **git** resource from attempting to check out master from master, set ``enable_checkout`` to ``false`` when using the ``checkout_branch`` property. Default value: ``deploy``.
   * - ``enable_checkout``
     - Check out a repo from master. Set to ``false`` when using the ``checkout_branch`` attribute to prevent the **git** resource from attempting to check out master from master. Default value: ``true``.

knife environment compare
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_environment_compare.rst

**Syntax**

.. include:: ../../includes_knife/includes_knife_environment_compare_syntax.rst

**Options**

.. include:: ../../includes_knife/includes_knife_environment_compare_options.rst

**Example**

.. code-block:: bash

   $ knife environment compare development staging

will return something similar to:

.. code-block:: bash

               development  staging
   apache      2.3.1        1.2.2
   windows     4.1.2        1.0.0
   postgresql  1.0.0        1.0.0


What's Fixed
=====================================================

The following bugs were fixed:

* `CHEF-1260 <http://tickets.opscode.com/browse/CHEF-1260>`_  --- File Resource shouldn't checksum large files if checksum is not needed
* `CHEF-1459 <http://tickets.opscode.com/browse/CHEF-1459>`_  --- Chef::Provider::Group::Pw doesn't support append members on FreeBSD
* `CHEF-1699 <http://tickets.opscode.com/browse/CHEF-1699>`_  --- Getting group not working right after useradd
* `CHEF-1977 <http://tickets.opscode.com/browse/CHEF-1977>`_  --- recipes added via include_recipe are not found via search for recipes:<name>
* `CHEF-2418 <http://tickets.opscode.com/browse/CHEF-2418>`_  --- 'knife ssh' should prompt for user password
* `CHEF-2688 <http://tickets.opscode.com/browse/CHEF-2688>`_  --- group resource fails if group already exists
* `CHEF-3012 <http://tickets.opscode.com/browse/CHEF-3012>`_  --- Windows group provider is not idempotent for domain users
* `CHEF-3041 <http://tickets.opscode.com/browse/CHEF-3041>`_  --- Group::Aix provider should have specs
* `CHEF-3042 <http://tickets.opscode.com/browse/CHEF-3042>`_  --- Group::Suse provider should have specs
* `CHEF-3297 <http://tickets.opscode.com/browse/CHEF-3297>`_  --- The groupmod provider should allow you to remove individual users
* `CHEF-3531 <http://tickets.opscode.com/browse/CHEF-3531>`_  --- data bags searched by the 'users' cookbook can't have dots in the value for 'id'
* `CHEF-3539 <http://tickets.opscode.com/browse/CHEF-3539>`_  --- inconsistent man page for chef-client
* `CHEF-3582 <http://tickets.opscode.com/browse/CHEF-3582>`_  --- whyrun mode fails for user resource lock action
* `CHEF-3651 <http://tickets.opscode.com/browse/CHEF-3651>`_  --- group provider on suse Linux adds user multiple times
* `CHEF-3691 <http://tickets.opscode.com/browse/CHEF-3691>`_  --- Windows provider for service resource automatically times out after 60 seconds
* `CHEF-3734 <http://tickets.opscode.com/browse/CHEF-3734>`_  --- add options to control "git checkout -b deploy"
* `CHEF-3857 <http://tickets.opscode.com/browse/CHEF-3857>`_  --- allow convert attributes to ruby hashes for easy modification
* `CHEF-3940 <http://tickets.opscode.com/browse/CHEF-3940>`_  --- Chef::Provider::Git with user attribute queries /root/.conf/git/config
* `CHEF-3983 <http://tickets.opscode.com/browse/CHEF-3983>`_  --- control-c during chef-client runs leave yum-dump.py child processes around
* `CHEF-4093 <http://tickets.opscode.com/browse/CHEF-4093>`_  --- knife environment compare
* `CHEF-4110 <http://tickets.opscode.com/browse/CHEF-4110>`_  --- ruby_blocks should support why_run
* `CHEF-4347 <http://tickets.opscode.com/browse/CHEF-4347>`_  --- Typo in generated cookbook README when using knife
* `CHEF-4358 <http://tickets.opscode.com/browse/CHEF-4358>`_  --- Chef client fails when invoked with an empty environment
* `CHEF-4363 <http://tickets.opscode.com/browse/CHEF-4363>`_  --- Unable to add event handlers from config file
* `CHEF-4379 <http://tickets.opscode.com/browse/CHEF-4379>`_  --- Adding runtime in stdout for Chef 11
* `CHEF-4420 <http://tickets.opscode.com/browse/CHEF-4420>`_  --- mailto attribute in Cron resource can not be removed once set
* `CHEF-4421 <http://tickets.opscode.com/browse/CHEF-4421>`_  --- Improve "No cookbook found" error message
* `CHEF-4439 <http://tickets.opscode.com/browse/CHEF-4439>`_  --- A single character is valid user name in linux/unix (hence valud owner of a file)
* `CHEF-4441 <http://tickets.opscode.com/browse/CHEF-4441>`_  --- decrypting an encrypted data bag w/o a key now throws "can't convert nil into String"
* `CHEF-4498 <http://tickets.opscode.com/browse/CHEF-4498>`_  --- install.sh doesn't work on FreeBSD 9.1
* `CHEF-4616 <http://tickets.opscode.com/browse/CHEF-4616>`_  --- Chef-client Cannot Handle Bare IPv6 In chef_server_url
* `CHEF-4632 <http://tickets.opscode.com/browse/CHEF-4632>`_  --- Loosen JSON dependency to support 1.8.0+
* `CHEF-4633 <http://tickets.opscode.com/browse/CHEF-4633>`_  --- deep merge should not re-assign dest var for every key in a source hash
* `CHEF-4639 <http://tickets.opscode.com/browse/CHEF-4639>`_  --- writing credentials files with `file` or `template` may leak credentials in diffs
* `CHEF-4673 <http://tickets.opscode.com/browse/CHEF-4673>`_  --- change doc URL in shell to docs.opscode.com
* `CHEF-4676 <http://tickets.opscode.com/browse/CHEF-4676>`_  --- depend on net-ssh-multi 1.2.0
* `CHEF-4700 <http://tickets.opscode.com/browse/CHEF-4700>`_  --- Remove an unused variable in spec/unit/client_spec.rb
* `CHEF-4703 <http://tickets.opscode.com/browse/CHEF-4703>`_  --- Refactor handle_command_failures method.
* `CHEF-4709 <http://tickets.opscode.com/browse/CHEF-4709>`_  --- knife bootstrap of Solaris fails again
* `CHEF-4725 <http://tickets.opscode.com/browse/CHEF-4725>`_  --- Chef 11.8 buffers all output until the end of the run instead of displaying as it runs
* `CHEF-4730 <http://tickets.opscode.com/browse/CHEF-4730>`_  --- knife environment compare
* `CHEF-4733 <http://tickets.opscode.com/browse/CHEF-4733>`_  --- Directory, template providers: owner validation fails on single-character strings
* `CHEF-4734 <http://tickets.opscode.com/browse/CHEF-4734>`_  --- Stop enforcing group/owner regular expressions
* `CHEF-4747 <http://tickets.opscode.com/browse/CHEF-4747>`_  --- Allow configuring how many threads will be used for knife cookbook upload
* `CHEF-4748 <http://tickets.opscode.com/browse/CHEF-4748>`_  --- Knife data bag accepts different ID validation during "data bag item from file" and "data bag edit" vs the "data bag create"
* `CHEF-4759 <http://tickets.opscode.com/browse/CHEF-4759>`_  --- chef-solo on Windows prints out ASCII escape sequences
* `CHEF-4762 <http://tickets.opscode.com/browse/CHEF-4762>`_  --- http_request with action :head does not behave correctly in 11.8.0
* `CHEF-4782 <http://tickets.opscode.com/browse/CHEF-4782>`_  --- chef service provider action "enable" not idempodent on ubuntu/debian
* `CHEF-4806 <http://tickets.opscode.com/browse/CHEF-4806>`_  --- debian service not idempotent and ignoring S runlevel
* `CHEF-4822 <http://tickets.opscode.com/browse/CHEF-4822>`_  --- Remove unused instance variable startup_type from service resource
* `CHEF-4825 <http://tickets.opscode.com/browse/CHEF-4825>`_  --- Omnitruck and install.sh overall rollup ticket
* `CHEF-4842 <http://tickets.opscode.com/browse/CHEF-4842>`_  --- User resource comparison fails if comment includes unicode characters
* `CHEF-4845 <http://tickets.opscode.com/browse/CHEF-4845>`_  --- Invalid regexp in aix package provider
* `CHEF-4849 <http://tickets.opscode.com/browse/CHEF-4849>`_  --- Package resource should implement variables method for use with templates
* `CHEF-4850 <http://tickets.opscode.com/browse/CHEF-4850>`_  --- Chef::Util::FileEdit leaks handle
* `CHEF-4852 <http://tickets.opscode.com/browse/CHEF-4852>`_  --- Print total resources along with updated resources in doc formatter
* `CHEF-4909 <http://tickets.opscode.com/browse/CHEF-4909>`_  --- Add support for loading a static list of plugins to knife
* `CHEF-4910 <http://tickets.opscode.com/browse/CHEF-4910>`_  --- Ruby 2.1 compatibility
* `CHEF-4913 <http://tickets.opscode.com/browse/CHEF-4913>`_  --- ffi 1.3.1 is too low a version when using Ruby 2.0.0 with Windows
* `CHEF-4914 <http://tickets.opscode.com/browse/CHEF-4914>`_  --- integration tests fail when there is another chef-client first in the PATH
* `CHEF-4958 <http://tickets.opscode.com/browse/CHEF-4958>`_  --- (Refactor) Extract policy setup code from Chef::Client to a new component
* `CHEF-4963 <http://tickets.opscode.com/browse/CHEF-4963>`_  --- Mixlib-shellout library is incorrect for Chef 11.8.2
* `CHEF-4983 <http://tickets.opscode.com/browse/CHEF-4983>`_  --- Incompatibility with ChefSpec introduced by CHEF-4958
* `CHEF-4984 <http://tickets.opscode.com/browse/CHEF-4984>`_  --- Experimental Support for Policyfile-based node policy

