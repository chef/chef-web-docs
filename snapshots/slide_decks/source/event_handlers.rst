================================================
Event Handlers
================================================

.. revealjs::

 .. revealjs:: About Event Handlers

    .. include:: ../../includes_dsl_handler/includes_dsl_handler.rst

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

    .. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email.rst

 .. revealjs:: Send Email

    .. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_library.rst

 .. revealjs:: Add the Event Handler to a Recipe

    .. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_handler.rst

 .. revealjs:: Test the Event Handler

    .. include:: ../../includes_dsl_handler/includes_dsl_handler_slide_send_email_test.rst

 .. revealjs:: More Info About Event Handlers

    For more information, see:

    * |url slides_docs_chef_io|
    * https://docs.chef.io/dsl_handler.html
