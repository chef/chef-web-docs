.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To run a program on the fifth hour of the day:

.. code-block:: ruby

   cron 'noop' do
     hour '5'
     minute '0'
     command '/bin/true'
   end
