.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To create a |yum| repository:

.. code-block:: ruby

   yum_repository 'zenoss' do
     description "Zenoss Stable repo"
     baseurl "http://dev.zenoss.com/yum/stable/"
     gpgkey 'http://dev.zenoss.com/yum/RPM-GPG-KEY-zenoss'
     action :create
   end

or:

.. code-block:: ruby

   yum_repository 'epel' do
     description 'Extra Packages for Enterprise Linux'
     mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
     gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
     action :create
   end



