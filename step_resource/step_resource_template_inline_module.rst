.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A template helper module can be defined inline on a per-resource basis. This approach can be useful when a template requires more complex information. For example:

.. code-block:: ruby

   template '/path' do
     helpers do
   
       def hello_world
         'hello world'
       end
   
       def app
         node['app']
       end
   
       def app_conf(setting)
         node['app']['setting']
       end

     end
   end

where the ``hello_world``, ``app``, and ``app_conf(setting)`` methods comprise the module that extends a template.
