---
layout: post
title: "The Start of the Age of Flynn"
description: ""
category: 
tags: []
---
For about the past six months, I've been working on an open source project called [Flynn](https://flynn.io/). It's gotten a lot of attention, but I haven't written much about it. I've been hoping to start a series discussing the design and development behind Flynn, but it seems appropriate to at least introduce the project and provide some context. 

## What is Flynn?

Before development, I started writing the official [Flynn Guide](https://github.com/flynn/flynn-guide). There I explained Flynn like this:

> Flynn has been marketed as an open source Heroku-like Platform as a Service (PaaS), however the real answer is more subtle. Flynn is two things:
> <br /><br /> 
> 1) a "distribution" of components that out-of-the-box gives companies a reasonable starting point for an internal "platform" for running their applications and services,
> <br /><br />
> 2) the banner for a collection of independent projects that together make up a toolkit or loose framework for building distributed systems.
> <br /><br />
> Flynn is both a whole and many parts, depending on what is most useful for you. The common goal is to democratize years of experience and best practices in building distributed systems. It is the software layer between operators and developers that makes both their lives easier.

It's easy right now to describe Flynn as another, better, modern open source PaaS. But it's really much more than that. I usually need to underline this in discussions because in most people's mind, a PaaS is a black box system that you deploy and configure and then you have something like Heroku. Like you can deploy OpenStack Nova and get something like EC2. 

Flynn can be that, but it's designed so it can be used as an open system, or framework, to build a service-oriented application operating environment. The truth is, if you're building and operating any sort of software as a service, you're not just building an application, you're building a *system* to support your application and the processes around it.

You might be tempted to call Flynn a tool for "devops". While that might be true, remember that the original ideas around devops were about organization-wide systemic understanding of your application, its lifecycle, and its operation. In reality, Flynn is designed for this type of thinking and should hopefully blur the line between operations and engineering, encouraging both to work together and think about the *entire* system you're building.

## Why build Flynn, how did it come about?

This is a long story, but it provides context for the vision of Flynn, what problems inspired it, and shows just how long the idea has been stirring. Though keep in mind Flynn is a collaboration and this is just my half of the story.

### Falling in love with PaaS

For years I was obsessed with improving the usefulness and programmability of our collective macro distributed system of web services and APIs. Think webhooks. Circa 2006 I was also building lots of little standalone web utilities and APIs for fun. I quickly learned that using technologies like App Engine and Heroku was imperative to sanely operate so many of these free services, and keep costs near zero for what I considered public utilities. 

It turns out, for the exact same reasons of cost and automation, these PaaS providers were slowly revolutionizing a subset of commercial application development. The idea of generic managed applications ("NoOps") and streamlining the delivery pipeline (necessary for Continuous Delivery) has always had huge implications for web apps and their businesses. For me, even though PaaS providers couldn't have come soon enough, I seemed to always want more than what they could provide. I constantly struggled with the limitations of App Engine, Heroku, and dotCloud. Originally it was limited to certain languages, certain types of computation, certain types of protocols. In fact, there still isn't a great PaaS provider that lets you build or deploy a non-HTTP service, like say, an SMTP server or custom SSH server. 

### The divide between PaaS and host-based infrastructure

For all the systems and design knowledge, best practices, and solutions to important problems that Heroku, dotCloud, App Engine, and others have figured out, if for some reason you cannot use them, you get none if it. If it's too expensive, or your system is just too complicated, or you need to use a protocol they don't support, you just get EC2 or bare metal hosts and have to work from there. If you're lucky or smart, depending on who makes these decisions, you get to use Chef or Puppet. 

But I'll be honest, the Chef and EC2 combo is still a huge step down from what a system like Heroku can offer. What's more is that large scale organizations like Google and Twitter have it pretty well figured out, but they have it figured out for them. The rest of us are left with a myriad of powerful if not mystical solutions to building our distributed systems like Mesos and Zookeeper. If we're lucky enough to discover and understand those projects, we often avoid them until absolutely necessary and only then figure out how to integrate them into our already complex systems. Most of which we had to build ourselves because the baseline starting point has always been "a Linux server". 

### Twilio and service-oriented architectures

For me, a lot of this was learned at [Twilio](https://www.twilio.com/), which was a perfect place to think about this space. The Twilio system, behind that wonderfully simple API, is a highly complex service-oriented system. When I left a couple years ago, it involved roughly 200 different types of services to operate. Some were off-the-shelf open source services, like databases or caches. Most of them were custom services that spoke to each other. Some were written in Python, some in PHP, some in Java, others in C. Lots of protocols were used, both internally and publicly facing. Primarily HTTP, but also SIP, RTP, custom TCP protocols, even a little ZeroMQ. Most people forget that databases also add protocols to the list.

I can't tell you how many problems come with a system that complicated. Though it did its job quite well, the system was effectively untestable, had an atrocious delivery pipeline, was incredibly inefficient in terms of EC2 instances, and nobody really understood the whole system. A lot of these are common problems, but they're compounded by the scale and complexity of the system. 

The first half my time at Twilio was spent building scalable, distributed, highly-available messaging infrastructure. What a great way to learn distributed systems. However, I ran into so many problems and was so frustrated by the rest of the system, that I dedicated the second half of my time at Twilio to improving the infrastructure and helped form the Platform team. The idea being that we were to provide a service platform for the rest of the engineering organization to use. Unfortunately it never really became more than a glorified operations and systems engineering team, but we did briefly get the chance to really think through the ideal system. If we could build an ideal internal platform, what would it look like? We knew it looked a lot like Heroku, but we needed more. What we ended up with looked a lot like Flynn. But it never got started. 

I remember very clearly working out sketches for a primitive that I thought was central to the whole system. It was a "dyno manager" to me, which gave you a utility to manage the equivalent of Heroku dynos on a single host. These were basically fancy Linux containers. Again, though, not important to Twilio at the time. Eventually, I left Twilio and started contracting.

### More history with cloud infrastructure

First, I worked with some old friends back from the [NASA Nebula](http://bit.ly/1fBtien) days. I forgot to mention, in 2009, before Twilio, I worked at NASA building open source cloud infrastructure. The plan was to implement an EC2, then a sort of App Engine on top of it, and then specifically for purposes at NASA, lots of high level application modules. Turns out the first part was hard enough. We started using Eucalyptus, but realized it was not going to cut it. Eventually the team wrote their own version from what they learned using Eucalyptus, called it Nova, partnered with Rackspace, and that's how [OpenStack](https://www.openstack.org/) was born.

I was on the project pre-OpenStack to actually work on the open source PaaS back then in 2009, but we never got to that before I left. Probably for the best in terms of timing. Another reason I was there was because we also wanted to provide project hosting infrastructure at NASA. This was before Github was popular, and in fact, I was running a competing startup called DevjaVu since 2006 that productized Trac and SVN. As Github got more popular and I was distracted with other projects, I decided to shutdown DevjaVu, admitting that Github was doing it right. But my experience meant I could easily throw together what was originally going to be code.nasa.gov. 

Fast forward to my contracting after Twilio, I worked with my friends at [Piston Cloud](http://www.pistoncloud.com/), one of the OpenStack startups that fell out of the NASA Nebula project. My task wasn't OpenStack related, it was actually to automate the deployment of [CloudFoundry](http://www.cloudfoundry.com/) on top of OpenStack for a client. CloudFoundry was one of the first open source PaaS projects. It popped up in 2011. This gave me a taste of CloudFoundry, and boy it was a bad one. Ignoring anything about CloudFoundry itself, just deploying it from scratch, while 100% automated, would take 2 *hours* to complete. Nevertheless, there are still some aspects of the project I admire.

### Docker and Dokku

My next big client turned out to be an old user of DevjaVu, but I never realized it until I started talking with them. It was a company called dotCloud. Quickly hitting it off with Solomon Hykes, we tried to find a project to collaborate on. I mentioned my "dyno manager" concept, and he brought up their next-gen container technology. Soon I was working on a prototype called [Docker](http://www.docker.io/). 

While the final project was mostly a product of the mind of Solomon and the team, while working on the prototype I made sure that it could be used for the systems I was envisioning. In my mind it was just one piece of a larger system, though a very powerful piece with many other uses and applications. Solomon and I knew this, and would often say it was the next big thing, but it's still a bit crazy to see that it's turning out to be true.

Not long after Docker was released, Solomon and I went to give a talk at GlueCon to preach this great new truth. The day before the talk, I spent 6 hours hacking together a demo for the talk that would demonstrate how you could "easily" build a PaaS with Docker. I later released this as [Dokku](https://github.com/progrium/dokku), a Docker powered mini-Heroku.

Dokku intentionally left out anything having to do with distributed systems. It was meant for a single host. I thought maybe it would be good for personal use or for building internal tools. Turns it was, and it got pretty popular. I had a note in the readme that said it intentionally does not scale to multiple hosts, and that perhaps this could be done as a separate project that I referred to as "Super Dokku". That's what I imagined Flynn as at the time.

### Flynn takes shape

Now, back around the time I was working on the Docker prototype in Winter 2012, I was approached by two guys, Daniel Siders and Jonathan Rudenberg, that had been working on the Tent protocol and its reference implementation. They wanted to build a fully distributed, enterprise grade, open source platform service. They said they were going to be working on it soon, and they wanted to work on it with me. The only problem is they didn't have the money, and they'd get back to me after a few funding meetings.

Later, I think around the time I released Dokku mid-2013, Daniel and Jonathan approached me again. They were serious about this platform service project and had the idea to crowdfund it with company sponsorships. You'd think I'd be rather dubious about the idea, but given the growing interest in Docker, the great response from Dokku, and basically testimonial after testimonial of companies wanting something like this, I figured it could work.

We decided to call the project Flynn, and got to work comparing notes and remote whiteboarding the project. I was very lucky that they were very like-minded, and we were already thinking of very similar architectures and would generally agree on approaches. We put together the Flynn Guide and the website copy and funding campaign using [Selfstarter](http://selfstarter.us/), then let it loose. 

We quickly met our funding goal for the year and then spent the rest of the year working on Flynn. Unfortunately, the budget only covered part-time, but we had planned to have a working development release by January 2014.

## What now?

It's now February 2014, so let's take a look at where we are. 

Like most software schedules, ours fell behind a little. While the project has been in the open on Github from the beginning, we planned to share a rough but usable developer release last month. We're *so* close. 

What makes it difficult is we're out of our 2013 budget! This affects my contribution more than Jonathan's. I've been putting time into it here and there, but it no longer pays my bills. That could change soon, but until then it might move a little bit slower until our initial release. Only after the release can we can go for another sponsorship campaign, so you can see how right now is just a little frustrating.

That said, there's still more and more interest in the project, we already have a few brave souls that have been contributing to the project components, and like I said, hopefully the money situation will sort itself out soon. A few things are in the works. 

In the meantime, although I'm not as active on it at this moment, I do feel compelled to use this time to write about it here on my blog. Hopefully catch everybody up on the architecture, discuss design decisions, talk about the future, and then a lot of that should be useable for official project documentation.

And hell, if I can't work on Flynn for some reason, after all this, hopefully the writing will allow somebody to continue my work. :)