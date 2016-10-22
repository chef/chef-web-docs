.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Event messages can be sent to a team communication tool like HipChat. For example, if a chef-client run fails:

.. code-block:: ruby

   Chef.event_handler do
     on :run_failed do |exception|
       hipchat_notify exception.message
     end
   end

or send an alert on a configuration change:

.. code-block:: ruby

   Chef.event_handler do
     on :resource_updated do |resource, action|
       if resource.to_s == 'template[/etc/nginx/nginx.conf]'
         Helper.hipchat_message("#{resource} was updated by chef")
       end
     end
   end
