.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef provisioning| is a collection of resources that enable the creation of machines and machine infrastructures using the |chef client|. It has a plugin model that allows bootstrap operations to be done against any infrastructure, such as |virtualbox|, |digital ocean|, |amazon ec2|, |linux lxc|, bare metal, and more.

|chef provisioning| is built around two major components: the |resource machine| resource and drivers.