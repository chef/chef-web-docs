.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To write a recipe that uses an SSH wrapper:

#. Create a file in the ``cookbooks/COOKBOOK_NAME/files/default`` directory that is named ``wrap-ssh4git.sh`` and which contains the following:

   .. code-block:: ruby

      #!/usr/bin/env bash
      /usr/bin/env ssh -o "StrictHostKeyChecking=no" -i "/tmp/private_code/.ssh/id_deploy" $1 $2

#. Set up the cookbook file.

#. Add a recipe to the cookbook file similar to the following:

   .. code-block:: ruby

      directory '/tmp/private_code/.ssh' do
        owner 'ubuntu'
        recursive true
      end
       
      cookbook_file '/tmp/private_code/wrap-ssh4git.sh' do
        source 'wrap-ssh4git.sh'
        owner 'ubuntu'
        mode '0755'
      end
      
      deploy 'private_repo' do
        repo 'git@github.com:acctname/private-repo.git'
        user 'ubuntu'
        deploy_to '/tmp/private_code'
        action :deploy
        ssh_wrapper '/tmp/private_code/wrap-ssh4git.sh'
      end

   This will deploy the git repository at ``git@github.com:acctname/private-repo.git`` in the ``/tmp/private_code`` directory.
