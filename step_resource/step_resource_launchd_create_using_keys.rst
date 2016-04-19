.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. Create a Launch Daemon using keys**

.. code-block:: ruby

   launchd 'call.mom.weekly' do
     program '/Library/scripts/call_mom.sh'
     start_calendar_interval 'weekday' => 7, 'hourly' => 10
     time_out 300
   end
