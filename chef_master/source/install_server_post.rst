=====================================================
Post-Config Options
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_server_post.rst>`__

The following sections describe configuration steps that should be done after the Chef server is installed.

Active Directory and LDAP
=====================================================
.. tag install_server_ldap

The Chef server supports using Active Directory or LDAP for any user that has an email address in the LDAP directory. This allows those users to log in to the Chef server by using their corporate credentials instead of having a separate username and password.

.. warning:: The following attributes **MUST** be in the user LDAP record:

   - ``mail:``
   - ``sAMAccountName:`` or ``uid:``

   The following attributes **SHOULD** be in the user LDAP record:

   - ``displayname:``
   - ``givenname:``
   - ``sn:``
   - ``c:``
   - ``l:``

To configure the Chef server to use Active Directory or LDAP do the following:

#. Install the Chef management console (if it is not already).
#. Add the following settings to the chef-server.rb file. These settings must be added to the chef-server.rb file on each machine in the Chef server frontend deployment of a High Availability installation as well as on Chef servers in a standalone installation.

   .. tag config_rb_server_settings_ldap

   This configuration file has the following settings for ``ldap``:

   ``ldap['base_dn']``
      The root LDAP node under which all other nodes exist in the directory structure. For Active Directory, this is typically ``cn=users`` and then the domain. For example:

      .. code-block:: ruby

         'OU=Employees,OU=Domain users,DC=example,DC=com'

      Default value: ``nil``.

   ``ldap['bind_dn']``
      The distinguished name used to bind to the LDAP server. The user the Chef server will use to perform LDAP searches. This is often the administrator or manager user. This user needs to have read access to all LDAP users that require authentication. The Chef server must do an LDAP search before any user can log in. Many Active Directory and LDAP systems do not allow an anonymous bind. If anonymous bind is allowed, leave the ``bind_dn`` and ``bind_password`` settings blank. If anonymous bind is not allowed, a user with ``READ`` access to the directory is required. This user must be specified as an LDAP distinguished name similar to:

      .. code-block:: ruby

         'CN=user,OU=Employees,OU=Domainuser,DC=example,DC=com'

      Default value: ``nil``.

   ``ldap['bind_password']``
      Legacy configuration for the password of the binding user. The password for the user specified by ``ldap['bind_dn']``. Leave this value and ``ldap['bind_dn']`` unset if anonymous bind is sufficient. Default value: ``nil``. As of Chef server 12.14, this is no longer the preferred command.

      Please use ``chef-server-ctl set-secret ldap bind_password`` from the :ref:`ctl_chef_server_secrets_management` commands.

      .. code-block:: bash

         $ chef-server-ctl set-secret ldap bind_password
         Enter ldap bind_password:    (no terminal output)
         Re-enter ldap bind_password: (no terminal output)

      Remove a set password via

      .. code-block:: bash

         $ chef-server-ctl remove-secret ldap bind_password

   ``ldap['group_dn']``
      The distinguished name for a group. When set to the distinguished name of a group, only members of that group can log in. This feature filters based on the ``memberOf`` attribute and only works with LDAP servers that provide such an attribute. In OpenLDAP, the ``memberOf`` overlay provides this attribute. For example, if the value of the ``memberOf`` attribute is ``CN=abcxyz,OU=users,DC=company,DC=com``, then use:

      .. code-block:: ruby

         ldap['group_dn'] = 'CN=user,OU=Employees,DC=example,DC=com'

   ``ldap['host']``
      The name (or IP address) of the LDAP server. The hostname of the LDAP or Active Directory server. Be sure the Chef server is able to resolve any host names. Default value: ``ldap-server-host``.

   ``ldap['login_attribute']``
      The LDAP attribute that holds the user's login name. Use to specify the Chef server user name for an LDAP user. Default value: ``sAMAccountName``.

   ``ldap['port']``
      An integer that specifies the port on which the LDAP server listens. The default value is an appropriate value for most configurations. Default value: ``389`` or ``636`` when ``ldap['encryption']`` is set to ``:simple_tls``.

   ``ldap['ssl_enabled']``
      Cause the Chef server to connect to the LDAP server using SSL. Default value: ``false``. Must be ``false`` when ``ldap['tls_enabled']`` is ``true``.

      .. note:: Previous versions of the Chef server used the ``ldap['ssl_enabled']`` setting to first enable SSL, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

   ``ldap['system_adjective']``
      A descriptive name for the login system that is displayed to users in the Chef server management console. If a value like "corporate" is used, then the Chef management console user interface will display strings like "the corporate login server", "corporate login", or "corporate password." Default value: ``AD/LDAP``.

      .. warning:: This setting is **not** used by the Chef server. It is used only by the Chef management console.

   ``ldap['timeout']``
      The amount of time (in seconds) to wait before timing out. Default value: ``60000``.

   ``ldap['tls_enabled']``
      Enable TLS. When enabled, communication with the LDAP server is done via a secure SSL connection on a dedicated port. When ``true``, ``ldap['port']`` is also set to ``636``. Default value: ``false``. Must be ``false`` when ``ldap['ssl_enabled']`` is ``true``.

      .. note:: Previous versions of the Chef server used the ``ldap['ssl_enabled']`` setting to first enable SSL, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.

   .. end_tag

   .. note:: If the chef-server.rb file does not exist, create a file called ``chef-server.rb`` and put it in the ``/etc/opscode/`` directory.

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure
      $ sudo chef-manage-ctl reconfigure

   .. end_tag

At this point, all users should be able to use their Active Directory or LDAP usernames and passwords to log in to the Chef server.

.. end_tag

Test LDAP Connectivity
=====================================================
.. tag server_ldap_test

Use ``ldapsearch`` to test the ability of the Chef server to use Active Directory or LDAP. First, translate the Chef server LDAP settings into ``ldapsearch`` parameters:

.. list-table::
   :widths: 200 200
   :header-rows: 1

   * - Chef Server Setting
     - ``ldapsearch`` Parameter
   * - ``ldap['host']`` and ``ldap['port']``
     - ``-H [HOST:PORT]``
   * - ``ldap['bind_dn']``
     - ``-D [BIND_DN]``
   * - ``ldap['bind_password']``
     - ``-W``; ``ldapsearch`` will prompt for this parameter
   * - ``ldap['base_dn']``
     - ``-b [BASE_DN]``
   * - ``ldap['login_attribute']``
     - Defaults to ``SAMAccountName``

And then from a front end machine (in a high availability or tiered configuration) or from the Chef server in a standalone configuration, run the following command. Be sure to replace the uppercase placeholders with the values for your organization:

.. code-block:: bash

   $ ldapsearch -LLL -H ldap://HOST:PORT -b 'BASE_DN' -D 'BIND_DN' -W '(LOGIN_ATTRIBUTE=YOUR_LDAP_ACCOUNT_USERNAME)'

For example:

.. code-block:: bash

   $ ldapsearch -LLL -H ldap://win-ad1.chef.co:389 -b 'OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -D 'CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -W '(sAMAccountName=rforster)'

Output similar to the following is returned:

.. code-block:: bash

   $ ldapsearch -LLL -H ldap://win-ad1.chef.co:389 -b 'OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -D 'CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com' -W '(sAMAccountName=rforster)'
   Enter LDAP Password:

   dn: CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC=com
   objectClass: top
   objectClass: person
   objectClass: organizationalPerson
   objectClass: user
   cn: Robert Forster
   sn: Forster
   c: 0
   givenName: Robert
   distinguishedName: CN=Robert Forster,OU=Employees,OU=Domain users,DC=opscodecorp,DC
    =com

.. note:: The ``ldapsearch`` command may need to be installed on the platform. It is not included as part of the Chef server package.

.. end_tag

GRE Tunnels
=====================================================
.. tag install_server_ha_drbd_gre_tunnels

.. warning:: This option is sometimes necessary when the Chef server is configured for high availability using DRBD.

Occasionally, a GRE tunnel will be required to handle the VRRP traffic. To accomplish this, set the following in ``/var/opt/opscode/keepalived/bin/tunnel.sh`` on the back-end server that will be used for bootstrapping:

.. code-block:: bash

   #!/bin/sh
   ip tunnel add pc mode gre remote VRRP_IP_OF_PEER local MY_IP ttl 25
   ip link set pc up
   ip addr add 172.18.16.1 dev pc
   ip route add 172.18.16.0/24 dev pc

Replace ``VRRP_IP_OF_PEER`` with the IP address of the server on the other end of the tunnel, and ``MY_IP`` with the IP address of the server on which the script will be located.

The ``172.17.16.**`` network addresses used in the previous examples could be any unused reserved IP address space.

Set the following in ``/etc/opscode/chef-server.rb``:

.. code-block:: ruby

   backend_vip "192.168.141.108",
     :ipaddress => "192.168.141.108",
     :device => "eth0"

And set the Keepalived unicast addresses to the GRE tunnel addresses.

.. end_tag
