---
layout: post
title: Beyond Flynn, or Flynn-as-a-Worldview
date: 2014-07-01 15:58 UTC
tags:
---
About five months ago, I finally [wrote about Flynn](http://progrium.com/blog/2014/02/06/the-start-of-the-age-of-flynn/), a project started almost a year ago, but as I described was in the making for much longer. I wanted to give an update on where I am today and set the stage for some upcoming posts on what I've been working on and what I've been learning.

Lots has happened in five months, but first I want to talk about Flynn. There's been some confusion, so I should probably clarify that while I did help start and co-architect Flynn, it's not actually a project of mine. Jonathan and Daniel have been very considerate in allowing me to share ownership conceptually and architecturally, and they treated me as an equal partner as long as they could afford me, but technically I never was. This isn't a problem, it's just a little confusing to some. 

Ultimately, it doesn't matter because Flynn is open source and they're going out of their way to protect the integrity of the project as open source. That's actually why I'm not in the Github organization. The project has rules about maintainers meeting an ongoing contribution requirement. Since I lost the means to work on Flynn in January, I no longer met that requirement, so I'm not listed as a maintainer.

Anyway, what's exciting to me are the ideas and ideals of Flynn architecturally. This is why I've continued to give talks about Flynn at conferences. While the initial goal of Flynn was to be an open source PaaS, the actual scope of Flynn was quite open-ended from there. This is because Flynn is about a new paradigm of infrastructure. 

This new paradigm is what's been in the making for so long. It's the reason I collaborated with dotCloud on Docker, and it's the motivation behind most of my work recently, including Flynn. This paradigm is ultimately what I'm interested in figuring out and building. It's more than Docker, it's beyond Flynn. It's an ecosystem of projects that align with this worldview, that nobody owns, and maybe for the time has no name. But at least people are now starting to see it coming.

For the time, Flynn is the closest thing to embody this paradigm. But there are others like [CoreOS](https://coreos.com), and even [Deis](http://deis.io) have aspirations towards this ideal. While my work is likely to feed back into Flynn and it's possible we'll collaborate closely again in the future, I'm not specifically working on Flynn right now. It's more like R&D for Flynn and Deis and even Docker itself, forging ahead to bring us closer to this world I've been imagining for quite a while.

Alright, so what have I been working on? What's happened since February?

Not long after my last post, I decided to explore an opportunity working with [DigitalOcean](http://www.digitalocean.com). The general premise being, "they want to build some kind of platform layer on top of their VMs, and I can help them build that platform" using Flynn or whatever makes most sense. It seemed like a good vehicle to continue the work I had started, and work with an amazing team and great brand to take it even further.

As a warm-up / get-acquainted project, I decided to take on re-designing the DigitalOcean API. I drafted an initial API design, pushed it through reviews, set up infrastructure for docs and public feedback, and generally got everything moving. Eventually it was handed off since I was not getting anything else done. That API [entered public beta](https://www.digitalocean.com/company/blog/api-v2-enters-public-beta/) last week. 

What we learned in that time, however, was that in the growth chaos that is DigitalOcean's success, DigitalOcean was not clear on what they wanted in terms of an application platform layer. And at the time there weren't enough resources to allocate to it when there was plenty to be done with their existing cloud infrastructure. We came to an arrangement to put my employment on hold as a leave of absence for several months, coupled with sponsorship of my open source work in this space. 

I'm absolutely thankful for this since otherwise I would not be making any progress towards this vision. Instead, I'd probably become that bitter early innovator that would have to leave the industry to avoid the pain of seeing only a shadow of what could have been...

As of right now, the sponsorship is a little past half over. I've been working on as much as I can in this time, but I think now would be a good time to start sharing it all with more context. If you follow me on Twitter or Github, there's been a lot of activity, and some projects have better documentation than others. I'm going to start explaining them in blog posts and hopefully that will also help convey this paradigm of tooling I'm after.

For now, here are links to a few of the projects built and released in this time. Most of them are components for projects I haven't gotten to yet, but that I'm excited to announce soon.

 * [progrium/logspout](https://github.com/progrium/logspout)
 * [progrium/busybox](https://github.com/progrium/busybox)
 * [progrium/execd](https://github.com/progrium/execd)
 * [progrium/configurator](https://github.com/progrium/configurator)
 * [progrium/nginx-appliance](https://github.com/progrium/nginx-appliance)
 * [progrium/ambassadord](https://github.com/progrium/ambassadord)
 * [progrium/docker-consul](https://github.com/progrium/docker-consul)
 * [progrium/docksul](https://github.com/progrium/docksul)

Lastly, Flynn is still in active development towards a stable release since their [preview release in April](https://flynn.io/blog/flynn-preview-release). I still contribute here and there and stay in touch with those guys. I also stay in touch with Deis, CoreOS, and more recently the Hashicorp guys. Really I talk to everybody and anybody doing anything vaguely related to what I'm after because it's important we're all moving in roughly the same direction, and I can only build on the shoulders of giants.