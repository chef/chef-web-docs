.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to use ``not_if`` to prevent ZeroMQ from being installed when the node on which the install is to occur has a version of Red Hat Enterprise Linux that is older than version 6.0:

.. code-block:: ruby

   ark "test_autogen" do
     url 'https://github.com/zeromq/libzmq/tarball/master'
     extension "tar.gz"
     action :configure
     not_if { platform_family?('rhel') && node['platform_version'].to_f < 6.0 }
   end
