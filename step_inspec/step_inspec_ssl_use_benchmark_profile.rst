.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following shows how to use the ``ssl`` |inspec resource| to find all TCP ports on the system, including |ipv4| and |ipv6|. (This is a partial example `based on the ssl_text.rb file in the ssl-benchmark profile <https://github.com/dev-sec/ssl-benchmark/blob/master/controls/ssl_test.rb>`__ on |github|.)

.. code-block:: ruby

   ...
   
   control 'tls1.2' do
     title 'Run TLS 1.2 whenever SSL is active on a port'
     impact 0.5
   
     sslports.each do |socket|
       proc_desc = "on node == #{command('hostname').stdout.strip} running #{socket.process.inspect} (#{socket.pid})"
       describe ssl(port: socket.port).protocols('tls1.2') do
         it(proc_desc) { should be_enabled }
         it { should be_enabled }
       end
     end
   end
   
   ...
   
   control 'rc4' do
     title 'Disable RC4 ciphers from all exposed SSL/TLS ports and versions.'
     impact 0.5
   
     sslports.each do |socket|
       proc_desc = "on node == #{command('hostname').stdout.strip} running #{socket.process.inspect} (#{socket.pid})"
       describe ssl(port: socket.port).ciphers(/rc4/i) do
         it(proc_desc) { should_not be_enabled }
         it { should_not be_enabled }
       end
     end
   end
