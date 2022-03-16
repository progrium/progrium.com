---
title: "Progrium Technology Thesis"
date: 2022-03-15T12:00:00Z
draft: false
---
{{< youtube id="yKZ15O7zeHY" >}}
*Video transcript:*  

Creating software is too complicated. Our options are overwhelming, our tooling is too bloated, and things rarely ever "just work".

<!--more-->

8 years ago, the late Joe Armstrong, co-creator of Erlang, gave one of his last talks at the 2014 Strange Loop conference. It was titled "The Mess We're In" and talked about the increasing over-complexity of software. "Software entropy increases with time," he said, "we need to reverse entropy." He said in his conclusion:

"Computing was about controlling complexity, and we have failed miserably." 

An echo of what Djikstra said in the _90s_: "It is time to unmask the computing community as a Secret Society for the Creation and Preservation of Artificial Complexity."

Alan Kay, another computing pioneer, has a great word for this "artificial complexity": complication.

"The amount of complication [in software today] can be 100s, maybe 1000s of times more than the inherent complexity."

For 25 years, Kay has been giving talks saying, "The computer revolution hasn't happened yet!" I believe that this is true, in part, because complication has gotten in the way.

The risks with complexity, complication, and bloat are also only growing. It's 2022 and we’re still deploying software with logging libraries that let attackers run arbitrary code. We barely understand our own software systems, let alone the tools we use to make them. And yet, underneath this mess is probably the most powerful and constructive tool humanity has ever seen.  
&nbsp;

Building software today _could_ be as fast and intuitive as we made desktop publishing by the 1990s. Suddenly designers could sit with a client in front of the computer and just execute an idea, making iterations together in real-time. Watching the designer use these intuitive tools, the client might think, "Oh, I could do that".

To get there with building software we need to reduce the complexity, and especially the complications, of making modern software. It's not just about user friendliness or making the process more visual. And it’s not about adding more. If anything, it’s about revisiting the idea of doing more with less.

Recently, tools falling under the label of "nocode" have shown the demand for non-programmers to be able to just make what they need, with "no code". It does sort of hint at what a photoshop of software might be. But every nocode tool is a facade, another layer of complication. They exist for a particular market, offered as a service, with no path to a more general means of making software. 

These tools have their place, the same way image macro generators have their place when Photoshop and Canva exist. I think if “nocode” tools could really save us, you'd be able to build a nocode tool with itself. They lack the true generativity of programming.

That said, I am all for *anything* that can be used as a building block in a software system. Whether it’s a library or a web API or a tool repurposed because you like its workflow. The less you have to build yourself, the better.

My experience has shown me time and again that there is a powerful strategy or guiding principle in what I call "generative building blocks." 

This philosophy applies to more than libraries and web APIs. I design everything as a building block, and everything out of building blocks. This is about more than just modularity, it's about _high-leverage generativity_.   
&nbsp;

I've worked on a number of projects and technologies trying to bring out this particular generative building block approach and there are a couple of standout hits that I'll use as examples.

In 2006 I was working on a hosted source control web app (like GitHub) trying to expose repository hooks. These are shell scripts triggered by your local source control tool that can be used to customize and extend your workflow, almost like registering a callback for an event. Running user code in a web app, especially shell scripts, was not safe or practical. However, imagining if somehow it was, a flood of possibilities hit me. If only web apps could have extension points! Without over formalizing it, I called this "webhooks" and started giving talks about what we could have if we added webhooks to our apps. Throwing a PHP script online was an easy and common activity for web developers then, so functioning as "hook" script with a URL, you just needed to have web apps let you register it and then hit it on certain events. 

Webhooks did end up making web apps more extensible and integratable, increasing their value and potential as building blocks. It also allowed for new kinds of API building blocks to emerge like Twilio, where the initial core product was built around webhooks to integrate with telephony and SMS. Webhooks also started creating a demand for what would later manifest as AWS Lambda for event handling, which quickly inspired "serverless" architecture. The concept of functions as a service was something I was pioneering in 2009 because of webhooks.

