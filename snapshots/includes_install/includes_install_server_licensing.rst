When using more than 25 nodes, a configuration change to your Chef server needs to be made in order for your Chef server to be properly configured and recognize your purchased licenses. You will need to edit to your ``chef-server.rb`` file by following the process below:

#. On your Chef server, if the ``chef-server.rb`` file does not exist, create it.

   .. code-block:: bash

      sudo mkdir /etc/opscode && sudo touch /etc/opscode/chef-server.rb


#. Open up the newly created ``chef-server.rb`` file in your favorite text editor.

   .. code-block:: bash

      sudo vi /etc/opscode/chef-server.rb

#. Paste or add the following text. Please note the placement of the single quotation (') marks.

   .. code-block:: bash

      license['nodes'] = N where N is the number of licensed nodes you have purchased


#. Save the file. Because we are using the vi editor, you can save your changes in vi with the following command:

.. code-block:: bash

   :wq

#. Run ``chef-server-ctl reconfigure`` for the changes to be picked up by your Chef server.

   .. code-block:: bash

      sudo chef-server-ctl reconfigure

For more information on configuring your Chef server, see :doc:`chef-server.rb Settings </config_rb_server>` and :doc:`chef-server.rb Optional Settings </config_rb_server_optional_settings>`.
