.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ rspec spec/unit/*.rb

Returns:

.. code-block:: bash

   Failures:
   
     1) apache::default installs apache
       Failure/Error: expect(chef_run).to install_package('httpd')
         expected "package[httpd]" with action :install to be in Chef run.
           Other package resources:
   
           package[http]
   
         # ./spec/unit/default_spec.rb:9:in 'block in <top (required)>'
   
       Finished in 0.00847 seconds (files took 4.85 seconds to load)
       1 example, 1 failure
   
       Failed examples:
   
       rspec ./spec/unit/default_spec.rb:8 # apache::default installs apache
