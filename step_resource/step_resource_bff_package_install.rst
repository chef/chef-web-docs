.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To install a package:

The |resource package_bff| resource is the default package provider on the |ibm aix| platform. The base |resource package| resource may be used, and then when the platform is |ibm aix|, the |chef client| will identify the correct package provider. The following examples show how to install part of the |ibm aix compiler_c| compiler.

Using the base |resource package| resource:

.. code-block:: ruby

   package 'xlccmp.13.1.0' do
     source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'
     action :install
   end

Using the |resource package_bff| resource:

.. code-block:: ruby

   bff_package 'xlccmp.13.1.0' do
     source '/var/tmp/IBM_XL_C_13.1.0/usr/sys/inst.images/xlccmp.13.1.0'
     action :install
   end
