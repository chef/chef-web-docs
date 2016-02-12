.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. To use the ``ignore_failure`` common attribute in a recipe:

.. code-block:: ruby

   gem_package 'syntax' do
     action :install
     ignore_failure true
   end
