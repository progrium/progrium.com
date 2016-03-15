# Programmability

Software is eating the world. Disrupting industries and slowly pushing us towards ubiquitous computing. Our world is becoming software driven. This is great news for existing software developers. It also means there will be an increase in people getting into computer science or professional programming. 

The world is becoming software driven, but that doesn't necessarily mean programmable. The important [generativity](http://progrium.com/wiki/Generativity/) of computing is captured by its programmability. However, most of our software is ironically sterile. This is part of what I call Pop Computing, the sterilized, watered down, consumer friendly form of computing we have today.

To unlock the full potential of computing, the unlimited innovation and empowerment specific to the generativity of computing, we need to reclaim the programmability of computing. I'd argue this is more important than open source and free software, and if there was one thing hacker culture should fight for, it's programmability.

Programmability is about generativity, but what this means specifically in software might be unclear. Certainly, you can program the computer, but today you have to go out of your way to write a program, which then only represents a tiny slice of your computing experience. Compare this to the 80s when using the computer and programming the computer were nearly the same activity. Today, the majority of our time using the computer is spent using pre-written programs called applications that hide the programmability of the computer. 

However, these applications can be made to be more generative or programmable. What we need is a guide on how we can make software more programmable. This can be used to apply in new software, patched into open source software, or lobbied into proprietary software.

## Features of Programmable Software

I've identified a number of specific properties of programmable software. The more of these properties a piece of software has, the more programmable it is, and the more generative it makes computing. To summarize, they include:

 * APIs
 * Hooks
 * Plugins
 * Platform
 * Scripting
 * Open Architecture
 * Open Ecosystem
 * Open Source

### APIs

The most obvious way to make software more programmable is to give them an API. This means a way to use and drive the software from other programs. This is most clear in the case of web applications and web APIs. Libraries also have an API in this way, but it's builtin to the nature of libraries. Some, but not most, non-web applications have APIs. 

In some cases, the platform provides a means for API-like behavior. Unix commands and command line programs can be driven and used via shell scripting. However, it's a much less expressive form of API than an explicit API. OS X also provides programmatic access to programs via AppleScript.

However, APIs are about programmatic use, which significantly contributes to overall programmability, but isn't programmability itself. You aren't "programming" the app by using its API.

### Hooks

Hooks represent a significantly more programmable feature of software. Hook are callbacks, which can be used in a number of ways, but allows for user-specified code to run with the operation of some software. The biggest use case for hooks are integrations. However, they can also be used to change the behavior of programs in minor ways, for example git or svn pre-commit hooks.

Web applications have webhooks. A number of development tools use shell-based hooks. Programming environments and libraries often use callbacks. Most event-driven programming is callback or hook oriented. Bringing hooks to the application level helps bring evented programming to computing beyond a particular programming environment.

### Plugins

Plugins are a step up from hooks, enabling a new level of programmability. They usually involve a combination of API and hooks, as well as metadata, packaging and distribution, and often a management UI. Plugin systems focus on extending and changing functionality of software. 

It's interesting to note that most large desktop applications have a plugin system: Chrome, Photoshop, Unity, Microsoft Office. Whereas web applications do not. However, webhooks lay the foundation for a plugin system for web applicatons. 

### Platform

We throw around the term platform quite a bit. In this case, software is a platform if it runs and supports applications. Operating systems, AWS, Heroku, Chrome, and even Facebook can be called platforms by this definition. 

Not all software is or makes sense to be a platform, though it's worth pointing out that being a platform is essentially being a computing environment that only focuses on "plugins" called applications. 

### Scripting

Different than plugins in form, but similar in purpose, scripting environments allow users to extend and change functionality via APIs and hooks within that scripting environment. Many platforms include a scripting element, like shell scripts, AppleScript, and even CloudFormation for AWS. 

### Open Architecture

