.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To associate an elastic IP address with a machine:

.. code-block:: ruby

   require 'chef/provisioning/aws_driver'
   
   with_driver 'aws::us-west-2' do
   
     machine "SRV_OR_Web_1" do
       machine_options :bootstrap_options => {
         :key_name => 'Tst_Prov'
       }
     end
   
     aws_eip_address 'Web_IP_1' do
       machine 'SRV_OR_Web_1'
     end
   end
