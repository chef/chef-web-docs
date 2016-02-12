.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following examples show how partial search can be used in a recipe. First, a recipe without partial search:

.. code-block:: ruby

   nodes = search(:node, "keys_ssh:* NOT name:#{node.name}")
   nodes << node

   begin
     other_hosts = data_bag('ssh_known_hosts')
     other_hosts.each do |h|
       host = data_bag_item('ssh_known_hosts', h).to_hash
       host['ipaddress'] ||= r.getaddress(host['fqdn'])
       host['keys'] = {
         'ssh' => {}
       }
       host['keys']['ssh']['host_rsa_public'] = host['rsa'] if host.has_key?('rsa')
       host['keys']['ssh']['host_dsa_public'] = host['dsa'] if host.has_key?('dsa')
       nodes << host
     end
   end

and then the same recipe that uses the ``partial_search`` method to provide better and more targeted search results:

.. code-block:: ruby

   nodes = partial_search(:node, "keys_ssh:* NOT name:#{node.name}",
     :keys => {
       'hostname' => [ 'hostname' ], 
       'fqdn'     => [ 'fqdn' ],
       'ipaddress' => [ 'ipaddress' ],
       'host_rsa_public' => [ 'keys', 'ssh', 'host_rsa_public' ],
       'host_dsa_public' => [ 'keys', 'ssh', 'host_dsa_public' ]
       }
     )

   nodes << { 
     'hostname'  => node['hostname'],
     'fqdn'      => node['fqdn'],
     'ipaddress' => node['ipaddress'],
     'host_rsa_public' => node['ssh'] && 
                          node['ssh']['keys'] && 
                          node['ssh']['keys']['host_rsa_public'] ? 
                          node['ssh']['keys']['host_rsa_public'] : nil,
     'host_dsa_public' => node['ssh'] && 
                          node['ssh']['keys'] && 
                          node['ssh']['keys']['host_dsa_public'] ? 
                          node['ssh']['keys']['host_dsa_public'] : nil,
     }

   begin
     other_hosts = data_bag('ssh_known_hosts')
     other_hosts.each do |h|
       host = data_bag_item('ssh_known_hosts', h).to_hash
       host['ipaddress'] ||= r.getaddress(host['fqdn'])
       host['host_rsa_public'] = host.has_key?('rsa') ? host['rsa'] : nil
       host['host_dsa_public'] = host.has_key?('dsa') ? host['dsa'] : nil
       nodes << host
     end
   end

And a different example from a different recipe. First, without partial search:

.. code-block:: ruby

   def generate_status_hash(query)
     result = Hash.new
     client_with_actor.get("search/node?q=*:*&sort=&start=0&rows=20")["rows"].each do |n|
       result[n.name] = n unless n.nil?
     end
     result
   end

and then the same recipe using a partial search:

.. code-block:: ruby

   def generate_status_hash(query)
     result = Hash.new
     args = { 
       'name' => [ 'name' ], 
       'platform'   => [ 'platform' ], 
       'platform_version' => [ 'platform_version' ], 
       'fqdn' => [ 'fqdn' ], 
       'ipaddress' => [ 'ipaddress' ], 
       'uptime' => [ 'uptime' ], 
       'ohai_time' => [ 'ohai_time' ], 
       'run_list' => [ 'run_list' ]
     }
     client_with_actor.post("search/node?q=*:*&sort=&start=0", args)["rows"].each do |n| puts n.inspect
       result[n['data']['name']] = n['data'] unless n.nil?
     end
     result
   end

 









   

