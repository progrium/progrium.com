---
layout: post
title: "Where did Localtunnel come from?"
description: ""
category: 
tags: []
---
Five years ago, async network programming scared me. I was a web developer. Working with the high level tools and frameworks of HTTP seemed much easier than any sort of serious low level networking. Especially since network programming would often also mean some kind of concurrent programming with threads or callbacks. I had mostly avoided multithreading and had no idea what an event loop was. I came from PHP.

Around 2007, I was starting to think about webhooks. One motivator was how you could use webhooks to let web developers, like me, build systems that used other protocols without them having to work with that protocol. For example, one of my first projects with webhooks was called Mailhooks. I wanted to accept email in my application, but I didn't want to deal with email servers. I wanted to get an HTTP POST when an email came in with all the email fields nicely provided as POST parameters. 

This is how I started working with Twisted. Twisted became my main tool to build webhook adapters for existing protocols. I even tried to generalize that idea in a project called Protocol Droid. Slowly I started to grok, and not fear, this kind of programming.

It's funny how my desire to work with abstractions that didn't exist yet to avoid a certain kind of programming was directly responsible for me eventually becoming an expert in that kind of programming. 

Then in late 2009, I had another idea while thinking about webhooks. It would be great if I could expose a local web server to the Internet with a friendly URL. It should just be a simple command. There would have to be a server, but there could just be a public server that you didn't even have to think about. 

I committed [the first prototype of Localtunnel](https://github.com/progrium/localtunnel/tree/prototype) to Github in January 2010. It was written entirely in Twisted. It also didn't actually work. I really recommend taking a look because it was terrible. One of the challenges was multiplexing the HTTP requests into a single tunnel connection. My approach was so naive it just didn't work. As soon as you made more than one request at a time, it broke.

A few months later, I decided to take a different approach. Instead of doing my own protocol, client, and server, I'd just make a wrapper around what I knew already worked: SSH tunneling. This was pretty quick to make happen, and that version is basically what's been in production to this day.

This shortcut came with a lot of weird quirks. For example, the easiest way I found to implement an SSH tunnel client was a Ruby library, so I implemented the client in Ruby. The server, though, was in Python because I still only really knew Twisted for evented programming.

Actually, using SSH was the source of most of the quirks and annoyances. I was pretty bothered that it slowed down the initial user experience by requiring a public key to be uploaded. But most of the pain was operational. The server, sshd, would create a process for every tunnel. Localtunnel also needed its own user and to pretty much own the SSH configuration for that machine. Then, on occasion, something weird would happen where a tunnel would die and the process would go crazy eating up CPU. It would have to be manually killed or it would eventually bring the server to a halt. And, eventually, the authorized_keys file would become enormous from all the keys uploaded. 	

On top of all this, SSH is pretty opaque. It's been around for so long and used so much that it certainly just works ... you just don't really know how. I still don't know how SSH does tunneling or what the protocol looks like, even after trying to read the RFC for it.

By mid-2011, I was working at Twilio building distributed, real-time messaging systems at scale. I certainly came a long way from fearing async network programming. Localtunnel was still running the implementation based on SSH. By then it had quite a large user base and collected a number of bugs and feature requests. I also had my own operations and user experience wish list. With such a huge list of new requirements, so many problems with the current implementation, and a drastically different experience level and mindset, I decided to redesign Localtunnel from the ground up. 

Since I was pretty consumed by Twilio, I didn't have a lot of time to work on Localtunnel. I thought the biggest bang for buck in the long term would be to slowly work on the new version. They say software is never done, but I personally believe software can be finished. It just requires an aggressive drive for simplicity, and the *only* way you can make significant advances in simplicity is through redesign.

In the meantime, users continued to experience issues with the current implementation. These problems only got worse as it became more popular. For example, the biggest issue was that the namespace for tunnel names was too small. Users would get requests from old tunnels, and in rare cases tunnel names would get pulled out from under you while using them. This created confusion and a lot of emails and issue tickets, but it still worked with the occasional restart.

I've used this constant stream of complaints, which has been going on for almost two years, to make sure I keep making progress on the new version. In fact, I'm pretty sure I needed it because of my lifestyle of abundant projects. 

Last week I finally [released a beta of the new version](http://progrium.com/blog/2012/12/25/localtunnel-v2-available-in-beta/). What's interesting is that it's a completely different architecture from what I started out with for the redesign. After the original unreleased prototype, there's been 3 major approaches to implementation. In the coming weeks I'm going to share a more technical history of the architecture of Localtunnel, leading up to a deep exploration of what I hope will be its final form.
