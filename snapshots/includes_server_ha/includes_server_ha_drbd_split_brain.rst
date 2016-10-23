.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A ``split-brain`` event is a concept of clustered computing systems in which the cluster loses its heartbeat communication channel and becomes two unconnected pieces. Recovery from a ``split-brain`` event can be a complex issue and different clustering software packages use different methods.

Failures happen, so completely preventing a ``split-brain`` event is not an absolute possibility. However, it is possible to alleviate some of the issues that crop up in any ``split-brain`` event scenarios by maxing out the heartbeat network bandwidth and optimizing transfer protocols.

DRBD is a shared-nothing system. Data is replicated between hosts over a dedicated network link rather than stored on a central network-attached storage (NAS) or storage attached network (SAN) to which all hosts are connected. The most critical issue for storage in a high availability topology is loss of or corruption of data. Maximizing the amount of data that can be passed over the wire while all systems are up and running correctly minimizes the chance that something will be lost or unrecoverable if a host goes down.

At any given time, only one DRBD host has ``userland`` access to data, This host is referred to as the primary node. The other host runs the DRBD daemon, but cannot mount the storage into the file system. The secondary node receives information from the primary node, and then replicates disk actions on its local storage copy (even if the partition looks like it doesn't have a file system to which a ``mount`` command can be sent).

The approach that DRBD takes to ``split-brain`` event situations is to degrade all partners still alive to secondary status, and then wait for manual intervention. This is called auto-fencing, with a goal of minimizing the potential for damage to your data. When you lose one of the partners in a high availability topology, a bit of manual intervention is required to ensure that the disks aren't in a bad state and can be brought back up. These scenarios are discussed below, including suggestions for diagnosing and recovering from each scenario.

