.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Driver-specific configuration settings may be required. Use the following block in the |kitchen yml| file:

.. code-block:: yaml

   driver: 
     name: driver_name
     driver_config:
       key: value

where ``driver_config`` is a collection of settings required by the driver plugins listed in the |kitchen yml| file; specific ``key: value`` pairs will vary, depending on which drivers, provisioners, and platforms are being used. For example:

.. code-block:: yaml

   driver_config:
     digitalocean_client_id: <%= ENV['DIGITAL_OCEAN_CLIENT_ID'] %>
     digitalocean_api_key: <%= ENV['DIGITAL_OCEAN_API_KEY'] %>
     aws_access_key_id: <%= ENV['AWS_ACCESS_KEY_ID'] %>
     aws_secret_access_key: <%= ENV['AWS_SECRET_ACCESS_KEY'] %>
     aws_ssh_key_id: <%= ENV['AWS_KEYPAIR_NAME'] %>

and then within each ``platforms`` definition, additional settings may be necessary to ensure that specific platform can build the instance:

.. code-block:: yaml

   platforms:
   - name: centos-5.8
     driver_plugin: digitalocean
     driver_config:
       image_id: 1601
       flavor_id: 63
       region_id: 4
       ssh_key_ids: <%= ENV['DIGITAL_OCEAN_SSH_KEY_IDS'] %>
       ssh_key: <%= ENV['DIGITAL_OCEAN_SSH_KEY_PATH'] %>
