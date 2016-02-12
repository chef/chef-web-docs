.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-a ATTRIBUTE``, ``--server-connect-attribute ATTRIBUTE``
   |attribute ssh| This should be an |amazon ec2| server attribute. This option is especially useful when creating instances in a VPC and will allow the bootstrapping ssh client to connect to the VPC after an EIP is attached.

``-A KEY``, ``--aws-access-key-id KEY``
   |aws_access_key_id|

``--associate-eip IP_ADDRESS``
   |ip_address elastic|

``--associate-public-ip``
   |use public_ip_address|

``--aws-credential-file FILE``
   |credential_file amazon|

``--bootstrap-protocol PROTOCOL``
   |bootstrap protocol| Possible values: ``ssh`` and ``winrm``.

``--bootstrap-proxy PROXY_URL``
   |bootstrap proxy|

``--bootstrap-version VERSION``
   |bootstrap version|

``--dedicated_instance``
   |aws_dedicated_instance|

``-d DISTRO``, ``--distro DISTRO``
   |distro|

``--ebs-no-delete-on-term``
   |ebs_no_delete_on_term|

``--ebs-optimized``
   |ebs_optimized|

``--ebs-size SIZE``
   |ebs_size|

``--ebs-volume-type TYPE``
   |ebs_volume_type| Possible values: ``standard`` or ``io1``.

``--ephemeral DEVICE``
   |ephemeral device|

``-f FLAVOR``, ``--flavor FLAVOR``
   |flavor|

``--fqdn FQDN``
   |name fqdn| This value should be pre-defined.

``-g X,Y,Z``, ``--security-group-ids X,Y,Z``
   |group ids| Required when using |amazon vpc|.

``-G X,Y,Z``, ``--groups X,Y,Z``
   |groups| Not supported when using |amazon vpc|.

``--hint HINT_NAME[=HINT_FILE]``
   |hint|

   .. include:: ../../includes_ohai/includes_ohai_hints.rst

   |hint_file| |hint_name| |hint_multiple|

``-I IMAGE``, ``--image IMAGE``
   |image|

``--iam-profile NAME``
   |name iam_profile|

``-j JSON_ATTRIBS``, ``--json-attributes JSON_ATTRIBS``
   |json first_run_string|

``-K SECRET``, ``--aws-secret-access-key SECRET``
   |aws_access_key_secret|

``-N NAME``, ``--node-name NAME``
   |name node|

``--placement-group PLACEMENT_GROUP``
   |name placement_group|

``--prerelease``
   |prerelease|

``--private-ip-address IP-ADDRESS``
   |ip_address amazon_vpc|

``--provisioned-iops IOPS``
   |ebs_volume_type provisioned_iops|

``-r RUN_LIST``, ``--run-list RUN_LIST``
   |run-list|

``--region REGION``
   |region amazon|

``-s SECRET``, ``--secret SECRET``
   |secret|

``-S KEY``, ``--ssh-key KEY``
   |ssh_key amazon_ec2|

``--s3-secret URL``
   |url secret_amazon_s3|

``--secret-file FILE``
   |secret_file|

``--ssh-gateway-identity IDENTITY_FILE``
   |ssh_gateway_identity|

``--subnet SUBNET_ID``
   |subnet|

``--T Tag=Value[,Tag=Value]``, ``--tags Tag=Value[,Tag=Value]``
   |tags|

``--template-file TEMPLATE``
   |path bootstrap_template|

``-u USER_DATA_FILE``, ``--user-data USER_DATA_FILE``
   |user data_file_ec2|

``--use-iam-profile``
   |use iam_profile|

``--validation-key-url URL``
   |url key_validation|

``-w GATEWAY``, ``--ssh-gateway GATEWAY``
   |ssh_gateway|

``--windows-auth-timeout MINUTES``
   |timeout auth_windows| Default: ``25``.

``-Z ZONE``, ``--availability-zone ZONE``
   |availability_zone| Default: ``us-east-1b``.

The following settings may be used when ``--bootstrap-protocol`` is set to ``ssh``:

``--[no-]host-key-verify``
   |no_host_key_verify| Default setting: ``--host-key-verify``.
   
``-i IDENTITY_FILE``, ``--identity-file IDENTITY_FILE``
   |identity-file|

``-p PORT``, ``--ssh-port PORT``
   |ssh_port|

``-P PASSWORD``, ``--ssh-password PASSWORD``
   |ssh_password|

``-x USERNAME``, ``--ssh-user USERNAME``
   |ssh_user|

The following settings may be used when ``--bootstrap-protocol`` is set to ``winrm``:

``-i KEYTAB_FILE``, ``--keytab-file KEYTAB_FILE``
   |keytab-file|

``-p PORT``, ``--winrm-port PORT``
   |winrm_port| Default: ``5985``.

``-P PASSWORD``, ``--winrm-password PASSWORD``
   |winrm_password|

``-R KERBEROS_REALM``, ``--kerberos-realm KERBEROS_REALM``
   |kerberos-realm|

``-S KERBEROS_SERVICE``, ``--kerberos-service KERBEROS_SERVICE``
   |kerberos-service| 

``-t TRANSPORT``, ``--winrm-transport TRANSPORT``
   |winrm_transport|

``-x USERNAME``, ``--winrm-user USERNAME``
   |winrm_user|

