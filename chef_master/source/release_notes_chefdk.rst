=====================================================
Release Notes: Chef Development Kit 0.19 - 3.1
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_chefdk.rst>`__

Chef Development Kit is released on a monthly schedule with new releases the third Monday of every month. Below are the major changes for each release. For a detailed list of changes see the `Chef DK Changelog on GitHub <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md>`__

What's New in 3.1
=====================================================

* **Chef 14.2.0**
     ChefDK now ships with Chef 14.2.0. See `Chef release notes </release_notes.html#what-s-new-in-14-2-0>`__ for more information on what’s new.

* **Habitat Packages**
     ChefDK is now released as a habitat package under the identifier ``chef/chef-dk``. All successful builds are available in the unstable channel and all promoted builds are available in the stable channel. 

* **Updated Homebrew Cask Tap**
     You can install ChefDK on macOS using ``brew cask install chef/chef/chefdk``. The tap name is new, but not the behavior.

* **Updated Tooling**

  **Fauxhai**
      Fauxhai 6.4.0 brings support for 3 new platforms - CentOS 7.5, Debian 8.11, and FreeBSD 11.2. It also updates the dumps for Amazon Linux, Red Hat, SLES, and Ubuntu to match Chef 14.2 output. Finally it deprecates FreeBSD 10.3.

  **Foodcritic**
      Foodcritic 14.0.0 adds support for Chef 14.2 metadata, makes it the default, and removes old Chef 13 metadata. It also updates rules for clarity, removes an unecessary rule, and adds a new rule saying when cookbooks have unecessary dependencies now that resources moved into core Chef. See the changelog for a full list of changes.

  **knife-acl**
      ``knife-acl`` is now included with ChefDK. This knife plugin allows admin users to modify Chef Server ACLs from their command line.

  **knife-tidy**
      ``knife-tidy`` 3 is now included with ChefDK. This knife plugin generates reports about stale nodes and helps clean them up.

  **Test Kitchen**
      Test Kitchen 1.11.0 adds a new ``ssh_gateway_port`` config and fixes a bug on Unix systems where scripts are not created as executable.

* **Updated Components and Tools**

     * ``fauxhai: 6.3.0 -> 6.4.0``
     * ``foodcritic: 13.1.1 -> 14.0.0``
     * ``kitchen-digitalocean: 0.9.8 -> 0.10.0``
     * ``knife-opc: 0.3.2 -> 0.4.0``
     * ``test-kitchen: 1.21.2 ->1.22.0``

* *Security Updates**

  * **ffi**
    CVE-2018-1000201: DLL loading issue which can be hijacked on Windows OS

What's New in 3.0
=====================================================

* **Chef 14.1.1**
     ChefDK now ships with Chef 14.1.1. `Chef release notes </release_notes.html#what-s-new-in-14-1-1>`__ for more information on what’s new.

* **Updated Operating System support**
     ChefDK now ships packages for Ubuntu 18.04 and Debian 9. In accordance with Chef’s platform End Of Life policy, ChefDK is no longer shipped on macOS 10.10.

* **Enhanced cookbook archive handling**
     ChefDK now uses an embedded copy of ``libarchive`` to support Policyfile and Berkshelf. This improves overall performance and provides a well tested interface to different types of archives. It also resolves the long standing “not an octal string” problem users face when depending on certain cookbooks in the supermarket.

* **Policyfiles: updated include_policy support**
     Policyfiles now support git targets for included policies.

  .. code-block:: ruby
  
    include_policy 'base_policy',
                  git: 'https://github.com/happychef/chef-repo.git',
                  branch: master,
                  path: 'policies/base/Policyfile.lock.json'

