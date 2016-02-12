.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

If there isn't much concern about people being able to view a private key, add it to ``cookbook/COOKBOOK_NAME/files/default/id_deploy`` and add it to the |ssh| file locally on the node using the |resource cookbook_file| resource.

To add a private key to a node:

.. code-block:: ruby

   cookbook_file '/tmp/private_code/.ssh/id_deploy' do
     source 'id_deploy'
     owner 'ubuntu'
     mode '0755'
   end


