
delivery-ctl (executable)
*************************

The Chef Delivery server includes a command-line utility named
delivery-ctl. Use this command-line tool to:

* Manage enterprises, users, and projects

* Reconfigure the Chef Delivery server

* Start and stop individual services

* Tail Chef Delivery server log files

Note: All commands must be run as ``sudo``.


cleanse
=======

The ``cleanse`` subcommand is used to re-set the Chef Delivery server
to the state it was in prior to the first time the ``reconfigure``
subcommand is run. This command will:

* Destroy all data and logs

* Create a backup of the system config files and place them in a
  directory in root, such as
  ``/root/delivery-cleanse-2015-12-15T15:51``

The software that was put on-disk by the package installation will
remain. Re-run ``delivery-ctl reconfigure`` to recreate the default
data and configuration files.

This subcommand has the following syntax:

::

   $ delivery-ctl cleanse


create-enterprise
=================

The ``create-enterprise`` subcommand is used to create a Chef Delivery
enterprise. A public key is required.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl create-enterprise ENT_NAME --ssh-pub-key-file=FILE_NAME

Note: The ``ENT_NAME`` value must be alphanumeric.


create-user
===========

The ``create-user`` subcommand is used to create a user. (The
validation key for the organization may be returned to ``STDOUT`` when
creating a user with this command.)

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl create-user ENT_NAME USER_NAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL PASSWORD SSH_PUBLIC_KEY

**Example**

::

   $ delivery-ctl create-user john_smith


create-user
===========

The ``create-user`` subcommand is used to create a user. (The
validation key for the organization may be returned to ``STDOUT`` when
creating a user with this command.)

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl create-user ENT_NAME USER_NAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL PASSWORD SSH_PUBLIC_KEY

**Example**

::

   $ delivery-ctl create-users delivery_eng.tsv


delete-enterprise
=================

The ``delete-enterprise`` subcommand is used to delete a Chef Delivery
enterprise.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl delete-enterprise ENT_NAME

**Example**

::

   $ delviery-ctl delete-enterprise pedant-testing-org


delete-project
==============

The ``delete-project`` subcommand is used to delete a Chef Delivery
project.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl delete-project ENT_NAME ORG_NAME PROJECT_NAME


delete-user
===========

The ``delete-user`` subcommand is used to delete a user.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl delete-user ENT_NAME USER_NAME

**Example**

::

   $ delivery-ctl delete-user john_smith


help
====

The ``help`` subcommand is used to print a list of all available
``delivery-ctl`` commands.

This subcommand has the following syntax:

::

   $ delivery-ctl help


list-enterprises
================

The ``list-enterprises`` subcommand is used to list all of the
enterprises currently present on the Chef Delivery server.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl list-enterprises


list-users
==========

The ``list-users`` subcommand is used to view a list of users.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl list-users ENT_NAME


migrate-change-description
==========================

The ``migrate-change-description`` subcommand is used to migrate the
change description LIVE RUN.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl migrate-change-description ENT_NAME ORG_NAME PROJECT_NAME CHANGE


migrate-change-description-dry-run
==================================

The ``migrate-change-description-dry-run`` subcommand is used to
execute a DRY RUN migration of the change description.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl migrate-change-description-dry-run ENT_NAME ORG_NAME PROJECT_NAME CHANGE


migrate-patchset-diffs
======================

The ``migrate-patchset-diffs`` subcommand is used to update patchset
diffs to include numstat.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl migrate-patchset-diffs ENT_NAME ORG_NAME PROJECT_NAME PATCHSET_DIFF


migrate-patchset-diffs-dry-run
==============================

The ``migrate-patchset-diffs-dry-run`` subcommand is used to execute a
DRY RUN update of patchset diffs to include numstat.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl migrate-patchset-diffs-dry-run ENT_NAME ORG_NAME PROJECT_NAME PATCHSET_DIFF


reconfigure
===========

The ``reconfigure`` subcommand is used to reconfigure the Chef
Delivery server after changes are made to the delivery configuration
file, located at ``/etc/delivery/delivery.rb``. When changes are made
to the delivery configuration file, they are not applied to the Chef
Delivery configuration until after this command is run. This
subcommand also restarts any services for which the
``service_name['enabled']`` setting is set to ``true``.