* **Updated Tooling**

  * *Test Kitchen*
     Test Kitchen has been updated from 1.20.0 to 1.21.2. This release allows you to use a ``kitchen.yml`` config file instead of ``.kitchen.yml`` so the kitchen config will no longer be hidden in your cookbook directories. It also introduces new config options for SSH proxy servers and allows you to specify multiple paths for data bags. See the `CHANGELOG <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md>`__ for a complete list of changes.

  * **InSpec**
     InSpec has been updated from 1.51.21 to 2.1.68. InSpec 2.0 brings compliance automation to the cloud, with new resource types specifically built for AWS and Azure clouds. Along with these changes are major speed improvements and quality of life updates. Please visit ` Inspec <https://www.inspec.io>`__ for more information.

  * **ChefSpec**
     ChefSpec has been updated to 7.2.1 with Fauxhai 6.2.0. This release removes all platforms that were previously marked as deprecated in Fauxhai. If you saw Fauxhai deprecation warnings during your ChefSpec runs you will now see failures. This update also adds 9 new platforms and updates existing data for Chef 14. To see a complete list of platforms that can be mocked in ChefSpec see https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md 2.
  
  * **Foodcritic**
     Foodcritic has been updated to from 12.3.0 to 13.1.1. This updates Foodcritic for Chef 13 or later by removing Chef 12 metadata and removing several legacy rules that suggested writing resources in a Chef 12 manner. The update also adds 9 new rules for writing custom resources and updating cookbooks to Chef 13 and 14, resolves several long standing file detection bugs, and improves performance.

  * **Cookstyle**
     Cookstyle has been updated to 3.0, which updates the underlying RuboCop engine to 0.55 with a long list of bug fixes and improvements. This release of Cookstyle also enables 19 new rules available in RuboCop. See the `CHANGELOG <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md>`__ for a complete list of newly enabled rules.

  * **Berkshelf**
     Berkshelf has been updated to 7.0.2. Berkshelf 7 moves to using the same libraries as the Chef Client, ensuring consistent behavior - for instance, ensuring that ``chefignore`` files work the same - and enabling a quicker turnaround on bug fixes. The “Actor crashed” failures of celluloid will no longer be produced by Berkshelf.

  * **VMware vSphere support**
     The ``knife-vsphere`` plugin for managing VMware vSphere is now bundled with ChefDK.

  * **Cookbook generator creates a CHANGELOG.md**
     ``chef cookbook generate [cookbook_name]`` now creates a CHANGELOG.md file.

* **Updated Components and Tools**
     * ``chef-provisioning 2.7.0 -> 2.7.1``
     * ``knife-ec2 0.17.0 -> 0.18.0``
     * ``opscode-pushy-client 2.3.0 -> 2.4.11``

* **Security Updates**

  * **Ruby**
     Ruby has been updated to 2.5.1 to resolve the following vulnerabilities:

     * `CVE-2017-17742 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17742>`__
     * `CVE-2018-6914 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-6914>`__
     * `CVE-2018-8777 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-8777>`__ 
     * `CVE-2018-8778 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-8778>`__
     * `CVE-2018-8779 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-8779>`__
     * `CVE-2018-8780 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-69148780>`__
     * Multiple vulnerabilities in RubyGems

  * **OpenSSL**
     OpenSSL has been updated to 1.0.2o to resolve CVE-2018-0739.

What's New in 2.5.3
=====================================================
* **Rename smoke tests to integration tests**

  The cookbook, recipe, and app generators now name the test directory ``integration`` instead of ``smoke``. This will not impact existing cookbooks generated with older releases of ChefDK, but it does simplify the ``.kitchen.yml`` configuration for all new cookbooks.

* **Chef 13.8.5**

  Chef DK now ships with Chef 13.8.5. See the `Chef release notes </release_notes.html#what-s-new-in-13-8-5>`__ for more information.

* **Updated chef_version in cookbook generator** 

  When running ``chef generate cookbook`` the generated cookbook will now specify a minimum Chef release of 12.14 not 12.1.

* **Security Updates**
  
  * Ruby has been updated to 2.4.3 to resolve `CVE-2017-17405 <https://nvd.nist.gov/vuln/detail/CVE-2017-17405>`__
  * OpenSSL has been updated to 1.0.2n to resolve `CVE-2017-3738 <https://nvd.nist.gov/vuln/detail/CVE-2017-3738>`__, `CVE-2017-3737 <https://nvd.nist.gov/vuln/detail/CVE-2017-3737>`__, `CVE-2017-3736 <https://nvd.nist.gov/vuln/detail/CVE-2017-3736>`__, and `CVE-2017-3735 <https://nvd.nist.gov/vuln/detail/CVE-2017-3735>`__
  * LibXML2 has been updated to 2.9.7 to fix `CVE-2017-15412 <https://access.redhat.com/security/cve/cve-2017-15412>`__
  * minitar has been updated to 0.6.1 to resolve `CVE-2016-10173 <https://nvd.nist.gov/vuln/detail/CVE-2016-10173>`__

