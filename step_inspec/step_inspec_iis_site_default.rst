.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test the default IIS site:

.. code-block:: ruby

   describe iis_site('Default Web Site') do
     it { should exist }
     it { should be_running }
     it { should have_app_pool('DefaultAppPool') }
     it { should have_binding('http *:80:') }
     it { should have_path('%SystemDrive%\\inetpub\\wwwroot\\') }
   end
