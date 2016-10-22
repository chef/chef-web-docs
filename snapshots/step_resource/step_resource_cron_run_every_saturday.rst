.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows a schedule that will run every hour at 8:00 each Saturday morning, and will then send an email to "admin@example.com" after each run.

.. code-block:: ruby

   cron 'name_of_cron_entry' do
     minute '0'
     hour '8'
     weekday '6'
     mailto 'admin@example.com'
     action :create
   end