* **Updated Components**

  * chefspec 7.1.1 -> 7.1.2
  * chef-api 0.7.1 -> 0.8.0
  * chef-provisioning 2.6.0 -> 2.7.0
  * chef-provisioning-aws 3.0.0 -> 3.0.2
  * chef-sugar 3.6.0 -> 4.0.0
  * foodcritic 12.2.1 -> 12.3.0
  * inspec 1.45.13 -> 1.51.21
  * kitchen-dokken 2.6.5 -> 2.6.7
  * kitchen-ec2 1.3.2 -> 2.2.1
  * kitchen-inspec 0.20.0 -> 0.23.1
  * kitchen-vagrant 1.2.1 -> 1.3.1
  * knife-ec2 0.16.0 -> 0.17.0
  * knife-windows 1.9.0 -> 1.9.1
  * test-kitchen 1.19.2 -> 1.20.0
  * chef-provisioning-azure has been removed as it used deprecated Azure APIs


What's New in 2.4.17
=====================================================
* **Improved performance downloading cookbooks from a Chef server**

  Policyfile users who use a Chef server as a cookbook source will experience faster cookbook downloads when running ``chef install``. Chef server's API requires each file in a cookbook to be downloaded separately; ChefDK will now download the files in parallel. Additionally, HTTP keepalives are enabled to reduce connection overhead.

* **Cookbook artifact source for policyfiles**

  Policyfile users may now source cookbooks from the Chef server's cookbook artifact store. This is mainly intended to support the upcoming ``include_policy`` feature, but could be useful in some situations.

  Given a cookbook that has been uploaded to the Chef server via ``chef push``, it can be used in another policy by adding code like the following to the ruby policyfile:

  .. code-block:: ruby

    cookbook "runit",
      chef_server_artifact: "https://chef.example/organizations/myorg",
      identifier: "09d43fad354b3efcc5b5836fef5137131f60f974"


* **Added include_policy directive**

  Policyfile can use the ``include_policy`` directive as described in `RFC097 <https://github.com/chef/chef-rfc/blob/master/rfc097-policyfile-includes.md>`__. This directive's purpose is to allow the inclusion policyfile locks to the current policyfile. In this iteration, we support sourcing lock files from a local path or a Chef server. Below is a simple example of how the ``include_policy`` directive can be used:

  Given a policyfile ``base.rb``:

  .. code-block:: ruby

     name 'base'

     default_source :supermarket

     run_list 'motd'

     cookbook 'motd', '~> 0.6.0'


  Run:

  .. code-block:: none

      >> chef install ./base.rb

      Building policy base
      Expanded run list: recipe[motd]
      Caching Cookbooks...
      Using      motd         0.6.4
      Using      chef_handler 3.0.2

      Lockfile written to /home/jaym/workspace/chef-dk/base.lock.json
      Policy revision id: 1238e7a353ec07a4df6636cdffd8805220a00789bace96d6d70268a4b0064023

  This will produce the ``base.lock.json`` file that will be included in our next policy, ``users.rb``:

  .. code-block:: ruby

      name 'users'

      default_source :supermarket

      run_list 'user'

      cookbook 'user', '~> 0.7.0'

      include_policy 'base', path: './base.lock.json'


  Run:

  .. code-block:: none

      >> chef install ./users.rb

      Building policy users
      Expanded run list: recipe[motd::default], recipe[user]
      Caching Cookbooks...
      Using      motd         0.6.4
      Installing user         0.7.0
      Using      chef_handler 3.0.2

      Lockfile written to /home/jaym/workspace/chef-dk/users.lock.json
      Policy revision id: 20fac68f987152f62a2761e1cfc7f1dc29b598303bfb2d84a115557e2a4a8f27


  This will produce a ``users.lock.json`` file that has the ``base`` policyfile lock merged in.

  More information can be found in `RFC097 <https://github.com/chef/chef-rfc/blob/master/rfc097-policyfile-includes.md>`__ and the `Policyfile documentation </policyfile.html>`__.

* **New tools bundled**

  We are now shipping these tools as part of Chef DK:

    * `kitchen-digitalocean <https://github.com/test-kitchen/kitchen-digitalocean>`__
    * `kitchen-google <https://github.com/test-kitchen/kitchen-google>`__
    * `knife-ec2 <https://github.com/chef/knife-ec2>`__
    * `knife-google <https://github.com/chef/knife-google>`__

See the detailed `change log <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md#v2417-2017-11-29>`__ for additional information.

