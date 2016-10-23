.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
Services
=====================================================

.. include:: ../../includes_server_services/includes_server_services.rst

Service Subcommands
=====================================================
.. include:: ../../includes_ctl_common/includes_ctl_common_service_subcommands.rst

hup
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_hup.rst

int
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_int.rst

kill
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_kill.rst

once
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_once.rst

restart
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_restart.rst

service-list
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_service_list.rst

start
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_start.rst

status
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_status.rst

High Availability
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_status_ha.rst

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_status_logs.rst

stop
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_stop.rst

tail
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_tail.rst

term
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_term.rst


List of Services
=====================================================
The following services are part of Enterprise Chef:

* bifrost
* bookshelf
* couchdb
* keepalived
* nginx
* opscode-account
* opscode-certificate
* opscode-erchef
* opscode-expander
* opscode-expander-reindexer
* opscode-org-creator
* opscode-solr
* opscode-webui
* postgresql
* rabbitmq
* redis

All services have the following options: ``status``, ``start``, ``stop``, ``restart``, ``kill``, ``run once``, and ``tail``.

bifrost
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_bifrost.rst

bookshelf
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_bookshelf.rst

couchdb
-----------------------------------------------------
The **couchdb** service is used to store key/value data.

keepalived
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_keepalived.rst

nginx
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_nginx.rst

opscode-account
-----------------------------------------------------
The **opscode-account** service is a Ruby-based service that handles the following types of Chef server API requests:

* ACLs
* Association requests
* Containers
* Groups
* Organizations
* Clients
* Users

.. note:: This service is deprecated in Chef server 12.

opscode-certificate
-----------------------------------------------------
The **opscode-certificate** service is used to provide the certificates that are returned when the chef-client is set up and configured on nodes and workstations.

.. note:: This service is deprecated in Chef server 12.

opscode-erchef
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_erchef.rst

opscode-expander
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_expander.rst

opscode-expander-reindexer
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_reindexer.rst

opscode-solr
-----------------------------------------------------
The **opscode-solr** service is used to create the search indexes.

opscode-webui
-----------------------------------------------------
The **opscode-webui** service is used to mange the web user interface for the Chef server.

postgresql
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_postgresql.rst

rabbitmq
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_rabbitmq.rst

redis
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_redis.rst
