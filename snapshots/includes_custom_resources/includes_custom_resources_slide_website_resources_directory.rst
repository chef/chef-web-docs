.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


Use the **directory** resource to create the ``/var/www/vhosts`` directory on the node:

.. code-block:: ruby

   directory "/var/www/vhosts/#{instance_name}" do
     recursive true
     owner 'root'
     group 'root'
     mode '0755'
     action :create
   end
