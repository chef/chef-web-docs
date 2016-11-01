================================================
Event Handlers
================================================

.. revealjs::

 .. revealjs:: About Event Handlers

    .. tag dsl_handler_9

    Use the Handler DSL to attach a callback to an event. If the event occurs during the chef-client run, the associated callback is executed. For example:

    * Sending email if a chef-client run fails
    * Sending a notification to chat application if an audit run fails
    * Aggregating statistics about resources updated during a chef-client runs to StatsD

    .. end_tag

    .. note:: Read more about event handlers at https://docs.chef.io/dsl_handler.html.

 .. revealjs:: Event Types

    The following table shows some of the events that may occur during a chef-client run:

    .. list-table::
       :widths: 100 420
       :header-rows: 1

       * - Event
         - Description
       * - ``:audit_phase_failed``
         - The chef-client run audit phase has failed.
       * - ``:converge_failed``
         - The chef-client run converge phase has failed.
       * - ``:recipe_not_found``
         - The chef-client was unable to find the named recipe.
       * - ``:resource_failed``
         - A resource action has failed and will not be retried.
       * - ``:run_failed``
         - The chef-client run has failed.

    The full list of events is available at https://docs.chef.io/dsl_handler.html#event-types.

 .. revealjs:: Scenario: Send Email if the chef-client Run Fails

    .. tag dsl_handler_slide_send_email

    Use the ``on`` method to create an event handler that sends email when the chef-client run fails. This will require:

    * A way to tell the chef-client how to send email
    * An event handler that describes what to do when the ``:run_failed`` event is triggered
    * A way to trigger the exception and test the behavior of the event handler

    .. end_tag

 .. revealjs:: Send Email

    .. tag dsl_handler_slide_send_email_library

    Use a library to define the code that sends email when a chef-client run fails. Name the file ``helper.rb`` and add it to a cookbook's ``/libraries`` directory:

    .. code-block:: ruby

       require 'net/smtp'

       module HandlerSendEmail
         class Helper

           def send_email_on_run_failure(node_name)

             message = "From: Chef <chef@chef.io>\n"
             message << "To: Grant <grantmc@chef.io>\n"
             message << "Subject: Chef run failed\n"
             message << "Date: #{Time.now.rfc2822}\n\n"
             message << "Chef run failed on #{node_name}\n"
             Net::SMTP.start('localhost', 25) do |smtp|
               smtp.send_message message, 'chef@chef.io', 'grantmc@chef.io'
             end    
           end
         end
       end

    .. end_tag

 .. revealjs:: Add the Event Handler to a Recipe

    .. tag dsl_handler_slide_send_email_handler

    Invoke the library helper in a recipe:

    .. code-block:: ruby

       Chef.event_handler do
         on :run_failed do
           HandlerSendEmail::Helper.new.send_email_on_run_failure(
             Chef.run_context.node.name
           )
         end
       end

    * Use ``Chef.event_handler`` to define the event handler
    * Use the ``on`` method to specify the event type

    Within the ``on`` block, tell the chef-client how to handle the event when it's triggered.

    .. end_tag

 .. revealjs:: Test the Event Handler

    .. tag dsl_handler_slide_send_email_test

    Use the following code block to trigger the exception and have the chef-client send email to the specified email address:

    .. code-block:: ruby

       ruby_block 'fail the run' do
         block do
           fail 'deliberately fail the run'
         end
       end

    .. end_tag

 .. revealjs:: More Info About Event Handlers

    For more information, see:

    * |url slides_docs_chef_io|
    * https://docs.chef.io/dsl_handler.html
