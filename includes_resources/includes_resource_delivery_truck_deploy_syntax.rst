.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The syntax for using the ``delivery_truck_deploy`` resource in a recipe is as follows:

.. code-block:: ruby

   delivery_truck_deploy 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end
