---
layout: post
title: "Notify.io brings notifications to the web"
description: ""
category: 
tags: []
---
> **Update:** Notify.io is currently out of service as it is being re-imagined in
> smaller pieces based on open standards. Contact me for more
> information.

In October 2009 I started a project called [Notify.io](http://www.notify.io/) and a month later announced it. I talked about how it will bring notifications to the web. Now that it's basically alpha complete, I'll give you a quick walkthrough of what makes it so great.

<center><iframe width="560" height="315" src="http://www.youtube.com/embed/Fs9NauQ2M6o" frameborder="0"> </iframe></center>

### Overview
At a really high level, you can think of Notify.io as a notification router. As a web service, it provides a singleton endpoint for any web-connected program, whether a web application, desktop application or user script, to send notifications to somebody. For users, you can control what notifications you get and how you get them. In this way, Notify.io is like a global, web-accessable version of the popular [Growl](http://growl.info/) application for OS X (which should honestly just ship with OS X). Only it's even better.

### Desktop Notifications
The original inspiration for Notify.io was to make Growl more useful by fixing its ability to receive notifications from the Internet. Out of the box, Growl is effectively only good for notifications from sources running on your machine. If you wanted to get notifications from a web app, you'd have to wait for them to release a desktop notifier, which hopefully would use Growl to actually display the notifications. So you end up with all these desktop notifiers running for some apps, and have no option of desktop notifications for others.

This is probably the killer feature of Notify.io: it lets you get desktop notifications from any web app that supports it, which is an order of magnatude easier for them to do than build their own desktop notifier.

### Sources and Outlets
The language of Notify.io is based around Sources and Outlets. Sources are pretty straightforward. They're a source of notifications. They could represent an application, script, company, person (or perhaps object?) that can send you notifications.

Outlets repesent the other major feature of Notify.io. They're ways you can get a notification. The Desktop Notifier is your first and default outlet, but is just one of several options. Currently supported Outlets besides Desktop Notifier are Email, Jabber IM, and Webhooks. Outlets to look forward to are SMS, Twitter, IRC, and perhaps telephone.

The magic is in routing notifications from Sources to Outlets. Currently this is a simple mapping of Source to Outlet. For example, you can get notifications from Source A on your desktop, while notifications from Source B go to IM. This simplistic routing is just the beginning. We'll talk about how we'll do advanced routing when we get to the Roadmap.

### The Nio Client
For developers, it's worth mentioning that the pipe for our Desktop Notifier is really just a Comet HTTP stream. It can be consumed by pretty much anything. We were originally talking with Growl and authors of other desktop notifiers of direct integration. This is still a possibility, but just so we could move forward, we built our own client for OS X. Clients for other systems are available (but not yet "officially" supported) or are in progress, including Windows and Android.

Our OS X client is called Nio, short for Notify.io, so you can pronounce it N-I-O, but I tend to pronounce it "neo". It's basically just an application that sits in your menu bar listening to HTTP streams (yes, plural) for notifications and pipes them into Growl.

For ease of installing streams, we made it handle files of the extension ListenURL. Once Nio is installed, you can download a ListenURL file containing a URL and it gets installed by Nio. The URL we give you is basically a "capability URL" or secret URL. This means streams are not super secure, but this is by design. If you wanted, you could share your URL with somebody so you both get notifications sent to that Outlet. You can always delete the Outlet and make another to disable that URL.

The other cool thing about our client is that it has a shell script notification hook. This means you can have notifications trigger a shell script that's passed the notification details. This is pretty powerful because it means you can do things like create your own local logging, hear your notifications with text-to-speech, or make certain notifications trigger a more obstrusive means of notifying you, such as Quicksilver's Large Type feature. This kind of programmability is central to our approach to design, as you'll see later on in the Roadmap.

### Simple API and Approval Model
For proper adoption, we need web apps to integrate Notify.io, so we have a super simple API for Sources. It's a simple REST API based on an endpoint constructed by the target of your notification. Like [Gravatar](http://en.gravatar.com/), we use an MD5 hash of a user's email address to identify targets. For example, to send a notification to test@example.com, you'd do an HTTP POST to this URL:

    http://api.notify.io/v1/notify/55502f40dc8b7c769880b10874abc9d0

You'd pass a few parameters, with at least your API key (meaning you need an account) and the text you want to send, and optionally an icon URL, link URL, title text and whether the notification should be "sticky". That's it. The request should respond immediately so it may be quick enough to be done inline in your app, but we recommend it be done asynchronously.

Then what happens is the first notification you send actually triggers a notification to that user that you want to send them notifications. If they accept, future notifications will be sent and your previous notifications will show up in their history. This may change to replay previous notifications on approval, but the point here is the user has to approve notifications before they get them. In this way, it's similar to Jabber's approval model and helps avoid spammers.

### Public Service Software
[Notify.io and its clients are open source](http://code.google.com/p/notify-io/). The service is free. Or rather, it's not-for-profit donationware. Notify.io is being run under a model I'm developing called POSS, the goal of which is to automate/abstract away the maintainence and funding of its operation. The end result should be: the service exists, it's open source, and some in the developer community can deploy changes. But no single person is financially responsible for it, and it's run on maintained cloud infrastructure. In this case it's mostly App Engine.

This means that Notify.io is not a startup. It's public infrastructure. Ideally, I'm not even in the loop. It should be a self-sustaining public service. This is not fully realized, but it will be as it starts to consume more resources. For more information, you can [read more](http://blogrium.wordpress.com/2009/10/29/public-open-source-services/) on POSS or [join our discussion group](http://groups.google.com/group/poss-talk).

For now, the important thing is that Notify.io is open source. This means anybody can contribute bug fixes, new outlets, new desktop clients, etc.

### Roadmap
Okay, sure, Notify.io is pretty cool now. But here are some of the major things that will be coming soon. Hopefully with your help!

*Advanced Routing and Filters*<br />
From the beginning, I wanted really powerful routing and filtering. My evangelism of webhooks has given me the obvious answer to this, but in a more integrated way. Basically, how do you allow any routing scheme imagineable by users? Let them write code. Originally it was going to be powered by [Scriptlets](http://www.scriptlets.org/), but since I split the eval engine out as [DrEval](http://github.com/progrium/DrEval), it will be based on that.

Basically, just a imagine a UI with a little textarea for writing JavaScript that can make web calls. Route notifications based on your IM status, your location, what music you're listening to, arbitrary time schedules, or anything you can code.

*More Outlets*<br />
Obviously, more Outlets are good. Obvious ones are IRC, SMS, and Twitter DM. With Twilio we can do voice call notifications. Integration with push clients like the iPhone's Prowl app would be easy to do. Our outlet system is very simple, so you can [look at the source of our existing ones](http://github.com/progrium/notify-io/blob/master/www/outlet_types.py), write an outlet and it's likely we'll deploy it.

*OpenID Support*<br />
Right now, you authenticate with Google. I don't believe in creating authentication systems, and Google was the quickest given the platform. It's also pretty popular and ensures you have an email address we can use. However, there are plenty of people that don't like the idea of using their Google Account, so at some point we'll support OpenID login and then go from there.

*Multiple Email Support*<br />
Ideally, a web app can use whatever email address you used to register with them to send you notifications. However, unless Gmail is your primary email you use for registration, they'll still need to ask you for your email. It's the Gravatar model. So like Gravatar, we'll need to let you add multiple emails to your account, allowing web applications to be able to send notifications based on any of them.

*Convenience Libraries*<br />
Our API is simple, but people are lazy. We're currently working on convenience libraries for popular langauges that it make that much easier to integrate with Notify.io. If you use a neat language, you should make a libnio package for it!

*Ad-hoc Sources*<br />
Sources require an account, which is a bit heavyweight. Sometimes you want to create your own distinct sources to share with others or use in your scripts to easily send yourself notifications. This is the idea of Ad-hoc Sources, inspired by David Reid and capability URLs. The idea is simple: create an ad-hoc source and you get a secret URL. This URL acts just like the notify API endpoint, only you don't need an API key. You can use this in public scripts or give it to others to send you notifications, and if it's ever abused or falls in the wrong hands, just delete it and make another.

*More Supported Clients*<br />
A developer in Japan started a Windows client based on Nio that we're planning to support as our primary Windows client. Another developer is working on an Android client. iPhone users have Prowl, so once there is a Prowl outlet, you can get them on your iPhone. But Prowl is not free, so perhaps it would be helpful if we had our own iPhone client. There are the beginnings of a Linux/libnotify client. These are all ways you can start contributing to Notify.io. ;)

That's about it. You can probably see why I describe Notify.io as the open notification platform of the web. It's simple, powerful, and open source. It's come a long way in just 3 months thanks to the contributions of Abimanyu Raja, Amanda Wixted, Mike Lundy, David Reid, Christopher Lobay, Hunter Gillane, Nakamatsu Shinji, and everybody that's given user feedback so far.
