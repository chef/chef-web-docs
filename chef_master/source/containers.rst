=====================================================
|chef| for Containers
=====================================================

.. include:: ../../includes_containers/includes_containers.rst

|chef| can manage a containers in a number of ways. This page is a quick summary of the tools and resources that are available. Some of these tools are developed and maintained by |company_name| itself and some are developed and maintained by the |chef| community.

Base Containers
=====================================================
The following cookbooks are available to help manage base containers:

* Use the `docker cookbook <https://supermarket.chef.io/cookbooks/docker>`__ to install and manage |docker|, as well as use resources for managing |docker| images, |docker| containers, and the |docker| registry
* Use the `lxc cookbook <https://supermarket.chef.io/cookbooks/lxc>`__ to install and manage |linux lxc|-based |linux| containers
* Use the `zone cookbook <https://supermarket.chef.io/cookbooks/zone>`__ to manage |solaris| zones, which are partitioned operating system-level virtual environments that are unique to the |solaris| platform and are often referred to as "Solaris Containers"

Service Discovery
=====================================================
The following cookbooks are available to help manage service discovery:

* Use the `chef-etcd cookbook <https://github.com/ranjib/chef-etcd>`__ to read and write keys/values in ``etcd``, as well as saving |chef client| run data within ``etcd``; use the `etcd cookbook <https://supermarket.chef.io/cookbooks/etcd>`__ cookbook to set up ``etcd``
* Use the `consul cookbook <https://supermarket.chef.io/cookbooks/consul>`__ to set up the |consul| client, server, and user interface
* Use the `serf cookbook <https://supermarket.chef.io/cookbooks/serf>`__ to set up and manage |serf|
* Use the `zookeeper cookbook <https://supermarket.chef.io/cookbooks/zookeeper>`__ to set up and manage |zookeeper|, which also provides an interface for modifying the |zookeeper| cluster configuration

Schedule and Resources
=====================================================
The following cookbooks are available to help manage schedule and resource allocation:

* Use the `mesos cookbook <https://supermarket.chef.io/cookbooks/mesos>`__ to set up and manage the |apache mesos| framework
* Use the `marathon cookbook <https://github.com/mdsol/marathon_cookbook>`__ to set up and manage |apache mesos_marathon|, framework for long-running services that runs on |apache mesos|
* Use the `chronos cookbook <https://github.com/mdsol/chronos_cookbook>`__ to set up and manage |chronos|, a fault-tolerant job scheduler that handles dependencies and iso8601-based schedules and runs on |apache mesos|
* Use the `kubernetes cookbook <https://github.com/chenzhiwei/kubernetes-cookbook>`__ to set up and manage |kubernetes| on |redhat| and |centos| 7.x
* Use the `k8s cookbook <https://supermarket.chef.io/cookbooks/k8s>`__ to deploy |kubernetes| entities, such as pods, replication controllers, and services

Build Container Images
=====================================================
Use `Packer <http://packer.io>`__ to build any infrastructure image type with the |chef client| or |chef solo| as the provisioner. This enables the use of |chef| to declaratively state what an infrastructure image should be, and then use |chef| to easily manage lightweight immutable infrastructure images. |packer| has support for |docker| as a build target and can push images to the |docker| registry as a post-processor. 


Provisioning
=====================================================
|chef provisioning|, a collection of resources and drivers that is maintained by |company_name| includes a driver for |docker|.

* Use the `machine and machine-based resources <https://docs.chef.io/devkit/#chef-provisioning-title>`__ to build and define recipes that manage |docker| images
* Use the `docker driver <https://github.com/chef/chef-provisioning-docker>`__ to tell the |chef client| how to build and define the |docker| image itself


Infrastructure Testing
=====================================================
|kitchen|---the infrastructure testing system for |chef|---may be configured to use containers by using the following drivers:

* For |docker|, use the `kitchen-docker <https://github.com/portertech/kitchen-docker>`__ driver
* For |linux lxc| containers, use the `kitchen-lxc <https://github.com/chrisroberts/kitchen-lxc>`__ driver


APIs
=====================================================
Use the  `docker-api <https://github.com/swipely/docker-api>`__ gem to interact programmatically with the |docker| API from within |chef| recipes. |company_name| is a contributor.


For more information ...
=====================================================
For more information about managing a containerized infrastructure:

* Cooking Up Drama - ChefConf 2015: https://www.youtube.com/watch?v=8fcDZB-QMRA
* Baking Docker Using Chef - ChefConf 2015: https://www.youtube.com/watch?v=5NiJ03r8h9E
