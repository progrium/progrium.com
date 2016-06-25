---
layout: post
title: That Time I Joined Twilio
date: 2016-06-24 18:00 UTC
tags:
---
Twilio is one of the few companies aligned with my core values as a technologist: the importance of the developer and developer experience, the value of design and design thinking, and the significance of powerful, accessible "plumbing". There is no other publicly traded company like it.

With yesterday's IPO, it's hard not to think about Twilio and my time there. I think the most interesting part of my Twilio story is how I ended up working there. Among all the early employees, I had a pretty unique experience and it had a lot to do with how I joined. It was sort of a fluke.

I've talked a bit about my time on the Twilio platform team. That experience in particular sort of changed my life. It laid the blueprint for everything I've done since. However, the first half of my time at Twilio was building a product that never shipped called Twilio Realtime. Not many people know this story.

I joined Twilio in April 2010 and stayed for two years. Even today that's the longest I've worked at one place that wasn't working for myself. I learned so much at Twilio. The company, people, and values there had a huge impact on me. It's also where I validated a hypothesis: I cannot work for any company as a full-time employee.

Twilio was my first full-time job in the industry. That's not to say I was new to the industry, I'd just always been an independent contractor before then. After working independently for 10 years and spending most of my time writing open source projects, it was a big deal for me to take a job like that. 

Just before Twilio, I had been working with some friends at NASA Ames. It was originally to prototype a web app to enable participation with the TESS mission. Actually this was pretty cool. It was going to allow people to submit code that would run on the NASA satellite to do arbitrary analysis on extremely high resolution photographs of space, data that was too big to send back to earth to process there. 

Our team of young space geeks eventually evolved into a larger project called NASA Nebula. Among other outcomes, the software developed there became Nova, the heart of OpenStack. However, this hadn't happened yet. I worked on what led up to this for a year but the politics and particular technical focus at that point had started losing my interest, so we parted.

Despite that, I was feeling pretty great. I had worked at NASA! How cool is that. Plus, SuperHappyDevHouse, a regular free event I started with friends a few years before, was peaking with around 300 attendees each event. And in the fall of 2009, we opened the doors to Hacker Dojo in Mountain View, today the largest hackerspace in the country. I was also actively evangelizing an idea called webhooks, and it was working. Because of that, people were inviting me to speak at conferences, and I even gave a Tech Talk at Google.

To a 24 year old that grew up poor, didn't go to college, and never had a full-time job, all this felt pretty good. That said, please excuse this tweet of mine from January 2010:

> Beginning February I will be available for hire. Keep in mind, I'm only considering my dream job. Think you have it?

This is how I ended up being employee 8 (9? Still unclear) at Twilio. Jeff Lawson replied to this tweet with something like, "We should talk." 

Why Twilio? There were a number of reasons.

The first that stood out to me was that the core mechanism of Twilio was based on webhooks. At that time, anybody that was implementing webhooks was immediately endearing to me. However, they went further and were using them in a way that showed they really got it.

Also, Twilio wasn't unknown to me before. I was already using it for various projects and demos. I thought the platform was amazing. I mean just read [how it was pitched](http://avc.com/2016/06/best-seed-pitch-ever/) to Fred Wilson. 

I'd been fascinated with telephony long before Twilio was conceived. As a kid I loved hooking up and splitting phone lines, and generally playing with the phone. I loved the stories of Woz and Jobs messing with the phone system. It was appealing to me for the same reason it was to them. Before the Internet it was basically the only modern worldwide system, and to tap into it felt immensely powerful.

Most telephony software was built on Asterisk. I never worked with Asterisk, but around 2003 my dad started an ill-fated company called Fonestream built on it. The product was based on the premise of combining audio streaming on the web with telephony. It wasn't able to find a sustainable market, perhaps it was ahead of its time, or maybe just too niche. I remember later bragging to him I could rebuild Fonestream in an evening using Twilio.

Fast forward to 2009, just before discovering Twilio, a friend and I were inspired by some talks explaining how much of the third world was connected via 2G phones and SMS. In some cases, villages would have the village 2G phone that would let them talk to distant family or make payments via SMS. These talks made the case for building SMS apps to enable people to coordinate and collaborate in ways that would let them uniquely solve their own real world problems.

As an example I recall, in some places people would walk long distances in the heat to get to a market. Sometimes they'd also have to take a train as part of that trip. If the train wasn't running for whatever reason, they'd walk all the way to the train only to have to turn back. Making it easy to know the train wasn't running before they left would save them that pointless trip.

