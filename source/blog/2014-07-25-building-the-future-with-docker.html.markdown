---
layout: post
title: Building the Future with Docker
date: 2014-07-25 00:11 UTC
tags:
---

Before Docker, a handful of colleagues and I were dealing with a typical service-oriented system on EC2. It was typical in that it was quite far from ideal. Deploying components took too long. Getting new components in production was a nightmare. It was resource inefficient and harder to manage than it needed to be. It was big and complicated, and tightly-coupled in all the wrong places. It was hard to make changes to, especially removing legacy and broken code. Every component was different. Developers could only run a few components at a time locally, which was nothing like production. System-level integration testing was near impossible. On and on...

We built and scaled individual components and solved individual problems to satisfy product requirements. As such, the company continued to be successful. But the system as a whole, which had the most influence on the developer and operator experience, was not improving fast enough to keep up.

We sat down and started to just sketch out ideas of what an ideal system would look like. What would the perfect developer experience be like? How could you keep operators from falling into reactive mode? What would facilitate developers and operators to better work together? What infrastructure would you need to employ everything we knew to be best practice? What were large-scale systems like Google and Twitter doing for these that we weren't? How could you collapse these requirements into the simplest system possible?

For the past three years, I've been focusing on building and refining that ideal system. The full picture is still only in my head, but over time it's been getting validated as new tools come out, either by me or by others. It's been further validated and refined as I talk and work with various companies, both providers and consumers in this space. 

It turns out the ideal involves a different way of thinking about systems than common system architecture and operations. Though, it's not *so* different from the way modern large-scale systems like Netflix and Google have evolved. The difference is in simplicity, orthogonality, and, most important, the overall experience design. 

I don't just have a system in mind, I have particular kind of experience with that system in mind. 

I played a very minor role in the creation and success of Docker. To me, it was the first necessary, and maybe most pivotal component in making a reasonable approximation of this ideal system. Docker doesn't solve every problem, but it's not supposed to. It is the meta-primitive needed to build the rest of the primitives for this system. Docker is huge, but it's just the foundation.

I don't know how far I'll be able to take this obsessive drive to flesh out the rest of this ideal system. Luckily, I've found a lot of supporters that have sponsored my work in various ways. Without them, I would likely not even be working on these types of technologies.

Anyway, a couple weeks ago [CenturyLink Labs did an interview with me](http://www.centurylinklabs.com/the-future-of-docker/) that captures a slice of the specifics in what I'm talking about. It covers some history, but it also gets into my roadmap, which I'm hoping to share more details on in upcoming posts. The big milestone for me is Manifold. As a stepping stone, the project Consulate should have a big impact in the Docker community. Some of the other projects mentioned like Duplex and Configurator are also just as important to me. 

<iframe width="640" height="360" src="//www.youtube.com/embed/aBgObyaNkdc" frameborder="0" allowfullscreen></iframe>