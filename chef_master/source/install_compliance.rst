=====================================================
Install |chef compliance| Server
=====================================================

To install the |chef compliance| server in a standalone on-premises configuration, first review the prerequisites and then follow the steps below. |chef compliance| may also be installed as an |amazon ami| from the |amazon aws marketplace|.

Prerequisites
=====================================================
The |chef compliance| server has the following prerequisites:

* An x86_64 compatible system architecture; |redhat enterprise linux| and |centos| may require updates prior to installation
* A resolvable hostname that is specified using a |fqdn| or an IP address
* A connection to |ntp| to prevent clock drift
* Optional. A local user account under which services will run, a local user account for |postgresql|, and a group account under which services will run. See https://docs.chef.io/install_server_pre.html#uids-and-gids for more information

The following prerequisites apply to every installation of the |chef compliance| server.

Supported Platforms
-----------------------------------------------------
.. include:: ../../includes_supported_platforms/includes_supported_platforms_compliance.rst

Unsupported
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_supported_platforms/includes_supported_platforms_compliance_not_supported.rst

Standalone
=====================================================
.. include:: ../../includes_install/includes_install_compliance_standalone.rst

|amazon aws marketplace|
=====================================================
You can install the |chef compliance| server as an |amazon ami| instance.

Launch the AMI
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_launch_ami.rst

Configure the Server
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_configure.rst

Ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_ports.rst

Hostname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_update_hostname.rst

Edit AMI Instance Size
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_change_instance.rst

Migrate to a new AMI version
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_migrate_ami.rst

Configure SSL
=====================================================
.. include:: ../../includes_compliance/includes_compliance_server_security_ssl_protocol.rst

Logging
=====================================================
.. include:: ../../includes_compliance/includes_compliance_logging.rst

Troubleshooting
=====================================================
The following section describes troubleshooting tips for |chef compliance| installations.

Setup Button Does Not Work
-----------------------------------------------------
.. include:: ../../includes_error_messages/includes_error_messages_compliance_setup.rst
