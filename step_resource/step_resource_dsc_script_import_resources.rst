.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``imports`` property to import resources from a module:

.. code-block:: ruby

   dsc_script 'RDP' do
     imports 'cRDPEnabled', 'PSHOrg_cRDPEnabled'
     code <<-EOH
     cRDPEnabled "enablerdp"
       {
         Enabled = $True
       }
      EOH
   end
