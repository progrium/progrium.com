---
layout: post
title: "Viewdocs: Hosted Markdown project documentation (finally!)"
description: ""
category: 
tags: []
---
A huge part of the user experience for open source software is the documentation. When writing new software to be adopted, I've learned it's more important to first write decent docs than tests. And when I forget, [Kenneth Reitz](https://github.com/kennethreitz) is there to remind me. 

When I've outgrown a README on Github, I only consider two options for providing documentation: [Github Pages](http://pages.github.com/) and [Read the Docs](https://readthedocs.org/). Unfortunately, I have problems with both of them. Chiefly, Read the Docs makes me use reStructured Text, and Github Pages means maintaining a separate orphan branch and using a static page generator. 

What I've really wanted is something like [Gist.io](http://gist.io/), but for my repository. Nobody has stepped up, so I built it. 

I call it [Viewdocs](http://progrium.viewdocs.io/viewdocs). It renders static pages on-demand from Markdown in your project's docs directory. There's no setup, just follow the conventions and it works. It may even already be working for you, since Markdown in a docs directory is not that uncommon. And keeping your documentation in the same branch as your code means it's easier for people to contribute docs with their pull requests. 

The default layout is borrowed from Gist.io, giving you a clean, elegant documentation site. All you have to do is write some Markdown. That's about all there is to it. 

You can read more on the [homepage for Viewdocs](http://progrium.viewdocs.io/viewdocs), which is powered by Viewdocs. Or here's a quick video introduction:

<iframe src="http://player.vimeo.com/video/79066808" width="700" height="394" frameborder="0" webkitAllowFullScreen="webkitAllowFullScreen" mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen">No iFrames?</iframe>