=====================================================
Configuring the ChefDK
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chefdk_setup.rst>`__

This guide contains common configuration options used when setting up a new ChefDK installation. If you do not have the ChefDK installed, see its  `installation guide </install_dk.html>`__ before proceeding further. 

Configure Ruby Environment
=====================================================
For many users of Chef, the version of Ruby that is included in the Chef development kit should be configured as the default version of Ruby.

.. note:: These instructions are intended for macOS and Linux users. For instructions on setting up your Ruby enviroment on Windows, see `ChefDK on Windows </dk_windows.html#configure-environment>`__.

#. Open a command window and enter the following:

   .. code-block:: bash

      $ which ruby

   which will return something like ``/usr/bin/ruby``.
#. To use the Chef development kit version of Ruby as the default Ruby, edit the ``$PATH`` and ``GEM`` environment variables to include paths to the Chef development kit. For example, on a machine that runs Bash, run:

   .. code-block:: bash

      echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

   where ``bash`` and ``~/.bash_profile`` represents the name of the shell.

   If zsh is your preferred shell then run the following:

   .. code-block:: bash

    echo 'eval "$(chef shell-init zsh)"' >> ~/.zshrc

#. Run ``which ruby`` again. It should return ``/opt/chefdk/embedded/bin/ruby``.

.. note:: Using the Chef development kit-provided Ruby as your system Ruby is optional. For many users, Ruby is primarily used for authoring Chef cookbooks and recipes. If that's true for you, then using the Chef Development Kit-provided Ruby is recommended.


Add Ruby to $PATH
=====================================================
The Chef Client includes a stable version of Ruby as part of its installer. The path to this version of Ruby must be added to the ``$PATH`` environment variable and saved in the configuration file for the command shell (Bash, csh, and so on) that is used on the machine running the ChefDK. In a command window, type the following:

.. code-block:: bash

   echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.configuration_file && source ~/.configuration_file

where ``configuration_file`` is the name of the configuration file for the specific command shell. For example, if Bash were the command shell and the configuration file were named ``bash_profile``, the command would look something like the following:

.. code-block:: bash

   echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

.. warning:: On Microsoft Windows, ``C:/opscode/chefdk/bin`` must be before ``C:/opscode/chefdk/embedded/bin`` in the ``PATH``.

Install Git
=====================================================
An open source distributed version control system called Git must be installed before the chef-repo can be cloned to the ChefDK machine from GitHub.

To install Git:

#. Go to the following URL: https://help.github.com/articles/set-up-git.

#. Follow the directions, install Git (http://git-scm.com/downloads), and then complete the remaining configuration steps on that page.

.. note:: It is not necessary to create or fork a repository in order to clone the chef-repo from GitHub.


Create the Chef repository
=====================================================
There are two ways to create the chef-repo:

* Use the starter kit built into the Chef server web user interface
* Manually, by using the ``chef generate app`` subcommand in the chef command-line tool that is packaged in the Chef development kit

Manual
-----------------------------------------------------

Create the Chef Repo
+++++++++++++++++++++++++++++++++++++++++++++++++++++

Use `the chef generate app </ctl_chef.html#chef-generate-app>`__ to create the Chef repository. For example, to create a repository called ``chef-repo``:

.. code-block:: ruby

   chef generate app chef-repo

Create .chef Directory
+++++++++++++++++++++++++++++++++++++++++++++++++++++

.. tag install_chef_client_repo_manual_chef_directory

The ``.chef`` directory is used to store three files:

* ``knife.rb``
* ``ORGANIZATION-validator.pem``
* ``USER.pem``

Where ``ORGANIZATION`` and ``USER`` represent strings that are unique to each organization. These files must be present in the ``.chef`` directory in order for the ChefDK to be able to connect to a Chef server.

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

.. end_tag

Starter Kit
-----------------------------------------------------
If you have access to Chef server (hosted or on premises), you can download the starter kit. The starter kit will create the necessary configuration files: the ``.chef`` directory, ``knife.rb``, ``ORGANIZATION-validator.pem``, and ``USER.pem``. Simply download the starter kit and then move it to the desired location on your ChefDK machine.

Configure the Chef Repository
=====================================================

With WebUI
-----------------------------------------------------
Use the following steps to manually set up the chef-repo and to use the Chef management console to get the ``.pem`` and ``knife.rb`` files.

