---
title: "Apptron Demo: HTML5 Background Apps"
date: "2022-08-16"
draft: false
description: "In this week's demo I build a background application using HTML and Apptron."
cover: "https://i3.ytimg.com/vi/i9nNUOHF7G4/maxresdefault.jpg"
---

{{< youtube id="i9nNUOHF7G4" >}}

In this week's demo I built a background application using HTML and [Apptron](https://progrium.com/blog/apptron-announcement/). It may seem weird to involve a webview at all for a background app, which is why this was not a use case I had planned, but I was pleasantly surprised to discover how this turned out.
<!--more-->

In the last demo, we made an app indicator background utility as a shell script. This week we re-create it using JavaScript in an HTML file. With `apptron build` we can make it into a standalone executable. This workflow was originally intended for quick webview apps, but because we can let the JavaScript of the page run while the window is hidden, we effectively get a background application. 

Apptron wasn't made just for webview apps. I wanted to expose other native APIs that let you hook into more pre-built UI elements the operating system provides. For now this covers the common ones like app indicators, dialogs, and desktop notifications. In the future I'd like to expose APIs to let you add new items to system menus, control panels, and other places the OS lets developers hook into. These are important to make scriptable so you can easily leverage them for simple workflow hacks. When it's easy to throw that kind of thing together, you don't need to find "an app for that," you can just imagine what would work for you and make it happen.

If this is also a world you want to see, [join Apptron early access](https://tractor.dev/apptron/) and help us get this thing out. See you next demo!

-jeff