.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to install a lightweight JavaScript framework into Vagrant:

.. code-block:: ruby

   execute "install q and zombiejs" do
     cwd "/home/vagrant"
     user "vagrant"
     environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
     command "npm install -g q zombie should mocha coffee-script"
     action :run
   end