What's New in 2.3.4
=====================================================
ChefDK 2.3.4 pins the net-ssh gem to version 4.1 to prevent errors in test-kitchen and kitchen-inspec that would prevent systems from properly converging or verifying. This release is recommended for all users of ChefDK 2.3.

What's New in 2.3.3
=====================================================
This release restores macOS support in ChefDK 2.3. See the `change log <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md#v233-2017-09-21>`__ for more information.

What's New in 2.3.1
=====================================================
This release includes Ruby 2.4.2 to fix the following CVEs:

* `CVE-2017-0898 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-0898>`_
* `CVE-2017-10784 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-10784>`_
*  CVE-2017-14033
* `CVE-2017-14064 <https://nvd.nist.gov/vuln/detail/CVE-2017-14064>`__

ChefDK 2.3 includes:

* Chef 13.4.19
* InSpec 1.36.1
* Berkshelf 6.3.1
* Chef Vault 3.3.0
* Foodcritic 11.4.0
* Test Kitchen 1.17.0
* Stove 6.0

Additionally, the cookbook generator now adds a ``LICENSE`` file when creating a new cookbook.

See the detailed `change log <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md#v231-2017-09-14>`__ for a complete list of changes.

.. note:: Due to issues beyond our control, this release is only built for Linux (x86_64) and Windows. We’ll release a new build with macOS support as soon as possible.

What's New in 2.2.1
=====================================================
This release includes RubyGems 2.6.13 to address the following CVEs:

* `CVE-2017-0899 <https://nvd.nist.gov/vuln/detail/CVE-2017-0899>`_
* `CVE-2017-0900 <https://nvd.nist.gov/vuln/detail/CVE-2017-0900>`_
* `CVE-2017-0901 <https://nvd.nist.gov/vuln/detail/CVE-2017-0901>`_
* `CVE-2017-0902 <https://nvd.nist.gov/vuln/detail/CVE-2017-0902>`__

ChefDK 2.2.1 includes:

* Chef 13.3.42
* InSpec 1.35.1
* Berkshelf 6.3.1
* Chef Vault 3.3.0
* Foodcritic 11.3.1
* Test Kitchen 1.17.0


What's New in 2.1.11
=====================================================
This release updates the version of git shipped in Chef DK to 2.14.1 to address `CVE-2017-1000117 <https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2017-1000117>`__.

Notable Updated Gems
-----------------------------------------------------
* berkshelf 6.2.0 -> 6.3.0
* chef-provisioning 2.4.0 -> 2.5.0
* chef-zero 13.0.0 -> 13.1.0
* fauxhai 5.2.0 -> 5.3.0
* fog 1.40 -> 1.41
* inspec 1.31.1 -> 1.33.1
* kitchen-dokken 2.5.1 -> 2.6.1
* kitchen-vagrant 1.1.0 -> 1.2.0
* knife-push 1.0.2 -> 1.0.3
* ohai 13.2.0 -> 13.3.0
* serverspec 2.39.1 -> 2.40.0
* test-kitchen 1.16 -> 1.17

See the detailed `change log <https://github.com/chef/chef-dk/blob/master/CHANGELOG.md#v2111-2017-08-11>`__ for a full list of changes.

What's New in 2.0.28
=====================================================
Chef 2.0.28 fixes an `issue <https://github.com/chef/chef-dk/issues/1322>`__ in Chef DK 2.0 where ``chef push`` would upload incomplete cookbooks.

What's New in 2.0
=====================================================

Chef Client 13.2
-----------------------------------------------------
Chef Client 13 is the most delightful version of Chef Client available. We've taken what we've learned from many bug reports, forum posts, and conversations with our users, and we've made it safer and easier than ever to write great cookbooks. We've also included a number of new resources that better support our most popular operating systems, and we've made it easier to write patterns that result in reusable, efficient code.

Chef Client 13.2 solves a number of issues that were reported in our initial releases of Chef Client 13, and we regard it as suitable for general use.

PolicyFiles
-----------------------------------------------------
It's now possible to update a single cookbook using ``chef update <cookbook>``. Artifactory is now supported as a cookbook source.

Cookbook Generator
-----------------------------------------------------
Adds ``chef generate helpers <HELPERS_NAME>`` to generate a helpers file in libraries.

Berkshelf 6.2.0
-----------------------------------------------------
Berkshelf adds support for two new sources:

