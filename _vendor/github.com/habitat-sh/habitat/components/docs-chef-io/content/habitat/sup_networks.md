+++
title = "Supervisor Networks"
description = "Robust Supervisor Networks"

[menu]
  [menu.habitat]
    title = "Supervisor Networks"
    identifier = "habitat/supervisors/sup-networks Supervisor Networks Explained"
    parent = "habitat/supervisors"
    weight = 60

+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/sup_networks.md)

Chef Habitat Supervisors communicate amongst each other using "gossip" algorithms, which underpin the membership management, leadership election, and service discovery mechanics of Chef Habitat. By simply being "peered" to a single existing Supervisor, a new Supervisor will gradually come to know about _all_ the Supervisors in a Chef Habitat network. The gossip algorithm has built-in features to counteract brief network splits, but care must be taken to set up a robust Supervisor network.

## The Initial Peer

While a Chef Habitat Supervisor does not need to connect with any other Supervisors in order to be useful, leveraging a network of Supervisors unlocks the full potential of Chef Habitat as a platform. In order to do this, a Supervisor must be given the address of at least one other Supervisor in this network when it starts up; this is known as the "initial peer problem". You might think of a Supervisor network as an exclusive members-only club; you must first know a member in order to become a member yourself.

This Supervisor does _not_ know about any other Supervisors, and will (at least initially) run in complete isolation.

```sh
hab sup run
```

This Supervisor, on the other hand, will start up knowing about three other Supervisors, and will quickly establish contact with each of them. Thanks to the gossip mechanism, it will also find out about every other Supervisor those initial Supervisors know about. Similarly, every other Supervisor will discover the presence of _this_ new Supervisor.

```sh
hab sup run --peer=192.168.0.1 --peer=192.168.0.2 --peer=192.168.0.3
```

It should be noted that peering is symmetric. Even though our first Supervisor above did not start out peered with any other Supervisors, it can still become part of a Supervisor network if some other Supervisor declares it to be a peer.

## Managing Membership with SWIM

In order for Chef Habitat's network functionality to work, the Supervisors must first know which other Supervisors they can communicate with. This is a problem of maintaining "membership lists", and is achieved using the membership protocol known as [SWIM][SWIM]. As detailed above, we must first "seed" a Supervisor's membership list with at least one "peer"; that is, another Supervisor that it can communicate with.

Given a non-empty membership list, the Supervisor can begin probing the members of that list to see if they are still alive and running. Supervisor A sends a message to Supervisor B, effectively asking "are you still there?". If Supervisor B _is_ available, it will reply to Supervisor A, also sending contact information for up to five Supervisors that _it_ has in its membership lists (Supervisor A sends these introductions in its initial message, as well). In this way, Supervisors can both maintain and _grow_ their membership lists. In short order, Supervisor A will come to know of all the other Supervisors in the network, and they, too, will come to know of Supervisor A.

If Supervisor A cannot establish contact with Supervisor B for some reason, it does not immediately consider it to be dead. This would be too strict, and could lead to unnecessary service "flapping". Instead, Supervisor A will consider Supervisor B "suspect". In this case, it will ask Supervisor C (another Supervisor in its membership list) if _it_ can contact Supervisor B. If Supervisor C can make contact, it relays that information back to Supervisor A, which will then consider Supervisor B to be alive again, and _not_ suspect. This scenario can arise, for example, if there is a network split between Supervisors A and B, but not between A and C, or B and C. Similarly, network congestion could delay messages such that Supervisor A's request times out before Supervisor B's reply can make it back.

If no Supervisor can make contact with Supervisor B, either directly or indirectly, the network comes to view Supervisor B as "confirmed" dead. In this case, Supervisor B is effectively removed from all membership lists across the network. As a result, no Supervisors try to contact it again. This is ultimately what happens when you shut down a Supervisor; the rest of the network realizes that it is gone and can reconfigure any services to no longer communicate with any services that were running on it.

If, on the other hand, Supervisor B is started back up again, it can rejoin the network. All the other Supervisors will (through the same SWIM mechanism described) recognize that it is back, and will mark it as alive once again. Services will be reconfigured to communicate with Supervisor B's services as appropriate.

This mechanism forms the foundation of the Chef Habitat network, but cannot by itself provide a completely robust network. For that, we need something additional.

