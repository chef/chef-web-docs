

=====================================================
Install Enterprise Chef
=====================================================

.. tag chef_server

The Chef server acts as a hub for configuration data. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client. Nodes use the chef-client to ask the Chef server for configuration details, such as recipes, templates, and file distributions. The chef-client then does as much of the configuration work as possible on the nodes themselves (and not on the Chef server). This scalable approach distributes the configuration effort throughout the organization.

.. end_tag

The steps below describe the process for installing Enterprise Chef.

Steps
=====================================================
To install Enterprise Chef on-premises, do the following:

#. Go to http://downloads.chef.io/enterprise-chef/.
#. Choose your platform.
#. Download the package.
#. Review the :doc:`prerequisites <install_server_pre>`.
#. Choose a topology---:doc:`standalone <install_server_standalone>`, :doc:`scaled back end <install_server_be>`, and :doc:`scaled front end <install_server_fe>`---and then follow the steps for that scenario.

About the Hostname
=====================================================
.. tag install_common_hostname

The hostname for the Chef server may be specified using a FQDN or an IP address. This hostname must be resolvable. For example, a Chef server running in a production environment with a resolvable FQDN hostname can be added the DNS system. But when deploying Chef server into a testing environment, adding the hostname to the ``/etc/hosts`` file is enough to ensure that hostname is resolvable.

* **FQDN Hostnames** When the hostname for the Chef server is a FQDN be sure to include the domain suffix. For example, something like ``mychefserver.example.com`` (and not something like ``mychefserver``).
* **IP Address Hostnames** When the Chef server is run in IPv6 mode, a hostname specified using an IP address must also be bracketed (``[ ]``) or the Chef server will not be able to recognize it as an IPv6 address. For example:

   .. code-block:: ruby

      bookshelf['url'] "https://[2001:db8:85a3:8d3:1319:8a2e:370:7348]"

The ``api_fqdn`` setting can be added to the private-chef.rb file (it is not there by default). When added, its value should be equal to the FQDN or IP address for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing the Chef server. For example: ``api_fqdn "chef.example.com"`` or ``api_fqdn 123.45.67.890``.

.. end_tag

.. warning:: The FQDN for the Enterprise Chef server should not exceed 64 characters when using OpenSSL. OpenSSL requires the ``CN`` in a certificate to be no longer than 64 characters. By default, Enterprise Chef uses the FQDN of the server to determine the common name (``CN``). If the FQDN of the Enterprise Chef server is longer than 64 characters, the ``private-chef-ctl reconfigure`` command will not fail, but an empty certificate file will be created. Nginx will not start if a certificate file is empty.

**To verify if a hostname is a FQDN**

.. tag install_common_hostname_is_fqdn

To verify if a hostname is a FQDN, run the following command:

.. code-block:: bash

   $ hostname

If the hostname is a FQDN, it will return something like:

.. code-block:: bash

   $ mychefserver.example.com

If the hostname is not a FQDN, it must be configured so that it is one.

.. end_tag

**To verify is a hostname is resolvable**

.. tag install_common_hostname_is_resolvable

To verify is a hostname is resolvable, run the following command:

.. code-block:: bash

   $ hostname -f

If the hostname is resolvable, it will return something like:

.. code-block:: bash

   $ mychefserver.example.com

.. end_tag

**To change a hostname**

.. tag install_common_hostname_edit

In some cases, the hostname for the Chef server needs to be updated. The process for updating a hostname varies, depending on the platform on which the Chef server will run. Refer to the manual for the platform or contact a local systems administrator for specific guidance for a specific platform. The following example shows how a hostname can be changed when running Red Hat or CentOS:

.. code-block:: bash

   $ sudo hostname 'mychefserver.example.com'

and then:

.. code-block:: bash

   $ echo "mychefserver.example.com" | sudo tee /etc/hostname

.. end_tag

**To add a hostname to /etc/hosts**

.. tag install_common_hostname_add_to_etc_hosts

If a hostname is not resolvable, refer to a local systems administrator for specific guidance on how to add the hostname to the DNS system. If the Chef server is being into a testing environment, just add the hostname to ``/etc/hosts``. The following example shows how a hostname can be added to ``/etc/hosts`` when running Red Hat or CentOS:

.. code-block:: bash

   $ echo -e "127.0.0.2 `hostname` `hostname -s`" | sudo tee -a /etc/hosts

.. end_tag

