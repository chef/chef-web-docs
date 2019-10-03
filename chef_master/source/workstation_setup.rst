=====================================================
Configuring Chef Workstation
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chefdk_setup.rst>`__

This guide contains common configuration options used when setting up a new Chef Workstation installation. If you do not have Chef Workstation installed, see its  `installation guide </install_workstation.html>`__ before proceeding further.

Configure Ruby Environment
=====================================================
For many users of Chef, the version of Ruby that is included in Chef Workstation should be configured as the default version of Ruby.

.. note:: These instructions are intended for macOS and Linux users. For instructions on setting up your Ruby environment on Windows, see `Chef Workstation on Windows </dk_windows.html#configure-environment>`__.

#. Open a command window and enter the following:

   .. code-block:: bash

      $ which ruby

   which will return something like ``/usr/bin/ruby``.
#. To use Chef Workstation version of Ruby as the default Ruby, edit the ``$PATH`` and ``GEM`` environment variables to include paths to Chef Workstation. For example, on a machine that runs Bash, run:

   .. code-block:: bash

      echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

   where ``bash`` and ``~/.bash_profile`` represents the name of the shell.

   If zsh is your preferred shell then run the following:

   .. code-block:: bash

    echo 'eval "$(chef shell-init zsh)"' >> ~/.zshrc

#. Run ``which ruby`` again. It should return ```/opt/chef-workstation/embedded/bin/ruby``.

.. note:: Using Chef Workstation-provided Ruby as your system Ruby is optional. For many users, Ruby is primarily used for authoring Chef cookbooks and recipes. If that's true for you, then using the Chef Workstation-provided Ruby is recommended.


Add Ruby to $PATH
=====================================================
Chef Infra Client includes a stable version of Ruby as part of its installer. The path to this version of Ruby must be added to the ``$PATH`` environment variable and saved in the configuration file for the command shell (Bash, csh, and so on) that is used on the machine running Chef Workstation. In a command window, type the following:

.. code-block:: bash

   echo 'export PATH="`/opt/chef-workstation/embedded/bin:$PATH"' >> ~/.configuration_file && source ~/.configuration_file

where ``configuration_file`` is the name of the configuration file for the specific command shell. For example, if Bash were the command shell and the configuration file were named ``bash_profile``, the command would look something like the following:

.. code-block:: bash

   echo 'export PATH="`/opt/chef-workstation/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

.. warning:: On Microsoft Windows, ``C:/opscode/Chef Workstation/bin`` must be before ``C:/opscode/Chef Workstation/embedded/bin`` in the ``PATH``.

Create the Chef repository
=====================================================

Use `the chef generate repo </ctl_chef.html#chef-generate-repo>`__ to create the Chef repository. For example, to create a repository called ``chef-repo``:

.. code-block:: bash

   chef generate repo chef-repo

Create .chef Directory
-----------------------------------------------------

The ``.chef`` directory is used to store three files:

* ``config.rb``
* ``ORGANIZATION-validator.pem``
* ``USER.pem``

Where ``ORGANIZATION`` and ``USER`` represent strings that are unique to each organization. These files must be present in the ``.chef`` directory in order for Chef Workstation to be able to connect to a Chef Infra Server.

To create the ``.chef`` directory:

#. In a command window, enter the following:

   .. code-block:: bash

      mkdir -p ~/chef-repo/.chef

   Note that you'll need to replace ``chef-repo`` with the name of the repository you created previously.

#. After the ``.chef`` directory has been created, the following folder structure will be present on the local machine::

      chef-repo/
         .chef/        << the hidden directory
         certificates/
         config/
         cookbooks/
         data_bags
         environments/
         roles/

#. Add ``.chef`` to the ``.gitignore`` file to prevent uploading the contents of the ``.chef`` folder to GitHub. For example:

   .. code-block:: bash

      $ echo '.chef' >> ~/chef-repo/.gitignore



Starter Kit
-----------------------------------------------------
If you have access to Chef Infra Server through Automate or Chef Manage, you can download the starter kit. The starter kit will create the necessary configuration files: the ``.chef`` directory, ``config.rb``, ``ORGANIZATION-validator.pem``, and ``USER.pem``. Simply download the starter kit and then move it to the desired location on your Chef Workstation machine.

Configure the Chef Repository
=====================================================

With WebUI
-----------------------------------------------------
Use the following steps to manually set up the chef-repo and to use the Chef management console to get the ``.pem`` and ``config.rb`` files.

Get Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++

For a Chef Workstation installation that will interact with the Chef Infra Server (including the hosted Chef Infra Server), log on and download the following files:

* ``config.rb``. This configuration file can be downloaded from the **Organizations** page.
* ``ORGANIZATION-validator.pem``. This private key can be downloaded from the **Organizations** page.
* ``USER.pem``. This private key can be downloaded from the **Change Password** section of the **Account Management** page.

Move Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The ``config.rb``, ``ORGANIZATION-validator.pem``, and ``USER.pem`` files must be moved to the ``.chef`` directory after they are downloaded from the Chef Infra Server.

To move files to the ``.chef`` directory:

#. In a command window, enter each of the following:

   .. code-block:: bash

      cp /path/to/config.rb ~/chef-repo/.chef

   and:

   .. code-block:: bash

      cp /path/to/ORGANIZATION-validator.pem ~/chef-repo/.chef

   and:

   .. code-block:: bash

      cp /path/to/USERNAME.pem ~/chef-repo/.chef

   where ``/path/to/`` represents the path to the location in which these three files were placed after they were downloaded.

