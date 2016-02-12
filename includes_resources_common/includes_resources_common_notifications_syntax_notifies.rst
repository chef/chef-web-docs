.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Specify the ``:action``, ``'resource[name]'``, and timer (``:delayed`` or ``:immediately``). Use multiple ``notifies`` statements to notify more than one resource.

.. code-block:: ruby

   resource 'name' do
     ... 
     notifies :action, 'resource[name]', :timer
   end
