=====================================================
An Overview of Compliance
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/compliance.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

Chef Compliance allows you to assess your infrastructure's adherence to compliance requirements and to monitor that infrastructure on an ongoing basis. It includes:

* The Chef Compliance server
* Prebuilt compliance profiles to help you get started quickly
* A language for writing audit controls, which includes audit resources that you can invoke

The Chef Compliance Server
=====================================================
The Chef Compliance server is a centralized location from which all aspects of the state or your infrastructure's compliance can be managed.

* Create and manage profiles of rules; use them to test any node in your infrastructure, including all of the common UNIX and Linux platforms and most versions of Microsoft Windows
* Continuously test any node against the goals of your organization's security management lifecycle
* Each scan is fully executed remotely; there is nothing to clean up when the scan is complete because nothing was installed on the node
* Reports show the results of compliance runs and help to ensure the nodes in your infrastructure meet your security requirements
* View compliance statistics for any node

.. image:: ../../images/compliance_components.svg
   :width: 600px
   :align: center

.. note:: To install the Chef Compliance server in a standalone configuration, `read this topic <https://docs.chef.io/install_compliance.html>`__.

Compliance Profiles
-----------------------------------------------------
Compliance profiles exist for many scenarios, such as those created by the Center for Internet Security (CIS), a non-profit organization that is focused on enhancing the cyber security readiness and response of public and private sector entities.

Chef Compliance maintains profiles as a collection of individual controls that comprise a complete audit. For example, CIS benchmark 8.1.1.1 recommends testing for the maximum size of the audit log. The following example shows a control that can test for this benchmark:

.. code-block:: ruby

   control 'cis-network-8.1.1.1' do
     impact 0.2
     title '8.1.1.1 Configure Audit Log Storage Size'
	 desc '
       Determine the maximum size of the audit log file.
     '
     describe auditd_conf do
       its('max_log_file') { should_not eq nil }
     end
   end

Compliance profiles are built and maintained from the Chef Compliance server web UI. Chef Compliance ships with the following profiles:

* Basic Apache 2
* Basic Linux
* Basic MySQL
* Basic PostgreSQL
* Basic SSH
* Windows Base Security
* CIS Ubuntu 14.04 LTS Server Benchmark Level 1
* CIS Ubuntu 14.04 LTS Server Benchmark Level 2

The results of running a profile against any number of nodes in your infrastructure is available as a report summary.

.. image:: ../../images/compliance_report.png
   :width: 600px
   :align: center

Integrate w/Chef Server
-----------------------------------------------------
.. tag compliance_integrate_chef_server

Integrate Chef Compliance with the Chef server to allow:

* Users of Chef Compliance to log in using their Chef server credentials
* Nodes under management by Chef to download Chef Compliance profiles, run them on nodes, and then send the results back to Chef Compliance

.. end_tag

.. note:: To learn more about how to integrate Chef Compliance with the Chef server, `read this topic <https://docs.chef.io/integrate_compliance_chef_server.html>`__.

InSpec
=====================================================
.. tag inspec_summary

InSpec is an open-source run-time framework and rule language used to specify compliance, security, and policy requirements for testing any node in your infrastructure.

* The project name refers to "infrastructure specification"
* InSpec includes a collection of resources to help you write auditing rules quickly and easily using the Compliance DSL
* Use InSpec to examine any node in your infrastructure; run the tests locally or remotely
* Any detected security, compliance, or policy issues are flagged in a log
* The InSpec audit resource framework is fully compatible with Chef Compliance

To learn more about InSpec, see the `InSpec website <http://inspec.io/>`__. The site contains tutorials and reference documentation on how to use the various audit resources, profiles, InSpec CLI, and more.

.. end_tag

Examples
-----------------------------------------------------
The following examples show how to use the Compliance DSL to build tests.

**Only accept requests on secure ports**

This code uses the ``port`` resource to ensure that a web server is only listening on well-secured ports.

.. To only accept requests on secure ports:

.. code-block:: ruby

   describe port(80) do
     it { should_not be_listening }
   end

   describe port(443) do
     it { should be_listening }
     its('protocols') {should eq ['tcp']}
   end

**Use approved strong ciphers**

This code uses the ``sshd_config`` resource to ensure that only enterprise-compliant ciphers are used for SSH servers.

.. To use approved strong ciphers:

.. code-block:: ruby

   describe sshd_config do
     its('Ciphers') { should cmp('chacha20-poly1305@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr') }
   end

**Test a kitchen.yml file driver**

This code uses the ``yaml`` resource to ensure that the Kitchen driver is Vagrant.

.. To test a kitchen.yml file driver:

.. code-block:: ruby

   describe yaml('.kitchen.yaml') do
     its('driver.name') { should eq('vagrant') }
   end

More information
-----------------------------------------------------
This is a list of great videos and materials, that provide more information on Chef Compliance:

* Chef Compliance workshop led by Nathen Harvey: https://speakerdeck.com/nathenharvey/chef-compliance-workshop
* Webinar on Chef Compliance and Security at Velocity: https://www.chef.io/blog/event/webinar-chef-compliance-security-at-velocity/
