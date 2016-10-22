.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Memcached is an in-memory key-value store that helps improve the performance of database-driven websites and can be `installed, maintained, and tested <https://github.com/chef-cookbooks/memcached>`__ using the ``memcached`` cookbook (maintained by Chef). The following example is from the ``memcached`` cookbook and shows how to use a combination of the ``package``, ``service``, and ``port`` InSpec audit resources to test if Memcached is installed, enabled, and running:

.. code-block:: ruby

   describe package('memcached') do
     it { should be_installed }
   end
   
   describe service('memcached') do
     it { should be_installed }
     it { should be_enabled }
     it { should be_running }
   end
   
   describe port(11_211) do
     it { should be_listening }
   end
