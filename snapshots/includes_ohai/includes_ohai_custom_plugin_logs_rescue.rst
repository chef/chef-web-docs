.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``rescue`` clause to make sure that a log message is always provided. For example:

.. code-block:: ruby

   rescue LoadError => e
     Ohai::Log.debug('ip_scopes: cannot load gem, plugin disabled: #{e}')
   end
