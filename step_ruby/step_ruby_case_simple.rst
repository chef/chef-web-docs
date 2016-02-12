.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. The following example shows a simple ``case`` statement:

.. code-block:: ruby

   case node[:platform]
     when 'platform_1', 'platform_2'
       package 'foo' do
         action :install
       end
     when 'platform_3', 'platform_4', 'platform_5', 'platform_6'
       package 'bar' do
         action :install
       end
     end
