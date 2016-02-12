.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To add Apache to a machine image, and then build a machine:

.. code-block:: ruby

   machine_image 'web_image' do
     recipe 'apache2'
   end
   
   machine 'web_machine' do
    from_image 'web_image'
   end
