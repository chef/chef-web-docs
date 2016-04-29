.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |supermarket| omnibus package does not log |ruby on rails| messages by default. To enable debug logging, edit the ``/opt/supermarket/embedded/service/supermarket/config/environments/production.rb`` file and set the ``config.log_level`` setting to ``:debug``:

.. code-block:: ruby

   config.logger = Logger.new('/var/log/supermarket/rails/rails.log')
   config.logger.level = 'DEBUG'
   config.log_level = :debug

Save the file, and then restart the |ruby on rails| service:

.. code-block:: bash

   $ supermarket-ctl restart rails
