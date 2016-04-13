.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When ``%w`` syntax uses a variable, such as ``|foo|``, double quoted strings should be used.

Right:

.. code-block:: ruby

   %w{openssl.cnf pkitool vars Rakefile}.each do |foo|
     template "/etc/openvpn/easy-rsa/#{foo}" do
       source "#{foo}.erb"
       ...
     end
   end

Wrong:

.. code-block:: ruby

   %w{openssl.cnf pkitool vars Rakefile}.each do |foo|
     template '/etc/openvpn/easy-rsa/#{foo}' do
       source '#{foo}.erb'
       ...
     end
   end