## Permanent Peers

An important thing to keep in mind about the basic SWIM mechanism is that if two Supervisors are separated from each other for a long enough amount of time, they will each come to view the other as being dead, and will not try to reestablish contact. While this is the behavior you want when you legitimately shut a Supervisor down, it is definitely _not_ the behavior you want if your Chef Habitat network experiences an extended network incident. In such a case, you could end up with two (or more!) smaller Supervisor networks that are all still _internally_ connected, but completely disconnected _from each other_. Supervisors in "Network A" would view those in "Network B" as dead, and vice versa. Once network connectivity had been restored, you would continue to have a fractured network, because each network would collectively consider the other to still be dead.

By starting a few Supervisors in the network using the `--permanent-peer` option, an additional bit of information is gossipped about these Supervisors. In effect, it tells all other Supervisors it communicates with to _always_ try to reestablish contact with it, even if that Supervisor considers the "permanent" Supervisor to be dead. This provides a mechanism by which split networks can stitch themselves together again after the split has been resolved.

## The "Bastion Ring"

Defining a few Supervisors to be "permanent peers" _will_ provide a robust network, but unless done with care, it can be less than ideal. We recommend running a small number of Supervisors as permanent peers, but _to run no services on those Supervisors_. In modern dynamic architectures, it's common for nodes to come and go; VMs may get shut down, containers can be rescheduled, and so on. If you were to go to the extreme and have _all_ your Supervisors be permanent peers, you would end up with unnecessary network traffic as the Supervisors come and go as the infrastructure evolves across time. Each Supervisor would try to maintain contact with every Supervisor that had ever been a member of the network!

If your permanent peer Supervisors are not running any services, they will be less subject to the pressures that would cause service-running Supervisors to come and go. They can exist solely to anchor the entire Supervisor network.

## Pulling It All Together: A Robust Supervisor Network

With all this, we can come up with a robust Chef Habitat network architecture. In fact, this is the same architecture the Chef Habitat team uses to run the public [Builder service](https://bldr.habitat.sh).

### Create the Bastion Ring

First, set up three Supervisors as permanent peers, all mutually peered to each other (The labels "A", "B", and "C" are stand-ins for the IP addresses at which these Supervisors are reachable):

``` sh
# Supervisor "A"
hab sup run --permanent-peer --peer=B --peer=C

# Supervisor "B"
hab sup run --permanent-peer --peer=A --peer=C

# Supervisor "C"
hab sup run --permanent-peer --peer=A --peer=B
```

These Supervisors should never be used to run services. They _can_ however, serve as convenient, well-known, and stable entry points to the network for doing things like injecting configurations using `hab config apply`, adding files using `hab file upload`, or departing Supervisors using `hab sup depart`.

### Peer Additional Supervisors to the Bastion Supervisors

Each additional Supervisor you add to the network should be peered to _at least one_ of the bastion ring Supervisors. Technically speaking, only one peer is necessary, as that provides access to the rest of the network. However, it could be possible to not fully connect to all of them if, say, the Supervisor joined _during_ a network split event. Out of convention and redundancy, we peer to _all_ the bastion ring Supervisors, like so:

``` sh
# Supervisor "D" (a "normal" Supervisor)
hab sup run --peer=A --peer=B --peer=C
```

This Supervisor _should_ be used to run services, but _should not_ be started as a permanent peer.

## Conclusion

Hopefully, the above discussion has given you a better idea of how Chef Habitat's networking works, and how you can best take advantage of it to provide a robust network foundation for the services you run.

For those that like to keep things succinct, the above advice can be summed up thusly:

1. Run three mutually-peered, permanent Supervisors
2. Never run services on those Supervisors
3. Peer all other Supervisors to those first three

## Related Reading

If you would like additional details, the following technical journal articles describe the algorithms that form the basis of Chef Habitat's gossip system:

* [SWIM: Scalable Weakly-consistent Infection-style Process Group Membership Protocol](https://www.cs.cornell.edu/projects/Quicksilver/public_pdfs/SWIM.pdf) by Abhinandan Das, Indranil Gupta, Ashish Motivala.
* [A Robust and Scalable Peer-to-Peer Gossiping Protocol](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.90.8773&rep=rep1&type=pdf) by Spyros Voulgaris, Mark Jelasity, and Maarten van Steen.
