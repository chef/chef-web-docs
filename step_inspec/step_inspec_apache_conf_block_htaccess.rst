.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test for blocking .htaccess files on CentOS:

.. code-block:: ruby

   describe apache_conf do
     its('AllowOverride') { should eq 'None' }
   end
