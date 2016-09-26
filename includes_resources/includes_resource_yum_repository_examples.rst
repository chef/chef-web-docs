|generic resource statement|

**Add internal company repository**

.. code-block:: ruby

   yum_repository 'OurCo' do
     description 'OurCo yum repository'
     mirrorlist 'http://artifacts.ourco.org/mirrorlist?repo=ourco-6&arch=$basearch'
     gpgkey 'http://artifacts.ourco.org/pub/yum/RPM-GPG-KEY-OURCO-6'
     action :create
   end

**Delete a repository**

.. code-block:: ruby

   yum_repository 'CentOS-Media' do
     action :delete
   end