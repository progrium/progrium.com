---
layout: post
title: Consul Service Discovery with Docker
date: 2014-08-20 20:05 UTC
tags:
---
[Consul](http://www.consul.io/) is a powerful tool for building distributed systems. There are a handful of alternatives in this space, but Consul is the only one that really tries to provide a comprehensive solution for service discovery. As my [last post](/blog/2014/07/29/understanding-modern-service-discovery-with-docker/) points out, service discovery is a little more than what Consul can provide us, but it is probably the biggest piece of the puzzle. 

## Understanding Consul and the "Config Store"

The heart of Consul is a particular class of distributed datastore with properties that make it ideal for cluster configuration and coordination. Some call them lock servers, but I call them "config stores" since it more accurately reflects their key-value abstraction and common use for shared configuration. 

The father of config stores is Google's Chubby, which was never made publicly available but is described in the influential [Chubby paper](http://research.google.com/archive/chubby.html). In the open source world we have Apache Zookeeper, the mostly defunct doozerd, and in the last year, etcd and Consul.

These specialized datastores are defined by their use of a consensus algorithm requiring a quorum for writes and generally exposing a simple key-value store. This key-value store is highly available, fault-tolerant, and maintains strong consistency guarantees. This can be contrasted with a number of alternative clustering approaches like master-slave or two-phase commit, all with their own benefits, drawbacks, and nuances. 

You can learn more about the challenges of designing stateful distributed systems with the online book, [Distributed systems for fun and profit](http://book.mixu.net/distsys/single-page.html). This image from the book summarizes where the quorum approach stands compared to others:

<p style="text-align: center;"><img src="/images/content/embassy/google-transact09.png" title="Diagram borrowed with love from Distributed systems for fun and profit"></p>

Quorum datastores such as our config stores seem to have many ideal properties *except* for performance. As a result, they're generally used as low-throughput coordinators for the rest of the system. You don't use them as your application database, but you might use them to coordinate replacing a failed database master.

Another common property of config stores is they all have mechanisms to watch for key-value changes in real-time. This feature is central in enabling use-cases such as electing masters, resource locking, and service presence. 

## Along comes Consul

Since Zookeeper came out, the subsequent config stores have been trying to simplify. Both in terms of user interface, ease of operation, and implementation of the consensus algorithms. However, they're all based on this very expressive, but lowest common denominator abstraction of a key-value store. 

Consul is the first to build on top of this abstraction by also providing specific APIs around the semantics of common config store functions, namely service discovery and locking. It also does it in a way that's very thoughtful about those particular domains. 

For example, a directory of services without service health is actually not a very useful one. This is why Consul also provides monitoring capabilities. Consul monitoring is comparable, and even compatible, with Nagios health checks. What's more, Consul's agent model makes it more scalable than centralized monitoring systems like Nagios.

<p style="text-align: center;"><img src="/images/content/embassy/consul_layers.png" /></p>

A good way to think of Consul is broken into 3 layers. The middle layer is the actual config store, which is not that different from etcd or Zookeeper. The layers above and below are pretty unique to Consul. 
Before Consul, HashiCorp developed a host node coordinator called Serf. It uses an efficient gossip protocol to connect a set of hosts into a cluster. The cluster is aware of its members and shares an event bus. This is primarily used to know when hosts come and go from the cluster, such as during a host failure. But in Serf the event bus was also exposed for custom events to trigger user actions on the hosts.

Consul leverages Serf as a foundational layer to help maintain its cluster. For the most part, it's more of an implementation detail. However, I believe in an upcoming version of Consul, the Serf event bus will also be exposed in the Consul API. 

The key-value store in Consul is very similar to etcd. It shares the same semantics and basic HTTP API, but differs in subtle ways. For example, the API for reading values lets you optionally pick a consistency mode. This is great not just because it gives users a choice, but it documents the realities of different consistency levels. This transparency educates the user about the nuances of Consul's replication model.

On top of the key-value store are some other great features and APIs, including locks and leader election, which are pretty standard for what people originally called lock servers. Consul is also datacenter aware, so if you're running multiple clusters, it will let you federate clusters. Nothing complicated, but it's great to have built-in since spanning multiple datacenters is very common today.

However, the killer feature of Consul is its service catalog. Instead of using the key-value store to arbitrarily model your service directory as you would with etcd or Zookeeper, Consul exposes a specific API for managing services. Explicitly modeling services allows it to provide more value in two main ways: monitoring and DNS.

## Built-in Monitoring System

Monitoring is normally discussed independent of service discovery, but it turns out to be highly related. Over the years, we've gotten better at understanding the importance of monitoring service health in relation to service discovery. 

With Zookeeper, a common pattern for service presence, or liveness, was to have the service register an "ephemeral node" value announcing its address. As an ephemeral node, the value would exist as long as the service's TCP session with Zookeeper remained active. This seemed like a rather elegant solution to service presence. If the service died, the connection would be lost and the service listing would be dropped. 

In the development of doozerd, the authors avoided this functionality, both for the sake of simplicity and that they believed it encouraged bad practice. The problem with relying on a TCP connection for service health is that it doesn't exactly mean the service is healthy. For example, if the TCP connection was going through a transparent proxy that accidentally kept the connection alive, the service could die and the ephemeral node may continue to exist. 

Instead, they implemented values with an optional TTL. This allowed for the pattern of actively updating the value if the service was healthy. TTL semantics are also used in etcd, allowing the same active heartbeat pattern. Consul supports TTL as well, but primarily focuses on more robust liveness mechanisms. In the discovery layer I helped design for Flynn, our client library lets you register your service and it will automatically heartbeat for you behind the scenes. 

This is generally effective for service presence, but it might not take the lesson to heart. Blake Mizerany, the co-author of doozerd and now maintainer of etcd, will stress the importance of *meaningful* liveness checks. In other words, there is no one-size-fits-all. Every service performs a different function and without testing that specific functionality, we don't actually know that it's working properly. Generic heartbeats can let us know if the process is running, but not that it's behaving correctly enough to safely accept connections.

Specialized health checks are exactly what monitoring systems give us, and Consul gives us a distributed monitoring system. Then it lets us choose if we want to want to associate a check with a service, while also supporting the simpler TTL heartbeat model as an alternative. Either way, if a service is detected as not healthy, it's hidden from queries for active services.

## Built-in DNS Server

In my last post, I mentioned how DNS is not a sufficient technology for service discovery. I was very hesitant in accepting the value of a DNS interface to services in Consul. As I described before, all our environments are set up to use DNS for resolving names to IPs, not IPs with ports. So other than identifying the IPs of hosts in the cluster, the DNS interface at first glance seems to provide limited value, if any, for our concept of service discovery. 

However, it does serve SRV records for services, and this is huge. Built-in DNS resolvers in our environments don't lookup SRV records, however, the library support to do SRV lookups ourselves is about as ubiquitous as HTTP. This took me a while to realize. It means we all have a client, even more lightweight than HTTP, and it's made *specifically* for looking up a service. 

To me this makes SRV the best standard API for simple service discovery lookups. I hope more service discovery systems implement it.

In a later post in this series, we build on SRV records from Consul DNS to generically solve service inter-connections in Docker clusters. I don't think I would have realized any of this if Consul didn't provide a built-in DNS server. 

## Consul and the Ecosystem

Consul development is very active. In the past few months, they've had several significant releases, although it's still pre-1.0. Etcd is also actively being developed, though currently from the inside out, focusing on a re-design of their Raft implementation. The two projects are similar in many ways, but also very different. I hope they learn and influence each other, perhaps even share some code since they're both written in Go. At this point, though, Consul is ahead as a comprehensive service discovery primitive. 

Unfortunately, Consul is much less popular in the Docker world. Perhaps this is just due to less of a focus on containers at HashiCorp, which is contrasted by the heavily container-oriented mindset of the etcd maintainers at CoreOS. 

I've been trying hard to help bridge the Docker and Consul world by building a solid Consul container for Docker. I try to design containers to be self-contained, runtime-configurable appliances as much as possible. It was not hard to do this with Consul, which is now available on [Github](https://github.com/progrium/docker-consul) or [Docker Hub](https://registry.hub.docker.com/u/progrium/consul/).

## Running Consul in Docker

Running a Consul node in Docker for a production cluster can be a bit tricky. This is due to the amount of configuration that the container itself needs for Consul to work. For example, here's how you might start one node using Docker (one command over several lines for readability):

    $ docker run --name consul -h $HOSTNAME  \
        -p 10.0.1.1:8300:8300 \
        -p 10.0.1.1:8301:8301 \
        -p 10.0.1.1:8301:8301/udp \
        -p 10.0.1.1:8302:8302 \
        -p 10.0.1.1:8302:8302/udp \
        -p 10.0.1.1:8400:8400 \
        -p 10.0.1.1:8500:8500 \
        -p 172.17.42.1:53:53/udp \
        -d -v /mnt:/data \
        progrium/consul -server -advertise 10.0.1.1 -join 10.0.1.2


The Consul container I built comes with a helper command letting you simply run:

	$ $(docker run progrium/consul cmd:run 10.0.1.1::10.0.1.2 -d -v /mnt:/data)

This is just a special command to generate a full Docker run command like the first one, hence wrapping it in a subshell. It's not required, but a helpful convenience to hopefully get people started with Consul in Docker much quicker. 

One of the neat ways Consul and Docker can work together is by giving Consul as a DNS server to Docker. This transparently runs DNS resolution in containers through Consul. If you set this up at the Docker daemon level, you can also specify DNS search domains. That means the `.services.consul` can be dropped, allowing containers to resolve records with just the service name. 

The project README has some pretty helpful getting started instructions as well as more detail on all these features. Here's a quick video showing how easy it is to get a Consul cluster up and running inside Docker, including the above DNS trick.

<p style="text-align: center;"><iframe src="//player.vimeo.com/video/103943481" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></p>

## Onward...

Once you have Consul running in Docker, you're *close* to having great service discovery, but as I mentioned in my last post, you're still missing those second two legs. Stay tuned for the next post on automatically registering containerized services with Consul.