This subcommand has the following syntax:

::

   $ delivery-ctl reconfigure


rename-enterprise
=================

The ``rename-enterprise`` subcommand is used to rename an existing
Chef Delivery enterprise.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl rename-enterprise CURRENT_ENT_NAME NEW_ENT_NAME


revoke-token
============

The ``revoke-token`` subcommand is used to revoke a user's token.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl revoke-token ENT_NAME USER_NAME


show-config
===========

The ``show-config`` subcommand is used to view the configuration that
will be generated by the ``reconfigure`` subcommand. This command is
most useful in the early stages of a deployment to ensure that
everything is built properly prior to installation.

This subcommand has the following syntax:

::

   $ delivery-ctl show-config


uninstall
=========

The ``uninstall`` subcommand is used to remove the Chef Delivery
application, but without removing any of the data. This subcommand
will shut down all services (including the ``runit`` process
supervisor).

This subcommand has the following syntax:

::

   $ delivery-ctl uninstall

Note: To revert the ``uninstall`` subcommand, run the ``reconfigure``
  subcommand (because the ``start`` subcommand is disabled by the
  ``uninstall`` command).


update-project-hooks
====================

The ``update-project-hooks`` subcommand is used to update git hooks
for all projects.

**Syntax**

This subcommand has the following syntax:

::

   $ delivery-ctl update-project-hooks ENT_NAME ORG_NAME PROJECT_NAME


Service Subcommands
===================

The Chef Delivery server has a built in process supervisor, which
ensures that all of the required services are in the appropriate state
at any given time. The supervisor starts two processes per service.


graceful-kill
-------------

The ``kill`` subcommand is used to send a ``SIGKILL`` to all services.
This command can also be run for an individual service by specifying
the name of the service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl kill name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.


hup
---

The ``hup`` subcommand is used to send a ``SIGHUP`` to all services.
This command can also be run for an individual service by specifying
the name of the service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl hup name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.


int
---

The ``int`` subcommand is used to send a ``SIGINT`` to all services.
This command can also be run for an individual service by specifying
the name of the service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl int name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.


kill
----

The ``kill`` subcommand is used to send a ``SIGKILL`` to all services.
This command can also be run for an individual service by specifying
the name of the service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl kill name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.


once
----

The supervisor for the Chef Delivery server is configured to restart
any service that fails, unless that service has been asked to change
its state. The ``once`` subcommand is used to tell the supervisor to
not attempt to restart any service that fails.

This command is useful when troubleshooting configuration errors that
prevent a service from starting. Run the ``once`` subcommand followed
by the ``status`` subcommand to look for services in a down state
and/or to identify which services are in trouble. This command can
also be run for an individual service by specifying the name of the
service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl once name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.


restart
-------

The ``restart`` subcommand is used to restart all services enabled on
the Chef Delivery server or to restart an individual service by
specifying the name of that service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl restart name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand. When a service
is successfully restarted the output should be similar to:

::

   $ ok: run: service_name: (pid 12345) 1s


service-list
------------

The ``service-list`` subcommand is used to display a list of all
available services. A service that is enabled is labeled with an
asterisk (*).

This subcommand has the following syntax:

::

   $ delivery-ctl service-list


start
-----

The ``start`` subcommand is used to start all services that are
enabled in the Chef Delivery server. This command can also be run for
an individual service by specifying the name of the service in the
command.

This subcommand has the following syntax:

::

   $ delivery-ctl start name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand. When a service
is successfully started the output should be similar to:

::

   $ ok: run: service_name: (pid 12345) 1s

The supervisor for the Chef Delivery server is configured to wait
seven seconds for a service to respond to a command from the
supervisor. If you see output that references a timeout, it means that
a signal has been sent to the process, but that the process has yet to
actually comply. In general, processes that have timed out are not a
big concern, unless they are failing to respond to the signals at all.
If a process is not responding, use a command like the ``kill``
subcommand to stop the process, investigate the cause (if required),
and then use the ``start`` subcommand to re-enable it.


status
------

