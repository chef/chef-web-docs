.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``windows_feature`` |inspec resource| block declares the name of the |windows| feature, tests if that feature is installed, and then returns information about that feature:

.. code-block:: ruby

   describe windows_feature('feature_name') do
     it { should be_installed }
   end

where

* ``('feature_name')`` must specify a |windows| feature name, such as ``DHCP Server`` or ``IIS-Webserver``
* ``be_installed`` is a valid matcher for this |inspec resource|