After seeing these, my friend [Adam Smith](https://adamsmith.as/) and I talked about making an SMS wiki. Wikis were hotter back then and really showed how a simple tool can be used for so many collaborative purposes. We didn't have Twilio yet, but we did find a way to tap into Google Voice's SMS capabilities to essentially get the same SMS API for free, though against terms of service. It worked so well, we generalized it into framework for building SMS apps. Neither were used again, but both are still on my Github: [ShortWiki](https://github.com/progrium/ShortWiki) and [ShortNet](https://github.com/progrium/ShortNet).

Shortly after, we discovered Twilio.

The coolest use of Twilio I'd seen was made by Adam and other friends completely for fun. It was a game hacked together a few hours before my 24th birthday party, an epic joint party at Hacker Dojo just after it opened. The game was projected onto a huge wall. It was essentially Missile Command, except you're saving me from the missiles. There was a grid with numbers in each cell and a number to call. Anybody at the party could try to stop the missiles from destroying me by calling in and entering a number from the grid.

![Jeff Game](https://dl.dropboxusercontent.com/u/2096290/Blog/2016/savejeff.jpg)

All of this was in the back of my mind when I met with Jeff Lawson at Red Rock Coffee. I liked that he was a technical CEO. We chatted about webhooks, NASA, and PHP. Then Twisted Python came up. He said, "You *have* to talk to Evan, our CTO." Apparently Evan was all about Twisted. Half of Twilio was written in it. 

Twisted was the Node.js of the 2000s, except nowhere near as popular. But it was the first to really popularize the single-threaded evented programming model for high performance networking applications.

My next visit was at Twilio HQ, then at San Francisco's Pier 38 just before they moved out. Jeff Lawson took me to brunch. We talked a lot about the power of APIs and how everything should have a web API. We even jammed around the idea of Twilio someday providing an API to manage and move around money that people could build banks on top of. 

Oh how naive we were, as I'm sure the founders of Simple, Dwolla, and others would agree. Plus certainly out of the scope of communications, but there was definitely a shared sense that what Twilio was doing for telecom could, should, and inevitably would be done for many other industries and systems.

We went back to Pier 38 and into a conference room where I met their CTO, Evan Cooke. Here the three of us talked about working together.

Remember, I said I was looking for my dream job and I meant it. Can you guess what that entails? If you know me it wouldn't surprise you: A place where I can work on whatever I want. Sure, who wouldn't want that? But I was ready to walk away if they said no. 

I wanted a place where I could do my life's work. Not a place that would *give* me my life's work. A place I could *do* my life's work. A place I could make a home out of, stop contracting, and focus on all the projects I consider to be important. In theory, Twilio and I seemed aligned enough it could work.

Their response was fairly predictable. They said, "Well what do you want to work on first?" 

At that time, regardless of my job situation, there was a project I was planning to build as open source and ideally run as a free service. It was a service that would handle real-time communication to the browser via REST API. Today, especially with Node.js and WebSockets this isn't anything special. Back then, though, neither of those existed. 

The long-lived connections necessary for this were something a lot of web developers were actually afraid of. "It doesn't scale!" "They're too expensive!" A lot of very talented, prominent developers had this opinion and said it wouldn't work. They were sort of right, but also not entirely. 

Back in 2004 when Gmail was released, it did something almost nobody was doing then. It used a browser feature called XMLHttpRequest or XHR. It had been functional in Mozilla since 2002. By 2004 it was available in the top major browsers. It allowed pages to load content and make requests after a page was loaded. Updating without loading a new page. The technique was dubbed Ajax and became quite trendy to make faster, less jarring dynamic web experiences. 

One night not long after Gmail was released, 7 years before WebSockets, Adam Smith and I were working on a web project and got distracted by an idea. Inspired by Gmail, we wondered if we could use Ajax/XHR to make a real-time game in the browser. Most web apps that wanted to push updates to a page would have the browser poll the server using XHR. That wasn't real-time. That wouldn't support, say, a multiplayer action game. 

Armed with Apache, PHP, Firefox, and no serious knowledge of concurrent programming, over the next two days straight we did it. We ended up implementing long-polling, which was not done enough to have a consistent name yet. The XHR request would stay open until it got a message, then reconnect immediately and stay open until the next. Apache and PHP made it really difficult to share data between requests, but we found PHP functions for POSIX IPC functions, which let us create a file both request threads could see and effectively send messages on. In retrospect, a Unix domain socket would have been a better idea, though it's possible PHP didn't have an API for them yet.

Nearly a year after making it, we showed the proof-of-concept game we called AjaxWar off at SuperHappyDevHouse to much acclaim. We won best talk. [A poorly lit video of the talk is still on YouTube.](https://www.youtube.com/watch?v=-cHKFsnnAYw) In the audience was Alex Russell who later coined Comet to describe techniques like this to achieve real-time streaming in the browser.

Even with Comet popular enough to be given a name, it was not done that often. It was extremely hard to implement reliably in a consistent way across browsers and versions of browsers, let alone at scale. There were a handful of intricate tricks, all of which you'd implement then detect which one to use based on the browser. But it wasn't just client-side. Each trick required a different backend implementation, and none of them could be done with the common web stacks of the time. 

I wanted to solve this problem with a simple web API. There was basically one open source project that people could use for this sort of thing, but it was built on technology foreign to most web developers and would be another fragile component to run in the stack. I felt this was unnecessary and inaccessible to most developers.

I almost considered doing it as a startup myself, but there I was with Evan and Jeff and they asked what I wanted to do. I told them real-time browser communication as a service. 

Evan's eyes lit up. He showed me a demo he built using Twisted. It was a web page that visualized every event going through Twilio in real-time. It would seem he was excited by the idea. Jeff also seemed excited to expand the product line to a new developer tool. It wasn't telecom, but it was communications.

I was hired and I had my first project. It had almost nothing to do with the existing Twilio product.

Twilio Realtime was on its way, but I was doing it all alone. Despite a growing engineering team around me. They were tackling problems with scaling, billing, important features, responding to incidents, and everything related to building and running Twilio. I wasn't. Sometimes I'd get involved or provide feedback if asked, but I just wasn't responsible for those things.

I've heard the most common story told about me at Twilio today is this: Somebody interviewing for a job asks, "What's it like working with Jeff Lindsay?" The interviewer, an engineer I know with a great sense of humor, replies, "It's sort of like not working with Jeff Lindsay."

We all worked at the same company, but I didn't actually work with anybody for most of that first year. This wasn't intentional, but that's what happens when you join a company to work on something other than the company's product. This eventually changed, but I certainly gained the reputation of loner. 

Despite that, Twilio Realtime was coming along. We had a private preview and people loved it. However, other startups were popping up providing a similar product. I recall Pusher and later PubNub. I got a lot of feedback that Twilio Realtime was easier to use. That was encouraging. Plus I figured, "We're Twilio, we can blow those other guys out of the water."

Unfortunately, it never felt like Twilio Realtime was getting close to launch. Evan had imposed some intense scaling requirements for launch, on the order of millions of subscribers. This whole period was a blur. It was frustrating because a new startup would just ship and deal with growth as it came. At this point, Twilio couldn't afford to do that.

Fast forward a few months, Twilio had gotten even bigger. There were now several product people, but Twilio Realtime didn't have any support from product. It basically slipped through the cracks since it started before a product team existed, and product was now necessary to get anything shipped. After identifying this, Twilio Realtime was assigned a product manager.

We tried to make it work, and it would have been a great product to use, but it seemed ultimately there was not a strong enough business case to launch Twilio Realtime. In retrospect it's obvious from a technology standpoint that the problem it solved was on its way to being dissolved. Instead the technology and team was rolled into Twilio Client, a toolkit for web and mobile to make softphones and other communications applications.

It was good to work with a whole team. It was also a nice break to be part of somebody else's vision. I found interesting problems to get involved with like presence, API design, security tokens, and more messaging stuff. I was also organizing Twilio Tech Talks and bringing in people to talk about useful technology and ideas.

Twilio Client shipped around my one year mark. That's when I joined the fledgling infrastructure team. After another year, I realized as great as Twilio was, as important as the product was, working there was not maximizing my output. It was not the place I could do my work. No company would have been, and I've since gone back to collaborations and finding ways to fund my independent work.

Even if Twilio wasn't the place I could do my life's work, and as obvious as it is now that it wouldn't have worked, I'm grateful that Jeff and Evan took that chance with me. Not just because of this IPO, which might actually help fund more of my work, but because of what I learned, the people I met, and the ideas that were explored there. It was fun to be even a small part of a company that incredibly special.

Congratulations to everybody at Twilio. 
