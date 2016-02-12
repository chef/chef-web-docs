.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows a schedule that will run at 8:00 PM, every weekday (Monday through Friday), but only in November:

.. code-block:: ruby

   cron 'name_of_cron_entry' do
     minute '0'
     hour '20'
     day '*'
     month '11'
     weekday '1-5'
     action :create
   end
