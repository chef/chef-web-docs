.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To create a user named "random":

.. code-block:: ruby

   user 'random' do
     manage_home true
     comment 'User Random'
     uid '1234'
     gid '1234'
     home '/home/random'
     shell '/bin/bash'
     password '$1$JJsvHslV$szsCjVEroftprNn4JHtDi'
   end
