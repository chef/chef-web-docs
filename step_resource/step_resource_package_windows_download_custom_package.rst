.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To download a custom package:

.. code-block:: ruby

   windows_package 'Microsoft Visual C++ 2005 Redistributable' do
     source 'https://download.microsoft.com/download/6/B/B/6BB661D6-A8AE-4819-B79F-236472F6070C/vcredist_x86.exe'
     installer_type :custom
     options '/Q'
   end
