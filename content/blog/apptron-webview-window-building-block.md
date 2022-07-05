---
title: "Apptron Demo: Webview Window Building Block"
date: "2022-07-05"
draft: false
description: "In this demo, I use the Apptron API from Go to build a simple birthday card application defined by HTML and CSS."
cover: "https://i3.ytimg.com/vi/XU-vrmA7j4U/maxresdefault.jpg"
---

{{< youtube id="XU-vrmA7j4U" >}}

In this demo, I use the [Apptron](https://progrium.com/blog/apptron-announcement/) API from Go to build a simple birthday card application defined by HTML and CSS.
I also explore the architectural approach of Apptron compared to directly working with platform native APIs.

To expand on the demo, in this post I'll discuss some of the motivation behind this project. There are a few reasons why I made Apptron.
<!--more-->

I've always loved the option of using HTML5 in webviews to build cross-platform native app UIs. Native controls
definitely have their benefit, but become tricky to do consistently across platforms. Rendering the UI the way a game
would with a GPU accelerated render frame is consistent across platforms, but usually means you have to invent your GUI
paradigm from the ground up. Using a webview gets you general consistency across platforms, while also getting a well
known paradigm for building user interfaces. It also comes with the largest ecosystem of frameworks and pre-built components
that can generally be used together, and is constantly improving as the web evolves. It's not always the best approach,
but it's a nice option to have.

Using a webview for desktop UI is not new, but was not a well known practice until Electron. I'm pretty sure significant
chunks of UI in Windows as far back as Windows 95 were actually webviews. Recently, I was surprised to discover some parts of 
macOS today are actually using webviews. But Electron popularized it by focusing on the cross-platform benefit and riding 
on the initial success of Node.js, empowering JavaScripters to do more than they ever could before.

Today, Node.js is considered by many, including its author, a bit of a mistake. This is a complex thing to explain, but for me it has a lot to do with the culture of dependencies and complexity in that ecosystem. So if you explicitly don't want to use JavaScript, or maybe just avoid Node.js and NPM, you don't have much choice when it comes to easily making webview based apps.

Luckily, we've been seeing alternative frameworks for a couple different languages recently. Unfortunately, any language-specific framework is limited to that language. This has always frustrated me as a polyglot programmer. Broad approaches to software design shouldn't be silo'd off to specific languages, even though obviously you have to pick one for an implementation.

It's also frustrating to see how complex these full service frameworks become. At their core, they're just re-exposing platform APIs, but they end up being full-fledged platforms of their own. Keep in mind, it's not just webviews and windows, there are a bunch of platform APIs for features across all major platforms that you might want to use. Native menus, dialogs, notifications, etc. If you wanted to use one of these in a script or simple program, Electron immediately feels like overkill.

Depending on your language, you may find one-off libraries for these cross-platform native features. A library for webviews, a library for desktop notifications, etc. The problem there is when you want to combine them. Not only are these libraries usually going to be fairly inconsistent in their design, if they even exist, but because of the nature of platform APIs, they often need to set up an event loop and take over the main thread. This makes them difficult if not impossible to use together. 

With all this in mind, it seemed the only option was to build a language-agnostic bridge to cross-platform APIs. Apptron uniquely sits somewhere between a full framework like Electron or Tauri, and small one-off libraries you might find for specific APIs. It can be used like a library, a tool, or a micro-framework, but it's small and self-contained. This is why I describe it as a software primitive or building block. 

I hope Apptron is compelling, and I'd like to invite you to [try it out in early access](https://tractor.dev/apptron/). In the meantime, more demos are on the way.

-jeff