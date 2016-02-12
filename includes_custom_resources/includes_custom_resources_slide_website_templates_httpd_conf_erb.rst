.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


``httpd.conf.erb`` stores information about the website and is typically located under the ``/etc/httpd``:

.. code-block:: ruby

   ServerRoot "/etc/httpd"
   Listen <%= @port %>
   Include conf.modules.d/*.conf
   User apache
   Group apache
   <Directory />
     AllowOverride none
     Require all denied
   </Directory>
   DocumentRoot "/var/www/vhosts/<%= @instance_name %>"
   <IfModule mime_module> 
     TypesConfig /etc/mime.types
   </IfModule>

Copy it as shown, add it under ``/templates/default``, and then name the file ``httpd.conf.erb``.