The ``status`` subcommand is used to show the status of all services
available to the Chef Delivery server. The results will vary based on
the configuration of a given server. This subcommand has the following
syntax:

::

   $ delivery-ctl status

and will return the status for all services. Status can be returned
for individual services by specifying the name of the service as part
of the command:

::

   $ delivery-ctl status name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.

When service status is requested, the output should be similar to:

::

   $ run: service_name: (pid 12345) 12345s; run: log: (pid 1234) 67890s

where

* ``run:`` is the state of the service (``run:`` or ``down:``)

* ``service_name:`` is the name of the service for which status is
  returned

* ``(pid 12345)`` is the process identifier

* ``12345s`` is the uptime of the service, in seconds

For example:

::

   $ down: opscode-erchef: (pid 35546) 10s

By default, runit will restart services automatically when the
services fail. Therefore, runit may report the status of a service as
``run:`` even when there is an issue with that service. When
investigating why a particular service is not running as it should be,
look for the services with the shortest uptimes. For example, the list
below indicates that the **opscode-erchef** should be investigated
further:

::

   run: oc-id
   run: opscode-chef: (pid 4327) 13671s; run: log: (pid 4326) 13671s
   run: opscode-erchef: (pid 5383) 5s; run: log: (pid 4382) 13669s
   run: opscode-expander: (pid 4078) 13694s; run: log: (pid 4077) 13694s
   run: opscode-expander-reindexer: (pid 4130) 13692s; run: log: (pid 4114) 13692s


Log Files
~~~~~~~~~

A typical status line for a service that is running any of the Chef
Delivery server front-end services is similar to the following:

::

   run: name_of_service: (pid 1486) 7819s; run: log: (pid 1485) 7819s

where:

* ``run`` describes the state in which the supervisor attempts to keep
  processes. This state is either ``run`` or ``down``. If a service is
  in a ``down`` state, it should be stopped

* ``name_of_service`` is the service name, for example:
  ``opscode-solr4``

* ``(pid 1486) 7819s;`` is the process identifier followed by the
  amount of time (in seconds) the service has been running

* ``run: log: (pid 1485) 7819s`` is the log process. It is typical for
  a log process to have a longer run time than a service; this is
  because the supervisor does not need to restart the log process in
  order to connect the supervised process

If the service is down, the status line will appear similar to the
following:

::

   down: opscode-solr4: 3s, normally up; run: log: (pid 1485) 8526s

where

* ``down`` indicates that the service is in a down state

* ``3s, normally up;`` indicates that the service is normally in a run
  state and that the supervisor would attempt to restart this service
  after a reboot


stop
----

The ``stop`` subcommand is used to stop all services enabled on the
Chef Delivery server. This command can also be run for an individual
service by specifying the name of the service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl stop name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand. When a service
is successfully stopped the output should be similar to:

::

   $ ok: diwb: service_name: 0s, normally up

For example:

::

   $ delivery-ctl stop

will return something similar to:

::

   ok: down: nginx: 393s, normally up
   ok: down: opscode-chef: 391s, normally up
   ok: down: opscode-erchef: 391s, normally up
   ok: down: opscode-expander: 390s, normally up
   ok: down: opscode-expander-reindexer: 389s, normally up
   ok: down: opscode-solr4: 389s, normally up
   ok: down: postgresql: 388s, normally up
   ok: down: rabbitmq: 388s, normally up
   ok: down: redis_lb: 387s, normally up


tail
----

The ``tail`` subcommand is used to follow all of the Chef Delivery
server logs for all services. This command can also be run for an
individual service by specifying the name of the service in the
command.

This subcommand has the following syntax:

::

   $ delivery-ctl tail name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.


term
----

The ``term`` subcommand is used to send a ``SIGTERM`` to all services.
This command can also be run for an individual service by specifying
the name of the service in the command.

This subcommand has the following syntax:

::

   $ delivery-ctl term name_of_service

where ``name_of_service`` represents the name of any service that is
listed after running the ``service-list`` subcommand.


usr1
----

The ``usr1`` subcommand is used to send the services a USR1.


usr2
----

The ``usr2`` subcommand is used to send the services a USR2.
