.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the following steps to keep the master branch up to date. 

#. Run:
    
   .. code-block:: bash

      $ git checkout master

#. And then run:

   .. code-block:: bash

      $ git pull --rebase
   
The following ``rakefile`` can be used to update Chef, Ohai, and cookbooks. Edit as necessary:

.. code-block:: ruby

   projects = %w[chef cookbooks ohai]
   chef = "#{ENV['HOME']}/projects/chef"

   desc 'Update local repositories from upstream'
   task :update do
     projects.each do |p|
       Dir.chdir('#{chef}/#{p}') do
         sh 'git fetch chef'
         sh 'git rebase chef/master master'
       end
     end
   end
