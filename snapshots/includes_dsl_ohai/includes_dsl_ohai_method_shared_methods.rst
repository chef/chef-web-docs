.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A shared method defines behavior that may be used by more than one ``collect_data`` block, such as a data structure, a hash, or a mash. The syntax for a shared method is:

.. code-block:: ruby

   def a_shared_method
     # some Ruby code that defines the shared method
   end

For example, the following shared method is used to collect data about various cloud providers, depending on the cloud provider and the type of IP address:

.. code-block:: ruby

   def create_objects
     cloud Mash.new
     cloud[:public_ips] = Array.new
     cloud[:private_ips] = Array.new
   end

and then later on in the same plugin, the ``cloud`` object can be reused:

.. code-block:: ruby

   def get_linode_values
     cloud[:public_ips] << linode['public_ip']
     cloud[:private_ips] << linode['private_ip']
     cloud[:public_ipv4] = linode['public_ipv4']
     cloud[:public_hostname] = linode['public_hostname']
     cloud[:local_ipv4] = linode['local_ipv4']
     cloud[:local_hostname] = linode['local_hostname']
     cloud[:provider] = 'linode'
   end

and

.. code-block:: ruby

   def get_azure_values
     cloud[:vm_name] = azure['vm_name']
     cloud[:public_ips] << azure['public_ip']
     cloud[:public_fqdn] = azure['public_fqdn']
     cloud[:public_ssh_port] = azure['public_ssh_port'] if azure['public_ssh_port']
     cloud[:public_winrm_port] = azure['public_winrm_port'] if azure['public_winrm_port']
     cloud[:provider] = 'azure'
   end

and so on, for each of the various cloud providers.
