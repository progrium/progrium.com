---
layout: post
title: "Piping into and out of the cloud with skypipe"
description: ""
category: 
tags: []
---
[Skypipe](https://github.com/progrium/skypipe) is a magical command line tool that lets you easily pipe data across terminal sessions regardless of whether the sessions are on the same machine, across thousands of machines, or even behind a firewall. It gives you named pipes in the sky and lets you pipe data *anywhere*. 

I built it while on vacation the last couple months. I wasn't intending
to write software while on my trip, but I just couldn't help myself.

Skypipe is conceptually similar to named pipes or netcat, but with more power and a simpler interface. Here is a basic example using skypipe as you would a regular named pipe to gzip a file across shells:

	$ skypipe | gzip -9 -c > out.gz

Your skypipe is now ready to receive some data from another shell process:

	$ cat file | skypipe

Unlike named pipes, however, *this will work across any machines connected to the Internet*. You don't have to specify a host address or set up "listen mode" like you would with netcat. In fact, unlike netcat, which is point to point, you could use skypipe for log aggregation. Here we'll used named skypipes. Run this on several hosts:

	$ tail -f /var/log/somefile | skypipe logs

Then run this on a single machine:
	
	$ skypipe logs > /var/log/aggregate

This can also broadcast to multiple hosts. With the above, you can "listen in" by running this from your laptop, even while behind a NAT:

	$ skypipe logs

You can also temporarily store data or files in the pipe, even several files, until you pull them out. On one machine load some files into a named skypipe:

	$ cat file_a | skypipe files
	$ cat file_b | skypipe files

Now, from somewhere else, pull them out in order:

	$ skypipe files > new_file_a
	$ skypipe files > new_file_b

Lastly, you can use skypipe like the channel primitive in Go for coordinating between shell scripts. As a simple example, we'll use skypipe to wait for an event triggered by another script:

	#!/bin/bash
	echo "I'm going to wait until triggered"
	skypipe trigger
	echo "I was triggered!"

Triggering is just sending an EOF over the pipe, causing the listening skypipe to terminate. We can do this with a simple idiom:

	$ echo | skypipe trigger

### How does this magic work?

You'll need a free [Dotcloud](https://www.dotcloud.com/) account to use skypipe, but you don't need to know anything about using Dotcloud to use skypipe. 

When you first use skypipe it will want you to run a setup command (`skypipe --setup`). This will deploy a very simple messaging server to Dotcloud. From then on, skypipe will use your account to transparently find and use this server, no matter where you are. The server is managed automatically and runs on Dotcloud free of charge, so you never need to think about it.

### Software with a service! 

This is a new paradigm of creating tools that transparently leverage the cloud to create magical experiences. It's not quite software as a service, it's software *with* a service. Nobody is using a shared, central server, and no one needs to setup or manage their own server. The *software* deploys and manages its own server for you.

Thanks to platforms like Heroku and Dotcloud, we can now build software leveraging features of software as a service that is *packaged and distributed like normal open source software*.

I'm excited to see what else can be done with this pattern. Naturally, I'm already thinking about a number of other potential uses.

### Using skypipe and getting involved

Skypipe is still an alpha piece of software. Be warned, there are some rough edges. That said, you can install skypipe with pip:

	$ pip install skypipe

The user experience is not yet entirely optimized. One of the biggest issues is that it needs to check for the server on every use. This can be done less often and cached, which would make it much snappier and on par with most command line utilities. 

This and a few other issues are already tracked in [Github Issues](https://github.com/progrium/skypipe/issues); feel free to take a whack at them. The codebase is intentionally small, documented, and written to be read, although there are no tests yet. 

The project also depends on ZeroMQ, which requires a C extension to be compiled. Even using the pyzmq-static package, you still need certain header files (python.h at the very least) to install skypipe, and not every environment has these. Ideally, I'd like to find a way to package skypipe in a way that includes all its dependencies. Perhaps [PyInstaller](http://www.pyinstaller.org/) can help with this.

Another feature I'm sure a lot of people will want (or complain about) is being able to run your own server and ignore the software with a service aspect. Since the server is packaged with the client, this is not far off from happening. Somebody just needs to make it happen. 

Contribution ideas aside, I'm hoping skypipe will be useful to others besides myself. I was really going for a magical tool. I think a big part of this magic is the use of software with a service, which I consider a bit novel in itself. What do you think?  
