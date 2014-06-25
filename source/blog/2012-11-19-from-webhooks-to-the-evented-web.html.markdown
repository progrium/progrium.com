---
layout: post
title: "From Webhooks to the Evented Web"
description: ""
category: 
tags: []
---
Back in 2007 I started thinking and talking a lot about [an idea called webhooks](http://progrium.com/blog/2007/05/03/web-hooks-to-revolutionize-the-web/). Over the following few years I started evangelizing it. I spent a lot of my free time giving talks and building tools around the idea of webhooks. Some of these tools are still around today, including [Localtunnel](http://localtunnel.com) and [RequestBin](http://requestb.in) (originally PostBin). There were others that might not be around anymore: [MailHooks](http://mailhooks.com), [ClickHooks](http://clickhooks.com), [TwitterHooks](http://twitterhooks.com), [Scriptlets](http://scriptlets.org), and a few others.

Webhooks wasn't really a new technology in the sense that there was a specification or tangible piece of software. It was more of an architectural pattern, and a loose one at that. To me it was just a different way to think about web applications, and it opened up a lot of new possibilities. 

I was really excited by those possibilities, so I started telling people about it. The only problem was that it was this semi-vague idea. I often spoke in high-level notions. It was hard for some people to understand at the time. I think some people mostly got it, but a lot of people didn't get it and thought they did. 

### Confusion

For example, the name "webhooks" was more about the pattern than any specific part of how it works. Webhooks involve two parts: an application that triggers a URL, and a handler at that URL. If you were to ask "where is the webhook?" different people will answer you differently. Some say it's the trigger side. Some say it's the handler side. For me, "a webhook" is the combination of both a trigger and a handler.

It also didn't help that there was never a spec. I always avoided a spec because there were a lot of different implementations already out there, and you might implement it slightly different for different use cases. It made sense to me to just keep it a general pattern and not limit what was possible. 

I didn't want to say, "Well, if you want to implement webhooks, it's got to be JSON. And use this payload structure. And this is the API for registering them. Otherwise, it's not webhooks." Because if you didn't do those things in a particular way, they'd still be webhooks to me. 

### Mild Success

After a while, the idea got out there and companies like Google, Facebook, Wordpress, GitHub, Twilio, and other startups started implementing it. Five years later and I still often run into new applications or open source projects using the term webhooks. But even after all this time, there's still a lot of cool stuff that I wanted to emerge that hasn't really happened yet.

Some of it is starting to happen, though. For example, how do you write these handlers script? I really didn't believe in being able to just plug apps together like pipes. That's something that could come later and would definitely need a spec. Instead, I wanted people to actually write handler scripts with code. That way they could make something that did whatever they wanted, exactly how they wanted.

To facilitate that, I wanted a service that would let you write and it would host for you these little handler scripts for processing HTTP webhook requests. I actually built a prototype of this called Scriptlets. It was a web app where you could write JavaScript, hit save, and then you'd have a little script at a URL that you could use for webhooks.

Scriptlets didn't get very popular, though I didn't push it very hard. There was a lot I wanted to do with it but there wasn't enough demand to drive development, and I was so busy that it eventually became defunct. 

Four years later, we actually have a service like this. I discovered it about a week ago. It's called [Webscript](http://webscript.io). It's basically Scriptlets done right. Webscript is a web app where you can write Lua, hit save, and then you've got little web service. It has basically everything you need to write webhook handler scripts.

### The Ecosystem

Slowly, people *are* building out pieces of the ecosystem. You could say that the webhooks paradigm was really about this ecosystem. At some point I realized this and decided to give that ecosystem a name. It turned out the ecosystem was really what I was getting at with webhooks. That's where the magic was.

I started calling this ecosystem the Evented Web. Like the Semantic Web and "programmable web," it's an umbrella term for a family of technologies coupled with a vision of what the world could be like. The Evented Web envisions a world where the programmable web that we have today of traditional web APIs is complemented by APIs that produce events through webhooks. Adding a callback mechanism to web APIs makes the web more like a giant evented framework.

Just like with Node.js, perhaps the most popular evented framework, there's all kinds of innovation happening in the community. It's a new way of thinking about things. Pipes and streams come up a lot in the Node.js world now, and similar sorts of things can be done across web applications with an Evented Web.

By the time I started talking more about the Evented Web instead of just webhooks, I was already pretty tired of talking about it all. I was sort of "over it" and I started to not care if people didn't see or share this vision. I continued to think it was cool, but I started to move on to other interests.

### The Future

These days, the people that really get it are starting to build some really neat things. Webhooks have spread enough that you can at least reference them or the idea of HTTP callbacks and not have to explain yourself. Now is maybe the perfect time for me to put a few specific projects into motion that could at least provide a tangible foundation for building out the Evented Web. Not just vague notions.

The most immediate thing is a lightweight spec for implementing webhooks. Specifically I mean registering a callback URL and invoking the callback URL. I've intentionally put this off for a lot of reasons. I didn't want to get it wrong. I didn't want to leave people out. I wanted to capture best practices, which for the longest time we hadn't them figured out. But now might be the perfect time because there is a lot on the verge of happening.

Stay tuned for my proposal for HTTP Subscriptions. It will be the first of several really cool developments for the Evented Web, from me and from others.
