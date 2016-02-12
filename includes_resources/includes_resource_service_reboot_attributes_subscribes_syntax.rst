.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Specify the ``:action``, ``'resource[name]'``, and timer (``:immediately``). Use multiple ``subscribes`` statements to listen to more than one resource.

.. code-block:: ruby

   resource 'name' do
     ... 
     subscribes :action, 'resource[name]', :immediately
   end
