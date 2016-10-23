.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An if expression can be used to check for conditions (true or false).

To check for condition only for Debian and Ubuntu platforms:

.. code-block:: ruby

   if platform?("debian", "ubuntu")
     # do something if node['platform'] is debian or ubuntu
   else
     # do other stuff
   end
