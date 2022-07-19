---
title: "Apptron Demo: Zero Config HTML5 Native Apps"
date: "2022-07-19"
draft: false
description: "In this demo I use the Apptron build command to create an executable from a single HTML file. No setup, no configuration."
cover: "https://i3.ytimg.com/vi/7zsCQGOEBRU/maxresdefault.jpg"
---

{{< youtube id="7zsCQGOEBRU" >}}

In this demo I use the Apptron build command to create an executable from a single HTML file. No setup, no configuration. If you want to change how the window looks, you can add a meta tag to your HTML file. It's not only simple, it's fast.
<!--more-->

The way this works is actually similar to the last demo where we built a simple Go application to host our webview app, except Apptron is building it for us. Unlike all other commands of Apptron, this build command does have a dependency, which is the Go compiler. Luckily, this compiler is also a self-contained tool that's easy to install on any platform. 

At some point, I'd like to try embedding the Go compiler with Apptron, but this does introduce some complexity I don't want to take on just yet. However, if anybody is interested in making this happen, please join early access so you can help us make Apptron great.

Speaking of help, this demo avoids talking about something that's somewhat necessary on modern platforms: signing. If you've ever downloaded an executable on Windows, I'm sure you've gotten a giant alert asking if you really want to run it. This is because it's an unsigned executable, which means it can't be proven to not be tampered with by a non-author. Platforms are getting stricter and stricter about this.

On Mac, you have to not only sign but notarize your executable before another Mac will be allowed to run it. This is a tricky process that can be done on your own with an Apptron built executable, but I have preliminary tooling to help with the process. The same tooling can also bundle up your executable into a Mac app bundle. 

However, I need help getting these last mile features in. So please consider [joining early access](https://tractor.dev/apptron/), not only to try Apptron, but if you have the experience, to help us finish these core features before it debuts as a public open source project. 

See you with the next demo!

-jeff
