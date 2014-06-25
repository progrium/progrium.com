---
layout: post
title: "Dokku: The smallest PaaS implementation you've ever seen"
description: ""
category: 
tags: []
---
[Dokku](https://github.com/progrium/dokku) is a mini-Heroku powered by Docker written in less than 100 lines of Bash. Once it's set up on a host, you can push Heroku-compatible applications to it via Git. They'll build using Heroku buildpacks and then run in isolated containers. The end result is your own, single-host version of Heroku.

Dokku is under 100 lines because it's built out of several components that do most of the heavy lifting: Docker, Buildstep, and gitreceive.

 * [Docker](http://www.docker.io/) is a container runtime for Linux. This is a high-level container primitive that gives you a similar technology to what powers Heroku Dynos. It provides the heart of Dokku. 
 * [Buildstep](https://github.com/progrium/buildstep) uses Heroku's open source buildpacks and is responsible for building the base images that applications are built on. You can think of it as producing the "stack" for Dokku, to borrow a concept from Heroku.
 * [Gitreceive](https://github.com/progrium/gitreceive) is a project that provides you with a git user that you can push repositories to. It also triggers a script to handle that push. This provides the push mechanism that you might be familiar with from Heroku. 

There are a few other projects being developed to support Dokku and expand its functionality without inflating its line count. Each project is independently useful, but I'll share more about these as they're integrated into Dokku.

For now, here's a screencast that shows how to set up Dokku, along with a quick walk-through of the code.

<iframe src="http://player.vimeo.com/video/68631325" width="700" height="394" frameborder="0" webkitAllowFullScreen="webkitAllowFullScreen" mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen">No iFrames?</iframe>