We like to say "open system" or "closed system" but this can refer to any number of aspects of a system, and aren't necessarily about programmability. However, open architecture in the context of software encourages programmability.

Similar to open architecture of computer hardware, in software open architecture means made of reusable, often swappable, components and ideally with "soft barriers". Open source libraries exemplify open architecture in that you can often see what components or libraries they use. You can then go and see what libraries those libraries use. 

A Linux system (more than the kernel) is a decent example of open architecture. Most of the utilities and APIs the system uses you can use and reuse directly. Though because most of Linux ecosystem is compiled, there are slightly stronger barriers. Most components are black boxes you can't "see into", unless the source is available.

An even better example is the Lisp based operating system Genera. Since the entire operating system and all applications run in shared memory, all components of any part of the system are reusable and repurposable.

### Open Ecosystem

This is often what people mean when a system is "open". It's particularly relevant to platforms, but can also apply to software with plugins, hooks, and APIs. A platform with an open ecosystem means any 3rd party is free to build applications for it. Software with an API might have closed access. So this is about there being no single gatekeeper. The generativity is open to all, making it a level playing field. 

The web and Linux are great examples. Counter examples include the Apple App Store, which is open-ish, but there is a single gatekeeper.

### Open Source

Open source is special. It doesn't directly make software programmable. Open source is more about freedoms than programmability. You're free to contribute an API. You're free to contribute a plugin system. Open source doesn't ensure most of these other programmability features, but definitely enables them. 

So this is why fighting for open source is not enough. It helps, it's a Good Thing, but software doesn't need to be open source to be programmable. So when fighting for generativity, open source is suddenly much less important as its an entirely orthogonal concern. 

## Examples

One of the best examples of programmable software is a little known operating system released in 1982 called Genera. It happens to capture all of these properties, except it is not open source. Here is what it looks like:

![Genera](https://dl.dropboxusercontent.com/u/2096290/Wiki/2016/genera-examiner.png)

Genera has a number of interesting properties. Here are just a few:

 * It is written entirely in Lisp, including kernel and drivers
 * All functions and data are in shared memory space
 * All parts of the system can be inspected, reused, extended, or replaced
 * Each program can customize Genera without affecting other programs
 * Hypertext-like documentation is available for everything
 * Despite being proprietary, all source is available
 
From the [Genera Concepts](http://lispm.de/genera-concepts) paper:

	This means you can change everything, opening up a rich environment and permitting you to go far beyond the usual notions of customizing. The modifications you can make are limited only by your imagination and programming ability.

Genera is probably the most programmable computing platform you can find. The next closest that shares similar properties is probably [Squeak](https://en.wikipedia.org/wiki/Squeak) on the Smalltalk VM that came out in 1996. Then followed by perhaps editors Vim and Emacs, with Emacs in particular being known for its programmability, albiet archaic and Byzantine.

Clearly, we have nothing like this today. The closest is perhaps GitHub's Atom editor, which is written entirely in JavaScript with HTML5. It's known as the hacker's editor because you can edit any aspect of it using modern, accessible web technology. 

![Atom Editor](https://dl.dropboxusercontent.com/u/2096290/Wiki/2016/atom-editor.png)

You can imagine not long from now, we'll see an operating system implemented entirely in JavaScript that might re-invent much of what Genera and Squeak did. In fact, I've already seen a few projects in this space. 

## Closing the Gap

Perhaps at some point we can start over. Certainly in specialized situations, we can explore new computing platforms from the ground up that are more programmable. However, for mainstream use, we have to work with what we have.

What's more, modern computing goes beyond operating systems. We use applications across devices and across applications in the cloud. Our computing experience is not tied to a single platform. It transcends platforms. So we can't address programmability with a new platform. We have to make our existing applications across platforms more programmable. 

I can't exactly articulate what I have in mind, but as an simple example, I've already made a huge amount of progress evangelizing webhooks in web applications. This is just one piece of the foundation for a more programmable world.
