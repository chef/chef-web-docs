.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``ui`` object provides a set of methods that can be used to define user interactions and to help ensure a consistent user experience across |knife| plugins. The following methods should be used in favor of manually handling user interactions:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Method
     - Description
   * - ``ui.ask(*args, &block)``
     - 
   * - ``ui.ask_question(question, opts={})``
     - Use to ask a user the question contained in ``question``. If ``:default => default_value`` is passed as the second argument, ``default_value`` will be used if the user does not provide an answer. This method will respect the ``--default`` command-line option.
   * - ``ui.color(string, *colors)``
     - Use to specify a color. For example, from the ``knife rackspace server list`` subcommand:
       
       .. code-block:: ruby
 
           server_list = [
             ui.color('Instance ID', :bold),
             ui.color('Name', :bold),
             ui.color('Public IP', :bold),
             ui.color('Private IP', :bold),
             ui.color('Flavor', :bold),
             ui.color('Image', :bold),
             ui.color('State', :bold)
           ]

       and from the ``knife eucalyptus server create`` subcommand:

       .. code-block:: ruby
  
          server = connection.servers.create(server_def)
            puts "#{ui.color("Instance ID", :cyan)}: #{server.id}"
            puts "#{ui.color("Flavor", :cyan)}: #{server.flavor_id}"
            puts "#{ui.color("Image", :cyan)}: #{server.image_id}"
            ...
            puts "#{ui.color("SSH Key", :cyan)}: #{server.key_name}"
          print "\n#{ui.color("Waiting for server", :magenta)}"
   * - ``ui.color?()``
     - Indicates that colored output should be used. (Colored output can only be used when output is sent to a terminal.)
   * - ``ui.confirm(question, append_instructions=true)``
     - Use to ask a Y/N question. If the user responds with ``N``, immediately exit with status code 3.
   * - ``ui.edit_data(data, parse_output=true)``
     - Use to edit data. This opens the |chef editor|.
   * - ``ui.edit_object(klass, name)``
     - 
   * - ``ui.error``
     - Use to present an error to the user.
   * - ``ui.fatal``
     - Use to present a fatal error to the user.
   * - ``ui.highline``
     - Use to provide direct access to the `Highline object <http://highline.rubyforge.org/doc/>`_ used by many ``ui`` methods.
   * - ``ui.info``
     - Use to present a message to a user.
   * - ``ui.interchange``
     - Use to determine if the output is a data interchange format such as |json| or |yaml|.
   * - ``ui.list(*args)``
     - 
   * - ``ui.msg(message)``
     - Use to present a message to the user.
   * - ``ui.output(data)``
     - Use to present a data structure to the user. This method will respect the output requested when the ``-F`` command-line option is used. The output will use the generic default presenter.
   * - ``ui.pretty_print(data)``
     - Use to enable pretty-print output for |json| data.
   * - ``ui.use_presenter(presenter_class)``
     - Use to specify a custom output presenter.
   * - ``ui.warn(message)``
     - Use to present a warning to the user.

For example, to show a fatal error in a plugin in the same way that it would be shown in |knife| do something similar to the following:

.. code-block:: ruby

    unless name_args.size == 1
      ui.fatal "Be sure to say hello to someone!"
      show_usage
      exit 1
   end

