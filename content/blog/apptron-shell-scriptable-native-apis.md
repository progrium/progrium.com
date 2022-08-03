---
title: "Apptron Demo: Shell Scriptable Native APIs"
date: "2022-08-03"
draft: false
description: "In this demo I show off the rest of the Apptron CLI, which exposes most of the cross-platform APIs as commands."
cover: "https://i3.ytimg.com/vi/UHFS4STFYXM/maxresdefault.jpg"
---

{{< youtube id="UHFS4STFYXM" >}}

In this demo I show off the rest of the [Apptron](https://progrium.com/blog/apptron-announcement/) CLI, which exposes most of the cross-platform APIs as commands. These commands make great shell scriptable utilities, and you can see how they've been designed to facilitate this. By the end, we'll have created an app indicator (systray) icon and menu that's created and driven by a shell script.
<!--more-->

There is a whole class of power users that doesn't always want to take the time to "write a program," let alone learn how. Since the functionality is right there, why not expose it in a way that's useful for these folks? Sysadmins and devops engineers often spend most of their time at a command prompt, so this feature goes out to all of them.

It turns out having a CLI interface to the APIs also makes it easy to do basic regression testing for the project. It also provides a kind of accessible listing of functionality. And! It helps with our polyglot primitive goal, working as a stopgap before having native library support for a language, since nearly all languages can "shell out". 

As I mentioned in the video, this is a strategy I like to use when making generative primitives: maximize utility by providing multiple ways to access features. Like being language agnostic, this helps meet users where they are, and reach users you might not otherwise. There's also often a dominant context people think of for some functionality, so showing it in a new or surprising context helps break people out of existing thought patterns and imagine new possibilities. 

Let's see what possibilities open up with the next demo! In the meantime, [join early access](https://tractor.dev/apptron/) to explore Apptron on your own.

-jeff

