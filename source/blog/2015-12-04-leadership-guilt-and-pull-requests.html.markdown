---
layout: post
title: Leadership, Guilt, and Pull Requests
date: 2015-12-04 16:58 UTC
tags:
---
I have a lot of [open source projects](https://github.com/progrium?tab=repositories). Even more with [Glider Labs](https://github.com/gliderlabs?tab=repositories). Some of them are fairly popular. All of them get me excited. But most of them also bum me out. I'm going to share one of the reasons I've had to take a break for the past couple months, and why all my repositories are now looking for more maintainers.

Open source is hard. It seems easy, though. You just write a piece of software and put it on Github, right? Well that was the easy part. Now comes maintenance. And very likely politics. Inevitably, guilt. Multiply that by the number of open source projects you have and their popularity. End result: open source can be a bummer.

Jacob Thornton ([@fat](https://twitter.com/fat)), co-author of Bootstrap, gave a talk a few years back echoing the sentiment of many open source authors and maintainers. He calls it Cute Puppy Syndrome. It's not the best analogy, but it gets the point across. Open source projects, like puppies, are great fun when they start. As they get older and more mature, responsibility seems to outweigh their cuteness. One solution is to put your old dog up for adoption and get a new puppy. As you can tell from his delivery, this analogy is intended to be humorous:

<p style="text-align:center;"><iframe width="560" height="315" src="https://www.youtube.com/embed/UIDb6VBO9os?start=1190" frameborder="0" allowfullscreen></iframe></p>

He mentions that many authors of popular open source projects have gotten burnt out and look for an exit. Often handing projects off to maintainers, sometimes never to return. Not to avoid responsibility, but to stay sane. Still, much of the time, that sense of responsibility lingers. As Jacob expands on the puppy analogy:

> If you have your puppy and it turns into a dog, you put it up for adoption, you give it to a maintainer. And then he over feeds it and it becomes fat and bloated. And you just sit there and you're really sad because you don't really have time to take care of your puppy any more, but you don't want to see it fat and bloated. So you're just real sad all the time.

Alternatively, you can let issues and PRs pile up. Guilt and sadness either way. At least opening the project up lets it survive and continue to provide value to a larger audience. You just have to let go of the project as it will now evolve in ways you might not agree with.

When I did this with [Dokku](http://progrium.viewdocs.io/dokku/), the new maintainers did a great job at keeping the project and community healthy. I can't thank them enough for that. I had to let go quite a bit, but the project would probably be dead without them.

In fact, there's something interesting about maintainers that didn't author the project. It's probably different from person to person and project to project, but the maintainers of Dokku don't have the guilt or burden that I do. They're happy to help, and as volunteers don't feel like they owe anybody anything. It's really the ideal situation. Perhaps authors *shouldn't* be maintainers after a certain point.  

That said, even with these great maintainers, Dokku really only kept on an incremental path of maintaining the status quo. That's not necessarily a bad thing, but it meant Dokku wasn't able to develop further in the directions I had originally intended. I thought to myself, well eventually I'll find time to do a system-wide refactoring to get it on this path I want and submit these as PRs like any other contributor. That time never came, and the project continued to fall behind from the evolving larger vision. The project I started was not living up to my own expectations for it.

Sadness. Guilt.

Then I did something different. It was so simple. I wrote a wiki page describing what I wanted and why I wanted it. For some reason it came as a surprise to me that the maintainers started moving the project in that direction! Did it happen exactly how I'd do it? Not always. But it still brought the project closer to what I wrote down.

This shouldn't have come as a surprise. In essence, this is leadership. There are different forms of leadership, but at the core is the idea of "saying what, not how". It can be very hard for programmers to get into this mindset because our medium is all about the how. Stepping back and writing what you want with flexibility towards how it's implemented takes practice.

This experiment with Dokku was far from perfect. In fact, that document is still incomplete. Project leadership is just as ongoing as maintenance. However, it's something worth getting better at. It's essential to authoring many open source projects and remaining happy enough to keep going. In the case of my projects, since there is always a bigger picture they fit into, it's even more important.

Dokku is just one of many projects, but Dokku is one of my only projects that I'm not an active maintainer. Dokku isn't why I had to take a break, it was all the others.

Some of you might have seen my ramblings about [Megalith](http://progrium.com/blog/2015/10/05/the-next-10-years-megalith/). Some of you might even be able to follow them enough to see that most of my open source projects are all basically part of Megalith. Or that Megalith is basically all my projects. You can probably see how this leadership is critical to sustain all these projects while keeping them moving in roughly the same direction.

I don't write open source software to make money. In fact, even solving a particular problem is secondary to working towards a vision of how the world should be. Since that's really what's important to me, I should be spending my time on being an effective leader. At the very least, documenting what I want, the direction, why it's important, what design principles are involved, preferred architectural patterns, and so on. Then helping people understand, integrating their feedback, and letting go of a lot of the details.

To support this, I need to open up our projects to more maintainers. Going forward, I'll be trying a variation of the [Pull Request Hack](http://felixge.de/2013/03/11/the-pull-request-hack.html) to get more people involved across all projects. If you submit a solid substantial PR or several solid minor PRs to any Glider Labs project, you'll be invited to have commit access across all projects.

Starting now, all public projects under [my username](https://github.com/progrium) or [Glider Labs](https://github.com/gliderlabs) have an open call for maintainers. If you'd like to volunteer to help maintain any of these projects, just [join our Slack](http://glider-slackin.herokuapp.com/) and in `#intros` say you're interested in becoming a maintainer.

From there I'll do my best to provide guidance and leadership. Together we'll keep making great things!  
