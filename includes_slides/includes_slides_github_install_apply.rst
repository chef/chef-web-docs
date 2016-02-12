.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Run:

.. code-block:: bash

   $ sudo chef-apply ~/git.rb

Returns:

.. code-block:: bash

   Recipe: (chef-apply cookbook)::(chef-apply recipe)
     * package[git] action install
       - install version 1.7.1-3.el6_4.1 of package git
     * file[/home/chef/.gitconfig] action create
       - create new file /home/chef/.gitconfig
       - update content in file /home/chef/.gitconfig from none to 259950
         --- /home/chef/.gitconfig
         +++ /tmp/..gitconfig20140924-10180-1ij68vq 
         @@ -1 +1,4 @@
         +[user]
         +  name=John Doe
         +  email=jdoe@example.com
       - change owner from '' to 'chef'
       - change group from '' to 'chef'
       - restore selinux security context
