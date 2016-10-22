.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following examples show different ways of doing the same thing. The first shows a series of packages that will be upgraded:

.. code-block:: ruby

   package 'package-a' do
     action :upgrade
   end
   
   package 'package-b' do
     action :upgrade
   end
   
   package 'package-c' do
     action :upgrade
   end
   
   package 'package-d' do
     action :upgrade
   end

and the next uses a single **package** resource and a whitespace array (``%w``):

.. code-block:: ruby
   
   %w{package-a package-b package-c package-d}.each do |pkg|
     package pkg do
       action :upgrade
     end
   end

where ``|pkg|`` is used to define the name of the resource, but also to ensure that each item in the whitespace array has its own name.
