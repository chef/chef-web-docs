.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


``httpd.service.erb`` tells systemd how to start and stop the website:

.. code-block:: none

   [Unit]
   Description=The Apache HTTP Server - instance <%= @instance_name %>
   After=network.target remote-fs.target nss-lookup.target
   
   [Service]
   Type=notify
   
   ExecStart=/usr/sbin/httpd -f /etc/httpd/conf/httpd-<%= @instance_name %>.conf -DFOREGROUND
   ExecReload=/usr/sbin/httpd -f /etc/httpd/conf/httpd-<%= @instance_name %>.conf -k graceful
   ExecStop=/bin/kill -WINCH ${MAINPID}
   
   KillSignal=SIGCONT
   PrivateTmp=true
   
   [Install]
   WantedBy=multi-user.target

Copy it as shown, add it under ``/templates/default``, and then name it ``httpd.service.erb``.
