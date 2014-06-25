---
layout: post
title: "Localtunnel v2 available in beta"
description: ""
category: 
tags: []
---
A few years back, I released [Localtunnel](http://localtunnel.com) to make it super easy to expose a local web server to the Internet for demos and debugging. Since then, it's gotten a ton of use. A few people even copied it and tried to make a paid service around the idea. Luckily, Localtunnel will always be free and open source. 

With the release of [Localtunnel v2](http://j.mp/localtunnel-v2), it will not only remain competitive with similar services, but continue to be the innovator of the group. I'll post more on this later.

For now, let's talk logistics. The current, soon-to-be-legacy Localtunnel stack includes the client that you install with Rubygems, and a server that runs on a host at Rackspace. These will continue to be available into 2013, but will be marked as deprecated. This means you should be making the switch to v2.

Besides the fact v1 will eventually be shutdown, there are a number of reasons to switch to v2. Here are some of the major ones:

* It's actively maintained. Bug reports, pull requests, and service interruptions are dealt with promptly.
* No more mysterious requests from old tunnels. The subdomain namespace is much larger.
* Custom subdomains. The new client lets you pick a tunnel name on a first come, first served basis.
* Supports long-polling, HTTP streaming, and WebSocket upgrades. Soon general TCP tunneling.
* No SSH key to start using it. A minor annoyance setting up v1, but it doesn't exist in v2.

One implementation detail that affects users is that the client is now written in Python. This means you won't use Rubygems to install it. Instead, you can use `easy_install` or `pip`. 

	$ easy_install localtunnel

On some systems, you may need to run this with `sudo`. If you don't have `easy_install`, first make sure you have Python installed:

	$ python --version

Localtunnel requires Python 2.6 or later, which comes standard on most systems. If you don't have Python, you can [install it for your platform](http://wiki.python.org/moin/BeginnersGuide/Download). If `easy_install` isn't available after you install Python, you can install it with this bootstrap script:

	$ curl http://peak.telecommunity.com/dist/ez_setup.py | python

Once you've installed Localtunnel with `easy_install`, it will be available as `localtunnel-beta`. This lets you keep the old client to use in case anything goes wrong with v2 during the beta. Eventually, it will be installed as `localtunnel`, but only after v1 is shutdown.  

Using `localtunnel-beta` is pretty much the same as before:

	$ localtunnel-beta 8000
	  Thanks for trying localtunnel v2 beta!
	
	  Port 8000 is now accessible from http://fb0322605126.v2.localtunnel.com ...

Like I mentioned earlier, you can use a custom tunnel name if it's not being used:

	$ localtunnel-beta -n foobar 8000
	  Thanks for trying localtunnel v2 beta!
	
	  Port 8000 is now accessible from http://foobar.v2.localtunnel.com ...

Keep in mind v2 is in active development. There might be some downtime while I work out operational bugs, but you can always use the old version if you run into problems. 

If you do run into any problems, you can [ping me on Twitter](http://twitter.com/progrium). If you get traceback you can [create an issue on Github](https://github.com/progrium/localtunnel/issues). If you have more in-depth questions or want to get involved in development, check out the [Localtunnel Google Group](https://groups.google.com/forum/#!forum/localtunnel).

