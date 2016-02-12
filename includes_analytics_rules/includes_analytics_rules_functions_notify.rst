.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``notify()`` to configure notifications for a rule. Notifications may be sent with the following notification types: email, webhook, |hipchat|, and |splunk|.

The syntax for this function:

.. code-block:: ruby

   notify(notificationName, stringTemplate)

where:

* ``notificationName`` is the name of the notification to trigger.
* ``stringTemplate`` is an optional |mustache| template that defines the notification. The template must evaluate to a valid JSON string.

Field names in the |mustache| template must be prefixed by ``message.``, e.g. ``{{message.reported_at}}`` using `a valid field name for the message type <https://docs.chef.io/analytics_rules.html#message-types>`_. For more information on the |mustache| template format, see https://mustache.github.io.

For example:

.. code-block:: ruby

   rules 'Send notification'
     rule on action
       when
         organization_name = 'ponyville' and
         (entity_type = 'foo' or entity_type = 'bar') and
         remote_hostname =~ '33\.3[0-9].*'
       then
         set value #foo = '100'
         set value #xyz = 'test'
         notify('slack', '{
           "text": "{{message.requestor_name}} did something at {{message.recorded_at}}!"
         }')
     end
   end
