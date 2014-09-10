---
layout: post
title: Automatic Docker Service Announcement with Registrator
date: 2014-09-10 22:19 UTC
tags:
---

No matter which service discovery system you use, it will not likely know how to register your services for you. Service discovery requires your services to somehow announce themselves to the service directory. This is not as trivial as it sounds. There are many approaches to do this, each with their own pros and cons.

In an ideal world, you wouldn't have to do anything special. With Docker, we can actually arrange this with a component I've made called [Registrator](https://github.com/progrium/registrator).

Before I get to Registrator, let's understand what it means to register a service and see what kind of approaches are out there for registering or announcing services. It might also be a good idea to see my last posts [on Consul](http://progrium.com/blog/2014/08/20/consul-service-discovery-with-docker/) and [on service discovery](http://progrium.com/blog/2014/07/29/understanding-modern-service-discovery-with-docker/) in general.

## Service Registration Data Model

Service registration involves a few different pieces of information that describes a service. At the very least, it will involve a service name, such as "web", and a locating IP and port. Often, there is a unique ID for a service instance ("web.2"). Some systems generate this automatically.

Around this, there might be extra information or metadata associated with a service. In some systems this could be key-value attributes. Or maybe just tags. Classic service discovery of the zero-configuration world would also include the protocol (HTTP, SMTP, Jabber, etc), but this isn't very useful information since in our case we already know the protocol of the service we're looking for. 

When using etcd or Zookeeper it's up to you how your service directory works, both what information is stored and how to structure it. Specialized service discovery systems like Flynn's discoverd or Netflix's Eureka provide more structure around service semantics. Consul is sort of a hybrid, since it's really a specialized service discovery system built-in to a general configuration store. 

Consul lets you define a service name, IP, port, optional service ID, and optional tags. In a future release, I believe it will tie in more with the key-value store to allow you to have arbitrary attributes associated with a service. Right now, Consul also lets you define a health check to use with its monitoring system, which is unique to Consul. 

So far, that gives you an idea of the data involved in registering a single service, but that's not the complete model. A service "record" is a reference to an actual service, and it's important to understand what that actually is. Whether using containers or not, a service will always boil down to a long-running process, and a process may listen on several ports. This could imply multiple services.

One could argue that if a process listens on multiple ports for the same functional service, it might be a good idea to collapse it into a single service. Modeling it in this way ends up being either complicated (putting the other service ports in meta-data), or incomplete ("which port do I use for TLS?"). I've found it's simplest to just model each port a process listens on as a separate service, using the name to logically group them. For example, "webapp-http" and "webapp-https". 

## Registering In-process or Using a Coprocess

The most common strategy to register in service discovery is actually directly self-registering from the service process itself. From a "good solution" perspective, this might seem terrible. But it's common for a reason. Mostly, it's pragmatic, as many organizations build their specific services around their specific service discovery system. However, it does have other advantages.

Service discovery systems like Eureka and discoverd provide a library that can be used in your service to register itself, as well as lookup and discover other services from in-process. This provides opportunities like having balancing and connection pooling logic taken care of for you, without the extra hop of a reverse proxy. And in cases where heartbeats are used for liveness, the library can handle heartbeating for you. 

The disadvantage of this approach as a reusable system is that libraries are hard provide across languages, so there might be limited language support for the library. Depending on how complex the library is, it may also be difficult to port for people that want to make the effort to expand language support. 

Though, the biggest disadvantage is putting the responsibility on the service in the first place. This creates two problems. First, if you intend to make your services useful to anybody else, your service will be less portable across environments that use different discovery mechanisms. Netflix open source projects suffer from this, as people already complain it's too hard to use some of their components without using all of them. Second, third-party components and services like Nginx, Memcached, or pretty much any datastore will not register themselves. 

While some software might provide hooks or extensions to integrate with your service discovery, this is pretty rare. And patching is not a scalable solution. Instead, the common solution for third-party services is to put the registering responsibility *near* the service.

If you're not directly registering in-process, the second most common approach is running another parallel process to register the service. This works best with a process manager like systemd that can ensure if the service starts, so does the paired registering service. 

Some call this technique using a coprocess or a "sidekick". When working with containers, I usually use coprocess in reference to another process in the same container. A sidekick would be a separate container and process. Either way, this is a useful pattern even beyond service registration. I use it for other administrative services that support the main service, for example to re-configure the service. The open source PaaS Deis used this pattern for shipping out a service's logs. However, it seems to simplify they're [moving to my tool logspout](https://github.com/deis/deis/issues/1714).

A variation of using a coprocess is process "wrapping", where you use a launcher process that will register and run the service as a child process. Flynn does this with sdutil. Some might say it can make starting services feel very complicated since you now have to configure the service as usual, on top of providing registration details to the launcher. At the end of the day, this is effectively the coprocess model launched with one command instead of two. 

## The Problem with a Coprocess for Registering

In whatever form it comes, a coprocess comes with two challenges: configuration and manageability. 

With a parallel announcing process, you need to tell it what service or services it should announce, providing it all the information we talked about before. An interesting problem with any external registration solution is where that service description is stored. For example, if you were doing announcement in-process, it would at least already know what ports it exposes. However, it most likely wouldn't know what the operator wants to call it. Some systems will roll all this information up into higher-level system constructs, like "service groups" or some unit of orchestration. I prefer not to couple service discovery with orchestration. Instead, I'd rather service semantics live as close to the service process as possible.

A coprocess or sidekick for registering also means you'll have one for every service you start. There is no technical problem with this, but it introduces operational complexity. A system has to manage this, whether it's a process manager like systemd or full-on orchestration. That system likely has to be configured, adding more configuration, which may or may not be the right place to define the service. And now you need to be sure to always use this system to launch any service, since running a service by hand will not register the service. 

In an ideal world, we don't worry about any of this. We just run a service and its ports somehow get registered as services. If we want to specify more details about the service, we can do this in a way that's packaged as close to the service as possible. And of course, we want an operator and automation friendly way to set or override that service definition at runtime.  

## How Docker Helps Achieve the Ideal

Running services in Docker provides a number of benefits, and those who believe Docker is just about container isolation clearly miss the point. Docker defines a standard unit of software that can have anything in it and yet have a standard interface of operations. This interface works with a runtime that gives you certain capabilities in managing and operating that unit of software. These capabilities and this common container model happen to have everything we need to automatically register services for any software.

The Docker container image includes default environment variables, which can be defined by the Dockerfile. This turns out to be the perfect place to describe the service it contains. The container author has the option to use the environment variables to include their idea of how the service should be described and registered, which will be shipped with the container wherever it goes. The operator can then set runtime environment variables to further define or redefine their own description of the service. 

The Docker runtime makes these values easy to inspect programmatically. The runtime also produces events when a container starts or stops, which is generally when you want to register or deregister the services of the container. 

All this together lets us provide automatic service registration for any Docker container using a little appliance I've made called Registrator. 

## Introducing Registrator

Registrator is a single, host-level service you run as a Docker container. It watches for new containers, inspects them for service information, and registers them with a service registry. It also deregisters them when the container dies. It has a pluggable registry system, meaning it can work with a number of service discovery systems. Currently it supports Consul and etcd.

There are a few neat properties of Registrator:

First, it's automatic. You don't have to do anything special other than have Registrator running and attached to a service registry. Any public port published is registered as a service.

Related but fairly significant, it requires no cooperation from inside the container to register services. If no service description is included and the operator doesn't specify any at runtime, it uses Docker container introspection for good defaults. 

Next, it uses environment variables as generic metadata to define the services. Some people have asked how you can add metadata to Docker containers, but the answer is right in front of them. As mentioned this comes with the benefit of being able to define them during container authorship, as well as at runtime.

Lastly, the metadata Registrator uses could become a common interface for automatic service registration beyond Registrator and even beyond Docker. Environment variables are a portable metadata system and Registrator defines a very data-driven way to define services. That same data could be used by any other system.

In terms of previous work, Michael Crosby's project [Skydock](https://github.com/crosbymichael/skydock) was a big inspiration on the direction of Registrator, so it might be worth looking into for reference. Registrator is a little more generic and made specifically for distributed systems, not as much for single host registries. For example, Registrator focuses on published ports and uses a host-level IP as opposed to local container IPs. For people interested in single-host discovery, Registrator has already inspired compatible alternatives, including Brian Lalor's [docker-hosts](https://github.com/blalor/docker-hosts).

In any case, I believe I've made the first general purpose solution to automatic service registration. Here's a video demo:

<p style="text-align: center;"><iframe src="//player.vimeo.com/video/105806672" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></p>

## Onward...

In retrospect, the problem we've solved here now seems very trivial, but we've never had this before. Like many good designs, it can take a while for all the pieces to come together and make sense in one's mind before it becomes obvious. Once it's obvious, it seems like it always was. 

Combining auto-registration with a good service directory, you're almost to an ideal service discovery system. That last problem is about the other side of discovery: connecting to registered services. The next post will describe how this is also not as trivial as it sounds, and as usual, I will offer an open source solution.