Get Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++

For a ChefDK installation that will interact with the Chef server (including the hosted Chef server), log on and download the following files:

* ``knife.rb``. This configuration file can be downloaded from the **Organizations** page.
* ``ORGANIZATION-validator.pem``. This private key can be downloaded from the **Organizations** page.
* ``USER.pem``. This private key can be downloaded from the **Change Password** section of the **Account Management** page.

Move Config Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The ``knife.rb``, ``ORGANIZATION-validator.pem``, and ``USER.pem`` files must be moved to the ``.chef`` directory after they are downloaded from the Chef server.

To move files to the ``.chef`` directory:

#. In a command window, enter each of the following:

   .. code-block:: bash

      cp /path/to/knife.rb ~/chef-repo/.chef

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
Use the following steps to manually set up the Chef repository, create the ``ORGANIZATION-validator.pem`` and ``USER.pem`` files with the ``chef-server-ctl`` command line tool, and then create the ``knife.rb`` file.

Create an Organization
+++++++++++++++++++++++++++++++++++++++++++++++++++++

On the Chef server machine create the ``ORGANIZATION-validator.pem`` from the command line using ``chef-server-ctl``. Run the following command:

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

On the Chef server machine create the ``USER.pem`` from the command line using ``chef-server-ctl``. Run the following command:

.. code-block:: bash

   $ chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL PASSWORD -f FILE_NAME

where

* ``-f FILE_NAME`` writes the ``USER.pem`` to a file instead of ``STDOUT``. For example: ``/tmp/grantmc.key``.

For example: a user named ``grantmc``, with a first and last name of ``Grant McLennan``, an email address of ``grantmc@chef.io``, a poorly-chosen password, and a ``USER.pem`` file saved to ``/tmp/grantmc.key``:

.. code-block:: bash

   $ chef-server-ctl user-create grantmc Grant McLennan grantmc@chef.io p@s5w0rD! -f /tmp/grantmc.key

Move .pem Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The ``ORGANIZATION-validator.pem`` and ``USER.pem`` files must be moved to the ``.chef`` directory after they are downloaded from the Chef server.

To move files to the .chef directory:

#. In a command window, enter each of the following:

   .. code-block:: bash

      cp /path/to/ORGANIZATION-validator.pem ~/chef-repo/.chef

   and:

   .. code-block:: bash

      cp /path/to/USERNAME.pem ~/chef-repo/.chef

   where ``/path/to/`` represents the path to the location in which these three files were placed after they were downloaded.

#. Verify that the files are in the ``.chef`` folder.

Create the knife.rb File
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The ``knife.rb`` file must be created in the ``.chef`` folder. It should look similar to:

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

* ``client_key`` should point to the location of the Chef server user's ``.pem`` file on your ChefDK machine.
* ``validation_client_name`` should be updated with the name of the desired organization that was created on the Chef server.
* ``validation_key`` should point to the location of your organization's ``.pem`` file on your ChefDK machine.
* ``chef_server_url`` must be updated with the domain or IP address used to access the Chef server.

See the `knife documentation </config_rb_knife.html>`__ for more details.

Get SSL Certificates
=====================================================
Chef server 12 enables SSL verification by default for all requests made to the server, such as those made by knife and the chef-client. The certificate that is generated during the installation of the Chef server is self-signed, which means there isn't a signing certificate authority (CA) to verify. In addition, this certificate must be downloaded to any machine from which knife and/or the chef-client will make requests to the Chef server.

Use the ``knife ssl fetch`` subcommand to pull the SSL certificate down from the Chef server:

.. code-block:: bash

   knife ssl fetch

See `SSL Certificates </chef_client_security.html#ssl-certificates>`__ for more information about how knife and the chef-client use SSL certificates generated by the Chef server.

Verify Install
=====================================================
The ChefDK is installed correctly when it is able to use ``knife`` to communicate with the Chef server.

To verify that the ChefDK can connect to the Chef server:

#. In a command window, navigate to the Chef repository:

   .. code-block:: bash

      cd ~/chef-repo

#. In a command window, enter the following:

   .. code-block:: bash

      knife client list

   to return a list of clients (registered nodes and ChefDK installations) that have access to the Chef server. For example:

   .. code-block:: bash

      chefdk_machine
      registered_node
