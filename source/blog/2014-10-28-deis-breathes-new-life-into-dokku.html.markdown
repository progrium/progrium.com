---
layout: post
title: Deis Breathes New Life into Dokku
date: 2014-10-28 01:35 UTC
tags:
---

Today I'm excited to announce that [Dokku](https://github.com/progrium/dokku) is now sponsored by my friends of the [Deis](http://deis.io/) project. This means that [OpDemand](http://opdemand.com/), the company behind Deis, will be funding part-time development of Dokku and its components.

## Remember Dokku?

A little over a year ago, [I announced Dokku](http://progrium.com/blog/2013/06/19/dokku-the-smallest-paas-implementation-youve-ever-seen/) as an open source "Docker powered mini-Heroku." It quickly became the first killer application for Docker. Designed to be simple and hackable, Dokku enables web developers to run their own single-host PaaS that's directly compatible with Heroku.

As the project took off, I went on to tackle the challenges of a multi-host PaaS with the [Flynn](https://flynn.io/) team. Even without me, the Dokku community continued to grow, thanks to the help of new maintainers and contributors. The experimental plugin system allowed all sorts of customizations and extensions of Dokku to flourish.

Over time, though, the wonderful volunteer maintainers of the project started to get burnt out. Handling issues across a dozen language runtimes and even more plugins is taxing. Many were upstream buildpack or Docker issues, or larger inherent problems of the project requiring stronger leadership to resolve.

Although Dokku is still used and loved today, without active maintainership and leadership, it was at risk of "bit rot". I came to the conclusion that it was in need of some love from the original author. Luckily, the Deis team was willing to help make this happen and is effectively saving the project from a slow death.

## About Deis

Not long after I started collaborating with the Flynn team, another project called Deis came onto the scene. Both projects have the goal of being enterprise grade, multi-host PaaS solutions. Although technically competitive, as open source projects composed of great people, we openly share information and components. As an independent agent, I try to bridge silos and facilitate that kind of sharing and communication. I'd gone out to visit both teams to collaborate, talk shop, and have fun.

I eventually moved on from Flynn and started independently exploring distributed systems components in a Docker world. Deis continued to adopt and support many of my open source components. They always kept an open dialog with me and others in the Docker community. When I mentioned my plans to reinvigorate Dokku, they were quick to offer help.

## The Sponsorship

The timing for this sponsorship is perfect. Deis now requires at least 3 hosts in a cluster, making Dokku the obvious recommendation for smaller deployments. The projects will focus on shared components even more. This sponsorship will also ensure a smooth migration to Deis if a Dokku user wants to go down that path.

What is Dokku expected to get? First, time and thought put into getting the project modernized and on path for a solid 1.0 release. Among other things, this involves redesigning aspects of the project to make it more sustainable as an open source project.

Much of the lessons of Flynn and Deis, as well as reflections on Dokku itself, will feed back into Dokku. My plan is to: 

 * make it more robust and testable 
 * improve code quality and standards 
 * properly direct upstream issues upstream 
 * improve documentation and basic support processes
 * add popular features, such as addons and Dockerfile build support

And if you can believe it, I plan to make it more modular and even simpler.

## Yay, Dokku!

Along with Deis, I want to thank all the [contributors](https://github.com/progrium/dokku/graphs/contributors) and maintainers involved in Dokku. I especially want to thank asm89, rhy-jot, plieter, fcoury, and josegonzalez. The project would already be dead without them. If you want to get involved, I'll generally be in the `#dokku` channel on Freenode sharing updates as I progress. Most of my work will be in a new branch, but first it will take place in creating and updating components used by Dokku.

I'm only able to put a day or so of hours a week into the project, but steady, consistent effort and help from the community will ensure Dokku will be around for a long time!

