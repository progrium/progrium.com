---
layout: post
title: Understanding Modern Service Discovery with Docker
date: 2014-07-29 23:03 UTC
tags:
---

Over the next few posts, I'm going to be exploring the concepts of service discovery in modern service-oriented architectures, specifically around Docker. Many people aren't familiar with service discovery, so I have to start from the beginning. In this post I'm going to be explaining the problem and providing some historical context around solutions so far in this domain. 

Ultimately, we're trying to get Docker containers to easily communicate across hosts. This is seen by some as one of the next big challenges in the Docker ecosystem. Some are waiting for [software-defined networking](https://en.wikipedia.org/wiki/Software-defined_networking) (SDN) to come and save the day. I'm also excited by SDN, but I believe that well executed service discovery is the right answer today, and will continue to be useful in a world with cheap and easy software networking. 

## What is service discovery?

Service discovery tools manage how processes and services in a cluster can find and talk to one another. It involves a directory of services, registering services in that directory, and then being able to lookup and connect to services in that directory. 

At its core, service discovery is about knowing when any process in the cluster is listening on a TCP or UDP port, and being able to look up and connect to that port by name. 

Service discovery is a general idea, not specific to Docker, but is increasingly gaining mindshare in mainstream system architecture. Traditionally associated with [zero-configuration networking](https://en.wikipedia.org/wiki/Zero-configuration_networking), its more modern use can be summarized as facilitating connections to dynamic, sometimes ephemeral services.

This is particularly relevant today not just because of service-oriented architecture and microservices, but our increasingly dynamic compute environments to support these architectures. Already dynamic VM-based platforms like EC2 are slowly giving way to even more dynamic higher-level compute frameworks like Mesos. Docker is only contributing to this trend.

## Name Resolution and DNS

You might think, "Looking up by name? Sounds like DNS." Yes, name resolution is a big part of service discovery, but DNS alone is insufficient for a number of reasons. 

A key reason is that DNS was originally not optimized for closed systems with real-time changes in name resolution. You can get away with setting TTL's to 0 in a closed environment, but this also means you need to serve and manage your own internal DNS. What highly available DNS datastore will you use? What creates and destroys DNS records for your services? Are you prepared for the archaic world of DNS RFCs and server implementations? 

Actually, one of the biggest drawbacks of DNS for service discovery is that DNS was designed for a world in which we used standard ports for our services. HTTP is on port 80, SSH is on port 22, and so on. In that world, all you need is the IP of the host for the service, which is what an A record gives you. Today, even with private NATs and in some cases with IPv6, our services will listen on completely non-standard, sometimes random ports. Especially with Docker, we have many applications running on the same host.

You may be familiar with SRV records, or "service" records, which were designed to address this problem by providing the port as well as the IP in query responses. At least in terms of a data model, this brings DNS closer to addressing modern service discovery.

Unfortunately, SRV records alone are basically dead on arrival. Have you ever used a library or API to create a socket connection that didn't ask for the port? Where do you tell it to do an SRV record lookup? You don't. You can't. It's too late. Either software explicitly supports SRV records, or DNS is effectively just a tool for resolving names to host IPs.

Despite all this, DNS is still a marvel of engineering, and even SRV records will be useful to us yet. But for all these reasons, on top of the demands of building distributed systems, most large tech companies went down a different path. 

## Rise of the Lock service

In 2006, Google released [a paper describing Chubby](http://static.googleusercontent.com/media/research.google.com/en/us/archive/chubby-osdi06.pdf), their distributed lock service. It implemented distributed consensus based on Paxos to provide a consistent, partition-tolerant (CP in CAP theorem) key-value store that could be used for coordinating leader elections, resource locking, and reliable low-volume storage. They began to use this for internal name resolution instead of DNS. 

Eventually, the paper inspired an open source equivalent of Chubby called [Zookeeper](http://zookeeper.apache.org) that spun out of the Hadoop Apache project. This became the de facto standard lock server in the open source world, mainly because there were no alternatives with the same properties of high availability and reliability over performance. The Paxos consensus algorithm was also non-trivial to implement.

Zookeeper provides similar semantics as Chubby for coordinating distributed systems, and being a consistent and highly available key-value store makes it an ideal cluster configuration store and directory of services. It's become a dependency to many major projects that require distributed coordination, including Hadoop, Storm, Mesos, Kafka, and others. Not surprisingly, it's used in mostly other Apache projects, often deployed in only the largest tech companies. It is quite heavyweight and not terribly accessible to "everyday" developers. 

About a year ago, a simpler alternative to the Paxos algorithm was published called [Raft](http://raftconsensus.github.io/). This set the stage for a real Zookeeper alternative and, sure enough, [etcd](https://github.com/coreos/etcd) was soon introduced by CoreOS. Besides being based on a simpler consensus algorithm, etcd is overall simpler. It's written in Go and lets you use HTTP to interact with it. I was extremely excited by etcd and used it in the initial architecture for Flynn.

Today there's also [Consul](http://www.consul.io/) by Hashicorp, which builds on the ideas of etcd. I specifically explore Consul more in my next post.

## Service Discovery Solutions

Both Consul and etcd advertise themselves as service discovery solutions. Unfortunately, that's not entirely true. They're great distributed configuration stores and service *directories*. But this is just part of a service discovery solution. So what's missing?

We're missing exactly how to get all our software, whether custom services or off-the-shelf software, to integrate with and use the service directory. This is particularly interesting to the Docker community, which ideally has portable solutions for *anything* that can run in a container.

A comprehensive solution to service discovery will have three legs:

 * A consistent (ideally), highly available service *directory*
 * A mechanism to *register* services and monitor service *health*
 * A mechanism to *lookup and connect* to services

We've got good technology for the first leg, but the remaining legs, despite how they sound, aren't exactly trivial. Especially when ideally you want them to be automatic and "non-invasive." In other words, they work with non-cooperating software, not designed for a service discovery system. Luckily, Docker has both increased the demand for these properties and makes them easier to solve. 

In a world where you have lots of services coming and going across many hosts, service discovery is extremely valuable, if not necessary. Even in smaller systems, a solid service discovery system should reduce the effort in configuring and connecting services to nearly nothing. Adding the responsibility of service discovery to configuration management tools, or using a centralized message queue for everything are all-to-common alternatives that we know just don't scale. 

My goal with these posts is to help you understand and arrive at a good idea of what a service discovery system should actually encompass. The next few posts will take a deeper look at each of the above mentioned legs, touching on various approaches, and ultimately explaining what I ended up doing for my soon-to-be-released project, Consulate. 

