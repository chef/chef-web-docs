.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how the |chef server| sets up and configures |ssl| certificates for |nginx|. The cipher suite used by |nginx| `is configurable <https://docs.chef.io/config_rb_server.html#ssl-protocols>`_ using the ``ssl_protocols`` and ``ssl_ciphers`` settings.

.. code-block:: ruby

   ssl_keyfile = File.join(nginx_ca_dir, "#{node['private_chef']['nginx']['server_name']}.key")
   ssl_crtfile = File.join(nginx_ca_dir, "#{node['private_chef']['nginx']['server_name']}.crt")
   ssl_signing_conf = File.join(nginx_ca_dir, "#{node['private_chef']['nginx']['server_name']}-ssl.conf")
   
   unless File.exists?(ssl_keyfile) && File.exists?(ssl_crtfile) && File.exists?(ssl_signing_conf)
     file ssl_keyfile do
       owner 'root'
       group 'root'
       mode '0755'
       content '/opt/opscode/embedded/bin/openssl genrsa 2048'
       not_if { File.exist?(ssl_keyfile) }
     end
   
     file ssl_signing_conf do
       owner 'root'
       group 'root'
       mode '0755'
       not_if { File.exist?(ssl_signing_conf) }
       content <<-EOH
     [ req ]
     distinguished_name = req_distinguished_name
     prompt = no
     [ req_distinguished_name ]
     C                      = #{node['private_chef']['nginx']['ssl_country_name']}
     ST                     = #{node['private_chef']['nginx']['ssl_state_name']}
     L                      = #{node['private_chef']['nginx']['ssl_locality_name']}
     O                      = #{node['private_chef']['nginx']['ssl_company_name']}
     OU                     = #{node['private_chef']['nginx']['ssl_organizational_unit_name']}
     CN                     = #{node['private_chef']['nginx']['server_name']}
     emailAddress           = #{node['private_chef']['nginx']['ssl_email_address']}
     EOH
     end
   
     ruby_block 'create crtfile' do
       block do
         r = Chef::Resource::File.new(ssl_crtfile, run_context)
         r.owner 'root'
         r.group 'root'
         r.mode '0755'
         r.content "/opt/opscode/embedded/bin/openssl req -config '#{ssl_signing_conf}' -new -x509 -nodes -sha1 -days 3650 -key '#{ssl_keyfile}'"
         r.not_if { File.exist?(ssl_crtfile) }
         r.run_action(:create)
       end
     end
   end
