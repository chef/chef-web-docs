.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. code-block:: ruby

   changed_cookbooks.each do |cookbook|
     unless bumped_version?(cookbook[:path])
       raise DeliveryTruck::Error, "The #{cookbook[:name]} cookbook was modified " \
                                   "but the version was not updated in the " \
                                   "metadata file."
     end
   
     execute "syntax_check_#{cookbook[:name]}" do
       command "knife cookbook test -o #{cookbook[:path]} -a"
     end
   end
