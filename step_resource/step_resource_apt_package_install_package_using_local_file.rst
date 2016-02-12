.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To install a package using local file:

.. code-block:: ruby 

   apt_package 'jwhois' do    
     action :install
     source '/path/to/jwhois.deb'
   end   
