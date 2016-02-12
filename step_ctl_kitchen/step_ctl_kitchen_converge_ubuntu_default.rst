.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To converge the default |ubuntu| instance, run the following:

.. code-block:: bash

   $ kitchen converge default-ubuntu-1404

The |chef client| is downloaded the first time this command is run. The output of the command is similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.4.2)
   -----> Converging <default-ubuntu-1404>...
          Preparing files for transfer
          Preparing cookbooks from project directory
          Removing non-cookbook files before transfer
          Preparing nodes
   -----> Installing Chef Omnibus (true)
          downloading https://www.chef.io/chef/install.sh
            to file /tmp/install.sh
          ...
          Downloading Chef ...
          Installing Chef ...    
          Thank you for installing Chef!       
          Transferring files to <default-ubuntu-1404>
          [2014-06-27T18:48:01+00:00] INFO: Forking chef instance to converge...       
          Starting Chef Client, version 12.4.1       
          [2014-06-27T18:48:01+00:00] INFO: *** Chef 12.4.1 ***       
          [2014-06-27T18:48:01+00:00] INFO: Chef-client pid: 1246       
          [2014-06-27T18:48:03+00:00] INFO: Setting the run_list to ["recipe[chef-repo::default]"] from CLI options       
          [2014-06-27T18:48:03+00:00] INFO: Run List is [recipe[chef-repo::default]]       
          [2014-06-27T18:48:03+00:00] INFO: Run List expands to [chef-repo::default]       
          [2014-06-27T18:48:03+00:00] INFO: Starting Chef Run for default-ubuntu-1404       
          [2014-06-27T18:48:03+00:00] INFO: Running start handlers       
          [2014-06-27T18:48:03+00:00] INFO: Start handlers complete.       
          Compiling Cookbooks...       
          Converging 1 resources       
          Recipe: chef-repo::default       
            * file[/home/vagrant/test.txt] action create... INFO: Processing file[/home/vagrant/test.txt] 
              action create (chef-repo::default line 10)       
          [2014-06-27T18:48:03+00:00] INFO: file[/home/vagrant/test.txt] created file /home/vagrant/test.txt       
            - create new file /home/vagrant/test.txt... INFO: file[/home/vagrant/test.txt] updated file contents /home/vagrant/test.txt       
            - update content in file /home/vagrant/test.txt from none to d9c88f       
          --- /home/vagrant/test.txt	2014-06-27 18:48:03.233096345 +0000       
           +++ /tmp/.test.txt20140627-1246-178u9dg	2014-06-27 18:48:03.233096345 +0000       
          @@ -1 +1,2 @@       
          +This file created by Chef!       
          [2014-06-27T18:48:03+00:00] INFO: Chef Run complete in 0.015439954 seconds       
          Running handlers:       
          [2014-06-27T18:48:03+00:00] INFO: Running report handlers       
          Running handlers complete       
          [2014-06-27T18:48:03+00:00] INFO: Report handlers complete       
          Chef Client finished, 1/1 resources updated in 1.955915841 seconds       
          Finished converging <default-ubuntu-1404> (0m15.67s).
   -----> Kitchen is finished. (0m15.96s)
