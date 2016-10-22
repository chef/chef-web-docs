.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


For example:

.. code-block:: ruby

   name "jenkins-master"
   run_list "java", "jenkins::master", "recipe[policyfile_demo]"
   default_source :supermarket, "https://mysupermarket.example"
   cookbook "policyfile_demo", path: "cookbooks/policyfile_demo"
   cookbook "jenkins", "~> 2.1"
   cookbook "mysql", github: "chef-cookbooks/mysql", branch: "master"
