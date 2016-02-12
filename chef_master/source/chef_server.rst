=====================================================
|chef server_title| Components
=====================================================

.. include:: ../../includes_chef_server/includes_chef_server.rst

.. include:: ../../includes_chef_server/includes_chef_server_component_erchef_background.rst

The following diagram shows the various components that are part of a |chef server| deployment and how they relate to one another.

.. image:: ../../images/server_components.svg
   :width: 500px

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Clients
     - The |chef server| is accessed primarily by nodes that are under management by |chef|, as the |chef client| runs occur. It is also accessed by individuals who maintain cookbooks and policy that is stored on the |chef server|, typically from a workstation. And also by individual users with credentials to |chef server| components, such as the |chef manage|.
   * - Load Balancer
     - .. include:: ../../includes_chef_server/includes_chef_server_component_nginx.rst
   * - |chef manage_title|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_webui.rst

       The |chef manage| uses the |api chef server| for all communication to the |chef server|.
   * - |chef server_title|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_erchef.rst
   * - |chef bookshelf|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_bookshelf.rst

       All cookbooks are stored in a dedicated repository.
   * - Message Queues
     - Messages are sent to the search index using the following components:
       
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_rabbitmq.rst
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_expander.rst
          #. .. include:: ../../includes_chef_server/includes_chef_server_component_solr.rst

       All messages are added to a dedicated search index repository.
   * - |postgresql|
     - .. include:: ../../includes_chef_server/includes_chef_server_component_postgresql.rst


External Cookbooks
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_external_cookbooks_aws.rst

|amazon aws| Settings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_ha/includes_server_ha_external_cookbooks_aws_settings.rst


.. DO NOT CHANGE THE FOLLOWING TITLE BECAUSE IT IS LINKED FROM THE ERROR MESSAGES IN THE CODE FOR THESE SETTINGS.

External |postgresql|
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql.rst

.. DO NOT CHANGE THE FOLLOWING TITLE BECAUSE IT IS LINKED FROM THE ERROR MESSAGES IN THE CODE FOR THESE SETTINGS.

|postgresql| Settings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql_settings.rst

.. note:: See the list of `error messages that may be present <https://docs.chef.io/error_messages.html#external-postgresql>`_ when configuring the |chef server| to use a remote |postgresql| server.
