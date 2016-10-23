.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


Use the **service** resource to enable, and then start the service:

.. code-block:: ruby

   service "httpd-#{instance_name}" do
     action [:enable, :start]
   end
