.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete a VPC that has a defined route table:

An |amazon vpc| cannot be deleted when it has a non-main route table attached to it. To delete an |amazon vpc|, first restore the ``default`` route table, and then delete the |amazon vpc| and the associated non-main route table. For example:

.. code-block:: ruby

   aws_vpc 'ref-vpc' do
     main_route_table lazy {
       self.aws_object.route_tables.select {|r| !r.main?}.first
     }
     only_if { !self.aws_object.nil? }
   end
   
   aws_route_table 'ref-main-route-table' do
     action :destroy
   end
   
   aws_vpc 'ref-vpc' do
     action :destroy
   end
