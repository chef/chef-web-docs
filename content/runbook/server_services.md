+++
title = "Services"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/server_services.html"]

runbook_weight = 40

[menu]
  [menu.infra]
    title = "Services"
    identifier = "chef_infra/managing_chef_infra_server/server_services.md Services"
    parent = "chef_infra/managing_chef_infra_server"
    weight = 100
+++

The Chef Infra Server has a built in process supervisor, which ensures
that all of the required services are in the appropriate state at any
given time. The supervisor starts two processes per service.

## Service Subcommands

{{% ctl_common_service_subcommands %}}

### hup

{{% ctl_chef_server_hup %}}

### int

{{% ctl_chef_server_int %}}

### kill

{{% ctl_chef_server_kill %}}

### once

{{% ctl_chef_server_once %}}

### restart

{{% ctl_chef_server_restart %}}

### service-list

{{% ctl_chef_server_service_list %}}

### start

{{% ctl_chef_server_start %}}

### status

{{% ctl_chef_server_status %}}

#### Log Files

{{% ctl_chef_server_status_logs %}}

### stop

{{% ctl_chef_server_stop %}}

### tail

{{% ctl_chef_server_tail %}}

### term

{{% ctl_chef_server_term %}}

## List of Services

The following services are part of the Chef Infra Server:

-   bifrost
-   bookshelf
-   elasticsearch
-   nginx
-   opscode-erchef
-   postgresql
-   redis-lb

### bifrost

{{% server_services_bifrost %}}

#### status

To view the status for the service:

```bash
chef-server-ctl status bifrost
```

to return something like:

```bash
run: bifrost: (pid 1234) 123456s; run: log: (pid 5678) 789012s
```

#### start

To start the service:

```bash
chef-server-ctl start bifrost
```

#### stop

To stop the service:

```bash
chef-server-ctl stop bifrost
```

#### restart

To restart the service:

```bash
chef-server-ctl restart bifrost
```

to return something like:

```bash
ok: run: bifrost: (pid 1234) 1234s
```

#### kill

To kill the service (send a `SIGKILL` command):

```bash
chef-server-ctl kill bifrost
```

#### run once

To run the service, but not restart it (if the service fails):

```bash
chef-server-ctl once bifrost
```

#### tail

To follow the logs for the service:

```bash
chef-server-ctl tail bifrost
```

### bookshelf

{{% server_services_bookshelf %}}

#### status

To view the status for the service:

```bash
chef-server-ctl status bookshelf
```

to return something like:

```bash
run: bookshelf: (pid 1234) 123456s; run: log: (pid 5678) 789012s
```

#### start

To start the service:

```bash
chef-server-ctl start bookshelf
```

#### stop

To stop the service:

```bash
chef-server-ctl stop bookshelf
```

#### restart

To restart the service:

```bash
chef-server-ctl restart bookshelf
```

to return something like:

```bash
ok: run: bookshelf: (pid 1234) 1234s
```

#### kill

To kill the service (send a `SIGKILL` command):

```bash
chef-server-ctl kill bookshelf
```

#### run once

To run the service, but not restart it (if the service fails):

```bash
chef-server-ctl once bookshelf
```

#### tail

To follow the logs for the service:

```bash
chef-server-ctl tail bookshelf
```

### Elasticsearch

#### status

To view the status for the service:

```bash
chef-server-ctl status elasticsearch
```

to return something like:

```bash
elasticsearch: (pid 12345) 1s; run: log: (pid 5678) 123456s
```

#### start

To start the service:

```bash
chef-server-ctl start elasticsearch
```

to return something like:

```bash
ok: run: elasticsearch: (pid 5678) 0s
```

#### stop

To stop the service:

```bash
chef-server-ctl stop elasticsearch
```

to return something like:

```bash
ok: down: elasticsearch: 123456s, normally up
```

#### restart

To restart the service:

```bash
chef-server-ctl restart elasticsearch
```

to return something like:

