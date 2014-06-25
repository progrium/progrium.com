---
layout: post
title: "Public Open Source Services"
description: ""
category: 
tags: []
---
Last night I went off and put up a wiki about an idea I've been thinking about for a while: [public open source services](http://poss.gliderlab.com/) or POSS. Think: public services or utilities on the web run as open source.

Unlike open source software, web services aren't just source code. They're source code that *runs*. They have to be maintained in order to keep running, and the resources they consume have to be paid for. This is why most web services are built using a business as the vehicle. This effectively constrains what you can build by framing it as something that needs to turn a profit or support you to work on it. But does it need to be that way? Can web services be built in a way that make it self-sufficient? Not needing some ambivalent leader to take responsibility for it?

I originally blogged about it in February 2007, 6 months after I first wrote about webhooks. Unfortunately my old blog isn't online right now. Back then, I was trying to solve the administrative problem. How do you maintain the servers in an open source way? My idea then, was to build a self-managing system using something like cfengine or Puppet, where the recipes and configurations are kept with the publicly available source code. As new configurations are checked in, the server(s) adopt the new directives and continue to self-manage.

The practicality of such a setup is a little far fetched, but seemed pretty feasible for smaller projects. However, since the release of Google App Engine, this concern for simple web applications has disappeared. Google just automates the system administration, and scaling! This means to run the app, you just have to write the code and hit deploy. That's a huge step! Administration concerns? Pretty much solved.

The next thing is the financial concern. How do you pay for it? Or rather, how does it pay for itself? This took longer to figure out, but here we are. From the wiki essay:

> You use the same Google Merchant account that App Engine debits as the one that accepts donations. This way no bank account is involved. Then you track the money that goes into the account (using the Google Merchant IPN equivalent). Then you look at your usage stats from the App Engine panel and predicate future usage trends. Then calculate the cost per month. Then divide the cash in the account by that and you have how long the service will run. You make this visible on all pages (at the bottom, say) that this service will run for X months, "Pay now to keep it running." You accept any amount, but you are completely clear about what the costs are. And this is all automated.

Take the humans out of the loop!

Then you rely on the same sort of community approach of open source to contribute to the application. Like a few members of the project community are given certain rights, some will be given permission to deploy the app from time to time for updating the running service.

If the service isn't useful, nobody uses it, it's not paid for, it disappears. If it is useful, people will pay for it to keep it running. They are assured they are paying operating costs, which are significantly lower than most because it doesn't include paying for human resources! Volunteers might need to meddle with settings, but otherwise, the coders are in control and the community accepts or denies changes made by whoever wants them.

So if this is interesting, read the [full essay I wrote up on the wiki](http://poss.gliderlab.com/). It's been my intention to prototype and validate this model with many of my projects.
