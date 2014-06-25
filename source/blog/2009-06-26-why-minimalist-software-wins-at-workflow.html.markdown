---
layout: post
title: "Why minimalist software wins at workflow"
description: ""
category: 
tags: []
---
Recently I've been evaluating software to help support agile/scrum development on our team, and ideally to roll into our NASA Code product for others to use. We're already married to [Trac](http://trac.edgewall.org/), so we've been playing with [Agilo](http://www.agile42.com/cms/pages/agilo/) and are looking at some of the other agile plugins for Trac. Unfortunately they're all so heavyweight, despite some that claim not to be.

I came back to a realization I'm sure a lot of us have had: most software sucks. Especially software that's intended to augment some real-life process. When asking friend/colleague [Timothy Fitz](http://timothyfitz.com) about recommendations on agile tools, he said: "A board and post-its. Seriously."

This is part of the reason most enterprise software sucks so terribly. Enterprise is about lots of real-life process and workflow, and given that process augmentation software even in small doses generally sucks, large amounts of it will suck exponentially.

A lot of us have learned that less software is more effective. One major attraction of Trac was their goal of staying out of the way through minimalism. The trick with minimalism, in general, is knowing what's actually important; the essence of the message or design. This is a big part of my design process. Asking, "How can I fold these requirements into fewer features and UI?" instead of directly implementing a feature for every requirement.

The other thing about minimalism is that, like abstraction (another form of compression), everything you leave in the design makes such a huge difference. In programming, when you make abstractions, you're deciding what you can assume. This means abstractions can go in different directions depending on the assumption requirements of what's going to use the abstraction. The risk with minimalist software is that a simple design choice can drastically change the direction of the abstraction and make or break whether the software fits your needs.

Luckily, minimalism buys you a sort of abstraction that can enable projection. By this I mean that users can project their actual process and workflow onto the software. If it doesn't have features that impose a particular process, users are free to do what works for them. This is why wikis are so powerful.

Coming back to Timothy's "a board and post-its" remark, why do you even need software? If you can do it without software, why would you want to bring software in to slow things down?

Software does have a couple strengths. First, it encodes process in way that means you can automate parts of it. Nobody has to worry about manually typesetting when using a word processor. Second, it persists and organizes information that would normally be lost in handwritten notes, or worse, somebody's head. The trick is getting these advantages without getting in the way.

A naive approach to software design is thinking that perfectly modeling a system, such as your development process, is the way to good software. I used to think this. It sounds great because then you can programmatically reason about every aspect of the system. But in the real-world, no two systems are exactly alike. In fact, a given system can change quite a bit in its lifetime. So there's really no point to modeling systems with that kind of precision.

However, I'm seeing a lot of this in agile/scrum software. Requirements have stories, stories have tasks, organized into iterations and releases. CRUD for every noun mentioned in scrum. This on top of abstractions in a direction different than we need. Numbers where it doesn't really matter. Nice pie chart breakdowns we'll rarely use. Top it off with horrible UI, since with all these features there isn't time to make them easy to use.

Honestly, [Pivotal Tracker](http://www.pivotaltracker.com/) seems to have the best abstraction of agile. It folds requirements, stories and tasks into just stories. It automatically and dynamically creates iterations and calculates velocity. It keeps you on a single page, keeping you focused on what's important.

Unfortunately, we can't use Pivotal Tracker since we'd need it on our servers and the licensing they offered doesn't scale if we want to essentially give it away as part of NASA Code. It's likely I'll want to just start nudging Trac in the right direction using Pivotal Tracker as a model reference, pulling together code from Agilo and other plugins. If there's one thing that complements minimalist design, it's an extension architecture, and Trac has an excellent plugin system.

Anyway, as far as augmenting process and workflow, I've always liked the idea of starting with a wiki and lazily formalizing the process into custom software as needed. As long as you can keep it under control, mind your requirement abstractions, and avoid writing too much software.
