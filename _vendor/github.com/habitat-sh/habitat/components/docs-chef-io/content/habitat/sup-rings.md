+++
title = "Setting Up a Ring"
description = "Setting Up a Ring"

[menu]
  [menu.habitat]
    title = "Setting Up a Ring"
    identifier = "habitat/supervisors/sup-rings"
    parent = "habitat/supervisors"
+++

## Bastion Ring / Permanent Peers

A "Bastion Ring" is a pattern for preventing rumor loss and a split brain in a network of Chef Habitat Supervisors - it is highly recommended for any real environment use case. Create a minimum of 3 Supervisors and join them together. They should not run any services and they should be marked as permanent peers - their only job is to spread rumors to each other. Then, when you provision additional Supervisors pass the network address of each Supervisor running in the Bastion Ring to the `--peer` argument of `hab sup run`. It's recommended to create a Bastion Ring in any network zones which may become partitioned due to a hardware failure. For example, if you have a Chef Habitat ring spanning multiple data centers and clouds, each should have a bastion ring of a minimum of 3 Supervisors in addition to the Supervisors running your services.

## Using a Scheduler

Please note, if you are using a container scheduler such as Kubernetes, Swarm, or Mesos DC/OS, or a PaaS such as CloudFoundry, you should not follow the bastion ring pattern, as the scheduler handles that level of persistence and orchestration on your behalf.

For Kubernetes, you should use the Chef Habitat Operator for Kubernetes to ensure that the application behavior you've established for your services when you defined them with Chef Habitat is run in a Kubernetes-native way to ensure consistent and expected behavior cross-platform.

More resources on schedulers:

- <https://www.habitat.sh/get-started/kubernetes/>
- <https://www.habitat.sh/docs/best-practices/#container-orchestration>
- <https://www.habitat.sh/get-started/cloudfoundry/>

## Initial Peer(s)

The initial peer(s) is a requirement of any distributed system. In Chef Habitat, a new Supervisor that is starting up looks for an initial peer(s) to join to begin sharing information about the health and status of peers and other services, to increase the health of the overall Ring.