Later I found myself helping to prototype and conceptualize Docker, which turned software into a kind of standard unit, hence the shipping container metaphor. Although many interpreted it as a lightweight VM to throw whole systems into, I was in love with microservices designed to be run in tiny containers, configured by APIs instead of files, acting more like a little appliance than traditionally managed software. More like a simple building block.

Docker itself became a building block, opening up a whole new generation of platforms and developer tooling. One of my initial use cases for it was as a primitive to create a simple, hackable version of Heroku. Sure enough, using Docker and a few other components I made, I was able to "throw together" a simple Docker-powered Heroku alternative in 90 lines of Bash. This was called Dokku.

Dokku was a bit of a revelation. An expensive, top-tier platform valued in the hundreds of millions of dollars recreated with the right primitives in a weekend as a free Bash script...  
&nbsp;

I want to have the primitives to create more software like Dokku--extremely simple, hackable alternatives to the world's best software. The resulting software isn't really the important part, though. The resulting building blocks are. Why use Figma if you could somewhat easily throw together your ideal figma?

Building simpler alternatives by disaggregating into new primitives expands the adjacent possibility space of what can be thrown together, while also simplifying and commoditizing what it takes to build great software. It actually is a sort of reversing of entropy! Repacking down our abstractions, engineering for generativity.

What I love is how "building blocks" brings to mind a sort of ideal vision we have of building software. Like LEGO, we snap together little components to realize something new. But this metaphor also points out how far that ideal is from reality. LEGO is fun. Building software really _isn't_ most of the time. And I think trying to express the reality through this metaphor is helpful:

While ALL our software is made of many small bricks or components or modules, most come to us fully assembled with the bricks glued in place and painted over. We can't change it or even get a sense of how it was composed. Most apps come as an opaque "turn-key solution" to a specific problem because... that’s how you sell things. 

Perhaps there’s nothing wrong with that, but we can at least try to find ways to build more software like LEGO kits, where the focus is on good, re-usable, re-combinable building blocks and showcasing what you can do with them. In the long term, I believe this is the way that provides the most value.  
&nbsp;

A few years ago I realized that I need to build a single cohesive system that lets me express all these ideas, and really show the potential I've been talking about. I need to create my own LEGO system for software that would be an umbrella for all my work and let me build the way I want to build, while being at the very least a useful example to others...

So I'm announcing the Tractor System. It's not one project, but a system of projects building towards a malleable software environment and ecosystem. It is my take on a "Photoshop of software". 

Tractor is a system of building blocks and pragmatic ways of building centered around simplicity and generativity. It’s not a new language, it helps glue languages together. It’s not just an app builder, it’s a systems playground. Much of the tool is made with itself, out of the same primitives you use in it. It's designed to be as simple and understandable as it can be, top to bottom, inside and out.

The aim is to blur the line between user and developer. The computer is a computer because it can be _programmed_. The rushed, over-productization of shrink-wrapped software, pandering to enterprise organizations and the computer illiterate, has created so much complication it would seem we NEED big companies to build our software. But we don't. I'm constantly surprised how simple things really are or can be. With Tractor, eventually we'll just have operators: people that can use the computer in its full potential to solve problems, create systems, play, learn, work, and have fun.  
&nbsp;

Some say we live in a post PC era, but the original idea of the PC, the *personal* computer, is and will always be significant because it puts a magical form of *leverage* into the hands of *individuals* for their own use. But instead of this becoming more obvious with time, this generative power has been centralized and sterilized into "pop computing". Today we consume and are defined by software that benefits engines of capitalism more than engines of equity. You could say, instead of being able to program our own leverage, we are being programmed by those that can.

Luckily, underneath all the apps, social media, and enterprise "solutions", there is still an _imagination compiler_. This is what I focus on. This is what I'd love to dust off, polish up, and see where that takes us in the proper hands.

Even if that doesn't happen, I'd love to just get some better building blocks. Perhaps just find simpler, more enjoyable ways to build software.   
&nbsp;

As an independent creator, I depend on people like you to help fund this work, and I'd love you to come along and help make the Tractor System a reality by [becoming a sponsor](https://github.com/sponsors/progrium).

Onward!
-jeff
