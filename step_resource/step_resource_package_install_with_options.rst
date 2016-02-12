.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To install a package with options:

.. code-block:: ruby

   package 'debian-archive-keyring' do
     action :install
     options '--force-yes'
   end