* Artifactory: source artifactory: 'https://myserver/api/chef/chef-virtual'
* Chef Repo: source chef_repo: '.'

Chef Vault 3.1
-----------------------------------------------------
Chef Vault 3.1 includes a number of optimizations for large numbers of nodes. In most situations, we've seen at least 50% faster creation, update, and refresh operations, and much more efficient memory usage. We've also added a new ``sparse`` mode, which dramatically reduces the amount of network traffic that occurs as nodes decrypt vaults. A lot of the scalability work has been built and tested by our friends at Criteo.

Chef Vault 3.1 also makes it much easier to use provisioning nodes to manage vaults by using the ``public_key_read_access`` group, which is available in Chef server 12.5 and above.

Foodcritic 11
-----------------------------------------------------
Foodcritic 11 covers many of the patterns that were removed in Chef Client 13, so you'll get up-front notification that your cookbooks will no longer work with this release. In general, the patterns that were removed enabled dangerous ways of writing cookbooks. Ensuring that you're compliant with Foodcritic 11 means your cookbooks are safer with every version of Chef.

The release of Foodcritic 11 also marks the creation of the Foodcritic org on `GitHub <https://github.com/foodcritic>`__, which makes it easier to get involved in writing rules and contributing code. We are excited to start building more of a community around Foodcritic, and can’t wait to see what the community cooks up.

InSpec 1.30
-----------------------------------------------------
Since the last release of ChefDK, InSpec has been independently released multiple times with a number of great enhancements, including some new resources (rabbitmq_config, docker, docker_image, docker_container, oracledb_session), some enhancements to the Habitat package creator for InSpec profiles, and a whole slew of bug fixes and documentation updates.

ChefSpec 7.1.0
-----------------------------------------------------
It's no longer necessary to create custom matchers; ChefSpec will automatically create matchers for any resources in the cookbooks under test.

Cookstyle 2.0
-----------------------------------------------------
Cookstyle 2.0 is based on Rubocop 0.49.1, which changed a large number of rule names.


What's New in 1.6.11
=====================================================
This release contains only dependency updates, including several security fixes:

* Ruby has been upgraded to 2.3.5 to address the following CVEs:

  * `CVE-2017-0898 <https://www.ruby-lang.org/en/news/2017/09/14/sprintf-buffer-underrun-cve-2017-0898/>`__
  * `CVE-2017-10784 <https://www.ruby-lang.org/en/news/2017/09/14/webrick-basic-auth-escape-sequence-injection-cve-2017-10784/>`__
  * `CVE-2017-14033 <https://www.ruby-lang.org/en/news/2017/09/14/openssl-asn1-buffer-underrun-cve-2017-14033/>`__
  * `CVE-2017-14064 <https://www.ruby-lang.org/en/news/2017/09/14/json-heap-exposure-cve-2017-14064/>`__

* Chef Client has been upgraded to 12.21.26
* Push Jobs Client has been upgraded to 2.4.5

What's New in 1.5
=====================================================

Chef Client 12.21
-----------------------------------------------------

Chef has been updated to the 12.21 release, fixing a number of bugs:

* Debian-based systems will now correctly prefer Systemd to Upstart
* Better handling of the ``supports`` pseudo-property
* Fixes crashes that occurred when downgrading from Chef 13 to Chef 12
* Provides better system information when Chef crashes

See the full `release notes <https://github.com/chef/chef/blob/chef-12/RELEASE_NOTES.md#chef-client-release-notes-1221>`__ for more details.

Chef Client 12.21 also contains a new version of zlib, fixing 4 CVEs:

* `CVE-2016-98402 <https://www.cvedetails.com/cve/CVE-2016-9840/>`__
* `CVE-2016-9841 <https://www.cvedetails.com/cve/CVE-2016-9841/>`__
* `CVE-2016-9842 <https://www.cvedetails.com/cve/CVE-2016-9842/>`__
* `CVE-2016-9843 <https://www.cvedetails.com/cve/CVE-2016-9843/>`__

Notable Updated Gems
-----------------------------------------------------
- cookstyle 1.3.1 -> 1.4.0

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

- Better filter support for the `processes resource <https://inspec.io/docs/reference/resources/processes/>`_.
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

InSpec
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
* Deprecation of GitHub V1 backed project initialization.
* Initialization of GitHub V2 backed projects (``delivery init --github``). Requires Chef Automate server version ``0.5.432`` or above.
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
