.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This role is for the admin node that provides DHCP, DNS, TFTP, PXE-booting and apt repository proxying.

.. code-block:: ruby

   name 'lab-admin'
   description 'Default run_list for the Admin node'
   run_list(
     'recipe[apt::cacher-ng]',
     'recipe[apt::cacher-client]',
     'recipe[ntp]',
     'recipe[openssh]',
     'recipe[users::sysadmins]',
     'recipe[sudo]',
     'recipe[chef-client]',
     'recipe[pxe_dust::server]'
     )
