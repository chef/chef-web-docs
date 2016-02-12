.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To return details about a specific |chef client| run, run the following command:

.. code-block:: bash

   $ knife runs show c40csdcf2-5007-433c-95570-8e0c7e55f496

For a |chef client| run that succeeded, the command will return something similar to:

.. code-block:: bash

   $ run_detail:
       data:
         end_time:          2013-12-10T17:18:49Z
         node_name:         kitchen-vagrant
         run_id:            c40csdcf2-5007-433c-95570-8e0c7e55f496
         run_list:          ["recipe[createfile]"]
         start_time:        2013-12-10T17:18:49Z
         status:            success
         total_res_count:   1
         updated_res_count: 1
     run_resources:
       cookbook_name:    createfile
       cookbook_version: 0.0.0
       duration:         41
       final_state:
         checksum: f29bc64a9d3123454gfdsffdb3285f5bsdfsdf72414671e0ca3b2e0de
         group:    root
         mode:     0755
         owner:    root
       id:               /tmp/test
       initial_state:
         checksum: 
         group:    
         mode:     
         owner:    
       name:             /tmp/test
       result:           touch
       type:             file
       uri:              URI

For a |chef client| run that failed (or had some type of error), the command will return something similar to:

.. code-block:: bash

   $ run_detail:
       data:
         exception:
           backtrace: ["/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'initialize'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'open'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'block in connect'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/timeout.rb:55:in 'timeout'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/timeout.rb:100:in 'timeout'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:763:in 'connect'",
                       "/opt/chef/embedded/lib/ruby/1.9.3/net/http.rb:756:in 'do_start'",
                       ...
                       "/usr/bin/chef-client:23:in 'load'",
                       "/usr/bin/chef-client:23:in '<main>'"]
           class:       #<SocketError: Error connecting to URL - getaddrinfo: Temporary failure in name resolution>
           description:
             sections:
               Networking Error:: Error connecting to URL - getaddrinfo: Temporary failure in name resolution
                                  Your chef_server_url may be misconfigured, or the network could be down.
               Relevant Config Settings:: chef_server_url  "URL"
             title:    Error Syncing Cookbooks:
             message:     Error connecting to URL - getaddrinfo: Temporary failure in name resolution
             end_time:          2013-12-10T14:38:18Z
             node_name:         node_name
             run_id:            c40csdcf2-5007-433c-95570-8e0c7e55f496
             run_list:          ["recipe[createfile]"]
             start_time:        2013-12-10T14:37:37Z
             status:            failure
             total_res_count:   0
             updated_res_count: 0
     run_resources: