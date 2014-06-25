---
layout: post
title: "Web hooks to revolutionize the web"
description: ""
category: 
tags: []
---
There once was a command line. It was a powerful thing. Not only could you navigate your filesystem and launch applications, but you could program shell scripts to automate tasks and make convenient shortcuts. It also had pipes.

One of the major sources of power on the Unix command line is the simple construct of input and output. A program can read from `STDIN` and can write to `STDOUT`, and you have a fair amount of control over re-routing them however you want. Most commonly this is used to chain commands together, "piping" the output of one to the input of another.

This is infrastructure. Infrastructure that encourages simple, independent programs to be made almost exclusively for the purpose of chaining with other commands. These are commands like cat, grep, uniq, wc, sort, nc, and others. Many of them are useless by themselves, but together they achieve more than the sum of their parts. Especially when combined with larger programs. This is made possible from the simple idea of input and output.

This idea was implemented on Unix in 1977. Twenty years later, Jon Udell expressed a vision of web sites as data sources that could be reused and remixed, and a new programming paradigm that took the whole Internet as its platform. This lead Tim OReilly to ask in 2000:

> What is the equivalent of the pipe in the age of the web?

There seems to be a resounding consensus that the answer is feeds. The name sounds very promising, it sort of make you imagine feeds like in the telecom world. Data coming directly to you. But this is misleading because feeds aren't about data coming to you. They're about you getting that data yourself. A lot. Over and over again. This is polling.

If you could avoid polling, you probably would. If you're building an app that works with a feed, you have to write a polling system. This means messing with the often-hard-to-debug crontab or writing and managing a full-fledged daemon. Then you have to worry about caching and parsing. Feeds seem to be made for the browser because the browser does a lot of this work for you, but it's a different story if you're constantly polling feeds or APIs in the backend. Then it almost becomes too much work to do anything simple with feeds and APIs. If you want to use feeds for real-time notification, have fun setting that up.

I also think there's a problem with the command line metaphor in the first place. The web is not linear. Web apps aren't synchronous. A better metaphor would be a daemon process. How do they communicate? IPC? Sockets? Queues?

<div class="alert alert-info">
Note from 2012: Remember, this was 2007. Web developers didn't have Node.js or EventMachine, and mainstream developers didn't understand queuing systems or async operations. Often all they had was Apache and PHP.
</div>

Unfortunately, web stacks are stateless request processors, so you can't really use sockets. You could use Amazon SQS or some other queuing system, but queues often just move the polling to somewhere else. What we need is something simple, stateless, and ideally real-time. We need to push.

This is where web hooks come in. Web hooks are essentially user defined callbacks made with HTTP POST. To support web hooks, you allow the user to specify a URL where your application will post to and on what events. Now your application is pushing data out wherever your users want. It's pretty much like re-routing `STDOUT` on the command line.

We're already sort of doing this with pingbacks on blogs. However, the difference with web hooks is that the payload is arbitrary event data and the target URLs are user web scripts or handlers. From there, the users can do whatever they want.

The idea here is to create new infrastructure. New opportunities. I've been thinking a lot about the possibilities of a web hook enabled web, and it makes me really excited. Because it's such open ended infrastructure, I'm sure the possibilities extend well beyond what I can think of. Especially when combined with our growing ecosystem of APIs and feeds.

Web hooks are easy to implement for application developers. You just implement a UI or API to let the user specify target URLs, and then you're just making a standard HTTP POST on events. This is a fairly trivial operation in most environments, since you already do this to use other web APIs. 

Let's be clear. When I talk about the user of web hooks, it's often a power user or developer. But being based on HTTP POST makes it very accessible for mainstream web developers. They already know how to work with POST variables. And PHP hosting is widely available and practically free. I think PHP would become a popular language for writing hook scripts.

Just think about it. Writing all the boilerplate polling and parsing infrastructure just to use a feed? Or writing a little PHP script that has all the incoming data in `$_POST`. Plus it's real-time. Which has a lower barrier to entry when somebody gets a bright idea on how to use all this data we've "opened up" on the programmable web?

The Unix pipe is simple because it's about linear input and output of text streams. The web is very different. At a high level, I think web hooks achieve the same simplicity but more appropriately for the web. When coupled with our existing ecosystem of feeds and APIs, we'll have an even more powerful platform than what pipes gave Unix.