```bash
ok: run: elasticsearch: (pid 56789) 1s
```

#### kill

To kill the service (send a `SIGKILL` command):

```bash
chef-server-ctl kill elasticsearch
```

#### run once

```bash
chef-server-ctl once elasticsearch
```

#### tail

To follow the logs for the service:

```bash
chef-server-ctl tail elasticsearch
```

### nginx

{{% server_services_nginx %}}

#### status

To view the status for the service:

```bash
chef-server-ctl status nginx
```

to return something like:

```bash
run: nginx: (pid 1234) 123456s; run: log: (pid 5678) 789012s
```

#### start

To start the service:

```bash
chef-server-ctl start nginx
```

#### stop

To stop the service:

```bash
chef-server-ctl stop nginx
```

#### restart

To restart the service:

```bash
chef-server-ctl restart nginx
```

to return something like:

```bash
ok: run: nginx: (pid 1234) 1234s
```

#### kill

To kill the service (send a `SIGKILL` command):

```bash
chef-server-ctl kill nginx
```

#### run once

To run the service, but not restart it (if the service fails):

```bash
chef-server-ctl once nginx
```

#### tail

{{% server_services_nginx_tail %}}

### opscode-erchef

{{% server_services_erchef %}}

#### status

To view the status for the service:

```bash
chef-server-ctl status opscode-erchef
```

to return something like:

```bash
run: opscode-erchefs: (pid 1234) 123456s; run: log: (pid 5678) 789012s
```

#### start

To start the service:

```bash
chef-server-ctl start opscode-erchef
```

#### stop

To stop the service:

```bash
chef-server-ctl stop opscode-erchef
```

#### restart

To restart the service:

```bash
chef-server-ctl restart opscode-erchef
```

to return something like:

```bash
ok: run: opscode-erchef: (pid 1234) 1234s
```

#### kill

To kill the service (send a `SIGKILL` command):

```bash
chef-server-ctl kill opscode-erchef
```

#### run once

To run the service, but not restart it (if the service fails):

```bash
chef-server-ctl once opscode-erchef
```

#### tail

To follow the logs for the service:

```bash
chef-server-ctl tail opscode-erchef
```

### postgresql

{{% server_services_postgresql %}}

#### status

To view the status for the service:

```bash
chef-server-ctl status postgresql
```

to return something like:

```bash
run: postgresql: (pid 1234) 123456s; run: log: (pid 5678) 789012s
```

#### start

To start the service:

```bash
chef-server-ctl start postgresql
```

#### stop

To stop the service:

```bash
chef-server-ctl stop postgresql
```

#### restart

To restart the service:

```bash
chef-server-ctl restart postgresql
```

to return something like:

```bash
ok: run: postgresql: (pid 1234) 1234s
```

#### kill

To kill the service (send a `SIGKILL` command):

```bash
chef-server-ctl kill postgresql
```

#### run once

To run the service, but not restart it (if the service fails):

```bash
chef-server-ctl once postgresqls
```

#### tail

To follow the logs for the service:

```bash
chef-server-ctl tail postgresql
```

### redis

{{% server_services_redis %}}

#### status

To view the status for the service:

```bash
chef-server-ctl status redis
```

to return something like:

```bash
run: redis: (pid 1234) 123456s; run: log: (pid 5678) 789012s
```

#### start

To start the service:

```bash
chef-server-ctl start redis
```

#### stop

To stop the service:

```bash
chef-server-ctl stop redis
```

#### restart

To restart the service:

```bash
chef-server-ctl restart redis
```

to return something like:

```bash
ok: run: redis: (pid 1234) 1234s
```

#### kill

To kill the service (send a `SIGKILL` command):

```bash
chef-server-ctl kill name_of_service
```

#### run once

To run the service, but not restart it (if the service fails):

```bash
chef-server-ctl once redis
```

#### tail

To follow the logs for the service:

```bash
chef-server-ctl tail name_of_service
```
