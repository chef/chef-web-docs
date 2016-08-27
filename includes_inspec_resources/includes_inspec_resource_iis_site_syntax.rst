.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``iis_site`` |inspec resource| block declares details about the named site:

.. code-block:: ruby

   describe iis_site('site_name') do
     it { should exist }
     it { should be_running }
     it { should have_app_pool('app_pool_name') }
     it { should have_binding('binding_details') }
     it { should have_path('path_to_site') }
   end

where

* ``'site_name'`` is the name of the site, such as ``'Default Web Site'``
* ``('app_pool_name')`` is the name of the application pool in which the site's root application is run, such as ``'DefaultAppPool'``
* ``('binding_details')`` is a binding for the site, such as ``'net.pipe *'``. A site may have multiple bindings; therefore, use a ``have_binding`` matcher for each site binding to be tested
* ``('path_to_site')`` is the path to the site, such as ``'C:\\inetpub\\wwwroot'``

For example:

.. code-block:: ruby

   describe iis_site('Default Web Site') do
     it { should exist }
     it { should be_running }
     it { should have_app_pool('DefaultAppPool') }
     it { should have_binding('https :443:www.contoso.com sslFlags=0') }
     it { should have_binding('net.pipe *') }
     it { should have_path('C:\\inetpub\\wwwroot') }
   end