#. Verify that the files are in the ``.chef`` folder.

Without WebUI
-----------------------------------------------------
Use the following steps to manually set up the Chef repository: On your Chef Infra Server, create the ``ORGANIZATION-validator.pem`` and ``USER.pem`` files with the ``chef-server-ctl`` command line tool. Then, on your workstation create the ``config.rb`` file with the ``knife`` tool.

Create an Organization
+++++++++++++++++++++++++++++++++++++++++++++++++++++

On the Chef Infra Server machine create the ``ORGANIZATION-validator.pem`` from the command line using ``chef-server-ctl``. Run the following command:

.. code-block:: bash

   $ chef-server-ctl org-create ORG_NAME ORG_FULL_NAME -f FILE_NAME

where

* The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``chef``
* The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``"Chef Software, Inc."``
* ``-f FILE_NAME``: Write the ``ORGANIZATION-validator.pem`` to ``FILE_NAME`` instead of printing it to ``STDOUT``. For example: ``/tmp/chef.key``.

For example, an organization named ``chef``, with a full name of ``Chef Software, Inc.``, and with the ORGANIZATION-validator.pem file saved to ``/tmp/chef.key``:

.. code-block:: bash

   $ chef-server-ctl org-create chef "Chef Software, Inc." -f /tmp/chef.key

Create a User
+++++++++++++++++++++++++++++++++++++++++++++++++++++

On the Chef Infra Server machine create the ``USER.pem`` from the command line using ``chef-server-ctl``. Run the following command:

.. code-block:: bash

   $ chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL PASSWORD -f FILE_NAME

where

* ``-f FILE_NAME`` writes the ``USER.pem`` to a file instead of ``STDOUT``. For example: ``/tmp/grantmc.key``.

For example: a user named ``grantmc``, with a first and last name of ``Grant McLennan``, an email address of ``grantmc@chef.io``, a poorly-chosen password, and a ``USER.pem`` file saved to ``/tmp/grantmc.key``:

.. code-block:: bash

   $ chef-server-ctl user-create grantmc Grant McLennan grantmc@chef.io p@s5w0rD! -f /tmp/grantmc.key

Move .pem Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Download the ``ORGANIZATION-validator.pem`` and ``USER.pem`` files from the Chef Infra Server and move them to the ``.chef`` directory.

To move files to the .chef directory:

#. In a command window, enter each of the following:

   .. code-block:: bash

      cp /path/to/ORGANIZATION-validator.pem ~/chef-repo/.chef

   and:

   .. code-block:: bash

      cp /path/to/USERNAME.pem ~/chef-repo/.chef

   where ``/path/to/`` represents the path to the location in which these three files were placed after they were downloaded.

#. Verify that the files are in the ``.chef`` folder.

Create the config.rb File
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Navigate to the ``~/chef-repo/.chef`` directory and create the ``config.rb`` using the ``knife configure`` tool. The file must be created in the ``.chef`` folder. It should look similar to:

.. code-block:: ruby

   current_dir = File.dirname(__FILE__)
   log_level                :info
   log_location             STDOUT
   node_name                'node_name'
   client_key               "#{current_dir}/USER.pem"
   validation_client_name   'ORG_NAME-validator'
   validation_key           "#{current_dir}/ORGANIZATION-validator.pem"
   chef_server_url          'https://api.chef.io/organizations/ORG_NAME'
   cache_type               'BasicFile'
   cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
   cookbook_path            ["#{current_dir}/../cookbooks"]

At a minimum, you must update the following settings with the appropriate values:

* ``client_key`` should point to the location of the Chef Infra Server user's ``.pem`` file on your Chef Workstation machine.
* ``validation_client_name`` should be updated with the name of the desired organization that was created on the Chef Infra Server.
* ``validation_key`` should point to the location of your organization's ``.pem`` file on your Chef Workstation machine.
* ``chef_server_url`` must be updated with the domain or IP address used to access the Chef Infra Server.

See the `knife config.rb documentation </config_rb.html>`__ for more details.

Get SSL Certificates
=====================================================
Chef Server 12 enables SSL verification by default for all requests made to the server, such as those made by knife and Chef Infra Client. The certificate that is generated during the installation of the Chef Infra Server is self-signed, which means there isn't a signing certificate authority (CA) to verify. In addition, this certificate must be downloaded to any machine from which knife and/or Chef Infra Client will make requests to the Chef Infra Server.

Use the ``knife ssl fetch`` subcommand to pull the SSL certificate down from the Chef Infra Server:

.. code-block:: bash

   knife ssl fetch

See `SSL Certificates </chef_client_security.html#ssl-certificates>`__ for more information about how knife and Chef Infra Client use SSL certificates generated by the Chef Infra Server.

Verify Install
=====================================================
The Chef Workstation is installed correctly when it is able to use ``knife`` to communicate with the Chef Infra Server.

To verify that Chef Workstation can connect to the Chef Infra Server:

#. In a command window, navigate to the Chef repository:

   .. code-block:: bash

      cd ~/chef-repo

#. In a command window, enter the following:

   .. code-block:: bash

      knife client list

   to return a list of clients (registered nodes and Chef Workstation installations) that have access to the Chef Infra Server. For example:

   .. code-block:: bash

      chefdk_machine
      registered_node
