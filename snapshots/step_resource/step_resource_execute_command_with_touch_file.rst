.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To execute a command with a touch file running only once:

.. code-block:: ruby

   execute 'upgrade script' do
     command 'php upgrade-application.php && touch /var/application/.upgraded'
     creates '/var/application/.upgraded'
     action :run
   end
