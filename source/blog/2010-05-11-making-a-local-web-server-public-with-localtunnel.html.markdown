---
layout: post
title: "Making a local web server public with localtunnel"
description: ""
category: 
tags: []
---
These days it's fairly common to run a local environment for web development. Whether you're running Apache, Mongrel, or the App Engine SDK, we're all starting to see the benefits of having a production-like environment right there on your laptop so you can iteratively code and debug your app without deploying live, or even needing the Internet.

However, with the growing popularity of callbacks and <a href="http://webhooks.org">webhooks</a>, you can only really debug if your script is live and on the Internet. There are also other cases where you need to make what are normally private and/or local web servers public, such as various kinds of testing or quick public demos. Demos are a surprisingly common case, especially for multi-user systems ("Man, I wish I could have you join this chat room app I'm working on, but it's only running on my laptop").

The solution is obvious, right? SSH remote forwarding, or reverse tunneling. Use a magical set of options with SSH with a public server you have SSH access to, and set up a tunnel from that machine to your local machine. When people connect to a port on your public machine, it gets forwarded to a local port on your machine, looking as if that port was on a public IP.

The idea is great, but it's a hassle to set up. You need to make sure sshd is set up properly in order to make a public tunnel on the remote machine, or you need to set up two tunnels, one from your machine to a private port on the remote machine, and then another on the remote machine from a public port to the private port (that forwards to your machine).

In short, it's too much of a hassle to consider it a quick and easy option. Here is the quick and easy option:

    $ localtunnel 8080

And you're done! With localtunnel, it's so simple to set this up, it's almost fun to do. What's more is that the publicly accessible URL has a nice hostname and uses port 80, no matter what port its on locally. And it tells you what this URL is when you start localtunnel:

    $ localtunnel 8080
    Port 8080 is now publicly accessible from http://8bv2.localtunnel.com ...

What's going on behind the scenes is a web server component running on localtunnel.com. It serves two purposes: a virtual host reverse proxy to the port forward, and a tunnel register API (try going to <a href="http://open.localtunnel.com">http://open.localtunnel.com</a>). This simple API allocates a port to tunnel on, and gives the localtunnel client command the information it needs to set up an SSH tunnel for you. The localtunnel command just wraps an SSH library and does this register call.

Of course, there's also the authentication part. As a free, public service, we don't want to just give everybody SSH access to this machine (as it may seem). The user localtunnel on that box is made just for this service. It has no shell. It only has a home directory with an authorized_keys file. We require you to upload a public key for authentication, and we also mark that key with options that say you can only do port forwarding. Although, it can't be used for arbitrary port forwarding... because it's only a private port on the remote side, it can only be used with the special reverse proxy.

So there it is. <a href="http://github.com/progrium/localtunnel">And the code is on GitHub.</a> You might notice the server is in Python and the client in Ruby. Why? It just made sense. Python has Twisted, which I like for server stuff. And Ruby is great for command line scripts, and has a nice SSH library. In the end, it doesn't matter what it's written in. Ultimately it's a Unix program.

Enjoy!
