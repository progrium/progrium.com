# Mailhooks

Mailhook, later renamed Mailhooks, was a single-purpose web app I made in 2006. It was the first in a series of applications with similar names like Clickhooks and Jabberhooks to both demonstrate webhooks and, in most cases, to make it easier to handle some particular protocol. In the case of Mailhooks, it accepted incoming email, parsed it, then sent it to a URL as a form post. A webhook for incoming email.

Besides being the first of my webhook demo apps, it was significant for a few other reasons despite being so trivial. First, I believe it was my first Twisted Python app, therefore the first time I did evented server programming. And the others I can share with two stories: the origin story, and, oh, let's call it the downfall story. 

## Origin Story

Like a number of my projects, I wrote Mailhooks several times. The first time, and the final time. Sometimes these are years apart, so I can't remember when exactly this story took place. It might have been the original inspiration or it might have been what prompted the rewrite. Regardless, it communicates some of the motivation behind a lot of my work.

Back then I lived in the south bay, which is where I grew up. I was spending a lot of time with friends that I met at a LAN party called LGLAN. They later helped found and organize SuperHappyDevHouse. One of our non-tech activities was hiking, though most of the time we'd be talking about tech. During one of these hikes, we idealized a scenario that would only really be possible with Mailhooks.

At the time, a few of us had the [Danger Hiptop](https://en.wikipedia.org/wiki/Danger_Hiptop) phone, marketed by T-Mobile as the Sidekick. It was a smart phone ahead of its time, pre-iPhone, with a large display, builtin camera, and a qwerty keyboard. It also had an open app store and developer ecosystem. One of the apps you could buy was an SSH client. We also used the camera quite a bit. The easiest way to get the photos to your laptop was via email, which is still often true today. Or we'd email directly to Flickr using their email upload address.

This inspired a number of ideas that came up during this hike. One idea was an email service that would take a bunch of photo attachments, stitch them together into an animated GIF and email it back to you. Then we thought it would be cool if we were able to make this right there while hiking. It was theoretically possible, we had SSH clients with us, so we could SSH into a server and write some PHP that shelled out to ImageMagick to make the GIF from the images. The hard part was getting the images, ideally via email.

If Mailhooks existed, we'd have everything to literally build this on our phones while hiking, circa 2005. It would probably have taken only a few minutes. Looking back, we could have configured Postfix for this via SSH, but that archaic system is not an easy one to work with. Mailhooks originally relied on Postfix and it was not something a kid with my experience then could easily throw together. The point being, once I had Mailhooks, these email ideas *were* easy to throw together.

I'm quite certain the moment I got home I started working on Mailhooks. I even built a prototype of that email attachement to GIF service idea with it.

I like this story because it paints a picture of how we thought the world should be, and how I still think it should be 10 years later. It *should* have been that easy to wire together, *on our phones, while hiking*. And not just for veteran programmers, but in particular it should be easy for excited kids that know basic web programming and have a cool idea. 

Just the other day on Facebook, I noticed my friend [Tantek](http://tantek.com/), a veteran programmer, bemoaning how difficult it would be to add an email interface to a project of his. Apparently difficult enough that it wasn't worth it. Still, today.

That said, [SendGrid](https://sendgrid.com/) does have exactly what Mailhooks is [as a feature now](https://sendgrid.com/docs/API_Reference/Webhooks/parse.html). And a few people have linked me to recent projects that do the same thing. In one case it was framed as "to make email bots". Yes, and plenty more. There is a demand for this, though I would posit not enough to start a company for.

## Downfall Story

Actually this sotry is the downfall of version one, but both versions had a similar fate. The second implementation happened in 2009 and was on App Engine. It used their incoming email interface, which was, not surprisingly to me, based on HTTP like a webhook. At that point it became a convenience around App Engine's email hook. Any app I wanted to make with email I just made directly using App Engine. This is why I never really talked about it except for in talks as an example story around webhooks. 

The downfall story I want to tell is how a friend and I attempted to make a small business around Mailhooks (then mailhook.org). It's actually pretty short, but is an experience that helped shape my desire for a vehicle [other than business](http://progrium.com/wiki/BeyondStartups/) to run a web app.

I was working as a contractor at the time and it give me enough freedom (and energy, but also I was younger) to explore projects like Mailhooks. While the initial version was running and people were starting to use it, I started talking to a lot of them. After a few expressed how much they'd pay for a commercially supported version, I starting asking others how much they'd pay for it. The answers were all over the place. Some, as I suspected, said it was not worth paying for. Others were saying upwards of $20 a month.

That made it seem like there was potential, so I talked a friend into partnering with me to make it something people could pay for. This involved making it more user friendly, having a landing page, and setting up payments, which was not quite as trivial as it is today with Stripe. The entire time I was very skeptical it was worth even this bit of work. 

The way this ended, if I recall, was rather anti-climactic. The guy I was working with sort of disappeared. That killed any motivation to keep trying and I let mailhook bitrot until I remade it in 2009. Similarly, I let that bitrot, though it did run for years on App Engine with no maintenance. 

That said, I will say this perhaps isn't the end of the entire Mailhooks story. I've learned a lot since then and have a much more cohesive vision for a lot of the ideas from that era. 