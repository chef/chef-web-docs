.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following Ohai example shows a plugin can use a ``mixin`` library and also depend on another plugin:

.. code-block:: ruby

   require 'ohai/mixin/os'
   
   Ohai.plugin(:Os) do
     provides 'os', 'os_version'
     depends 'kernel'
   
     collect_data do
       os collect_os
       os_version kernel[:release]
     end
   end
