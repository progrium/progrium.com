---
title: "Apptron Demo: CSS Themed Windows"
date: "2022-10-06"
draft: false
description: "In this week's demo I show an experimental feature of Apptron for easy window theming."
cover: "https://i3.ytimg.com/vi/4fjblMTvVh0/maxresdefault.jpg"
---

{{< youtube id="4fjblMTvVh0" >}}

In this demo I show an experimental feature of [Apptron](https://progrium.com/blog/apptron-announcement/) that lets you customize the window frame using HTML and CSS. This allows us to create re-usable themes. Apptron even comes with a few builtin. 

<!--more-->

Being able to customize the frame of your window is not new. With Electron you can create a "frameless" window, giving you a blank frame to populate with your webview. However, now you have to make sure you have all the basic window controls users expect. It also ties that window frame to the rest of your UI web code. What this Apptron feature does is make the window frame a separate HTML context that you can define or set with a pre-existing theme. 

As I mentioned, this is experimental. Right now it requires and uses an iframe in the theme HTML to show what you normally expect in your webview. We can replace this with a separate native webview positioned where the iframe would normally be. I'd love it if somebody wanted to help make this happen.

However, there are other ways you can contribute. I'd love to have more built-in themes for users to play with. They don't have to be retro throwbacks, but more of those are welcome, too!

[Sign up to join early access](http://tractor.dev/apptron/) if you're interested in using or contributing to the project. This is the last demo for now, but I'll be back soon with not only more Apptron, but more exciting projects.

-jeff
