---
layout: post
title: "Executable Tweets and Programs in Short URLs"
description: ""
category: 
tags: []
---
A few weeks ago I was completely consumed for
the better part of a day that I would have otherwise spent on more practical
work.

<blockquote class="twitter-tweet tw-align-center"><p>Let's reflect. On a whim, I spent 6 hours writing programs that live in URL shorteners to create installable programs from Tweets.</p>&mdash; Jeff Lindsay (@progrium) <a href="https://twitter.com/progrium/status/279118756561711104" data-datetime="2012-12-13T07:01:11+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>

Yeah, what? Weird, right? It started from a Twitter conversation earlier that day with my friend Joel:

<blockquote class="twitter-tweet tw-align-center"><p>$ for app in `heroku apps | grep -v '='`; do echo <a href="https://twitter.com/search/$app">$app</a>; heroku ps --app <a href="https://twitter.com/search/$app">$app</a>; done # how to figure out what you have running on heroku</p>&mdash; Joël Franusic (@jf) <a href="https://twitter.com/jf/status/279030460674347008" data-datetime="2012-12-13T01:10:20+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>
<blockquote class="twitter-tweet tw-align-center" data-in-reply-to="279030460674347008"><p>@<a href="https://twitter.com/jf">jf</a> reminds me of yet another app i need to build</p>&mdash; Jeff Lindsay (@progrium) <a href="https://twitter.com/progrium/status/279030609345667072" data-datetime="2012-12-13T01:10:56+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>
<blockquote class="twitter-tweet tw-align-center" data-in-reply-to="279030609345667072"><p>@<a href="https://twitter.com/progrium">progrium</a> I just wrote and launched a "client side" "bash app" right there. Bam.</p>&mdash; Joël Franusic (@jf) <a href="https://twitter.com/jf/status/279031831809097728" data-datetime="2012-12-13T01:15:47+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>
<blockquote class="twitter-tweet tw-align-center" data-in-reply-to="279031831809097728"><p>@<a href="https://twitter.com/jf">jf</a> app tweets. an app in a tweet.</p>&mdash; Jeff Lindsay (@progrium) <a href="https://twitter.com/progrium/status/279032107265839104" data-datetime="2012-12-13T01:16:53+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>
<blockquote class="twitter-tweet tw-align-center" data-in-reply-to="279032107265839104"><p>@<a href="https://twitter.com/progrium">progrium</a> $ apptweet install id:279030460674347008</p>&mdash; Joël Franusic (@jf) <a href="https://twitter.com/jf/status/279032681373790208" data-datetime="2012-12-13T01:19:10+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>

This wishful brainstorming inspired me to start building exactly that.
But first, a digression.

The idea reminded me of an idea I got from [Adam
Smith](https://twitter.com/rndmcnlly) back when I was working on
Scriptlets. If you can execute code from a URL, you could "store" a
program in a shortened URL. I decided to combine this with the
curl-pipe-bash technique that's been starting to get popular to
bootstrap installs. If you're unfamiliar, take this Gist of a Bash
script:

<script src="https://gist.github.com/4464431.js"> </script>

Given the "view raw" URL for that Gist, you can curl it and pipe it into Bash to
execute it right there in your shell. It would look like this:

    $ curl -s https://gist.github.com/raw/4464431/gistfile1.txt | bash
    Hello world

Instead of having Gist store the program, how could we make it so the
source would just live within the URL? Well in the case of
curl-pipe-bash, we just need that source to be returned in the body of a
URL. So I built a simple app to run on Heroku that takes the query
string and outputs it in the body, a sort of echo service. 

<script src="https://gist.github.com/4464442.js"> </script>

Letting you do this:

    $ curl "http://queryecho.herokuapp.com?Hello+world"
    Hello world

Which you could conceal and shorten with a URL shortener, like Bitly. I
prefer the j.mp domain Bitly has. And since they're just redirecting you to the
long URL, you'd use the `-L` option in curl to make it follow redirects:

    $ curl -L http://j.mp/RyUN03
    Hello world

When you make a short URL from the bitly website, they conveniently make
sure the query string is properly URL encoded. So if I just typed
`queryecho.herokuapp.com/?echo "Hello world"` into bitly, it
would give me a short URL with a properly URL encoded version of that
URL that would return `echo "Hello world"`. This URL we could then curl-pipe into Bash:

    $ curl -Ls http://j.mp/VGgI3o | bash
    Hello world

See what's going on there? We wrote a simple Hello world program in Bash
that effectively lives in that short URL. And we can run it with
the curl-pipe-bash technique.

Later in our conversation, Joel suggests an example "app tweet" that if
executed in Bash given a URL argument, it would tell you where it
redirects. So if you gave it a short URL, it would tell you the long
URL.

<blockquote class="twitter-tweet tw-align-center" data-in-reply-to="279032107265839104"><p>@<a href="https://twitter.com/progrium">progrium</a> $ echo "$1"; curl -IL --silent "$1" | grep Location | grep -o 'http.*' # this is a URL "unshortener"</p>&mdash; Joël Franusic (@jf) <a href="https://twitter.com/jf/status/279033679592951809" data-datetime="2012-12-13T01:23:08+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>

Just so you know what it would look like, if you put that program in a
shell script and ran it against a short URL that redirected to www.google.com, this is what you would see:

    $ ./unshortener.sh http://j.mp/www-google-com
    http://j.mp/www-google-com
    http://www.google.com/

It prints the URL you gave it and then resolves the URL and
prints the long URL. Pretty simple. 

So I decided to put this program in a short URL. Here we have [j.mp/TaHyRh](http://j.mp/TaHyRh) which will resolve to:

    http://queryecho.herokuapp.com/?echo%20%22$url%22;%20curl%20-ILs%20%22$url%22%20|%20grep%20Location%20|%20grep%20-o%20'http.*'

Luckily I didn't have to do all that URL encoding. I just pasted his
code in after `queryecho.herokuapp.com/?` and bitly took care of it.
What's funny is that this example program is made to run on short URLs,
so when I told him about it, my example ran on the short URL that
contained the program itself:

    $ curl -Ls http://j.mp/TaHyRh | url=http://j.mp/TaHyRh bash
    http://j.mp/TaHyRh
    http://queryecho.herokuapp.com/?echo "$url"; curl -ILs "$url" | grep Location | grep -o 'http.*'

You may have noticed my version of the program uses `$url` instead of
`$1` because we have to use environment variables to provide input to
curl-pipe-bash scripts. For reference, to run my URL script against the
google.com short URL we made before, it would look like this:

    $ curl -Ls http://j.mp/TaHyRh | url=http://j.mp/www-google-com bash
    http://j.mp/www-google-com
    http://www.google.com/

Okay, so we can now put Bash scripts in short URLs. What happened to
installing apps in Tweets? Building an `apptweet` program like Joel
imagined would actually be pretty straightforward. But I wanted to build
it in and install it with these weird programs-in-short-URLs. 

The first obstacle was figuring out how to get it to modify your current
environment. Normally curl-pipe-bash URLs install a downloaded program
into your `PATH`. But I didn't want to install a bunch of files on your
computer. Instead I just wanted to install a temporary Bash function
that would disappear when you leave your shell session. In order to do
this, I had to do a variant of the curl-pipe-bash technique using eval:

    $ eval $(curl -Ls http://j.mp/setup-fetchtweet)
    $ fetchtweet 279072855206031360
    @jf you asked for it... Jeff Lindsay (@progrium) December 13, 2012

As you can see by inspecting that URL, it just defines a Bash function
that runs a Python script from a Gist. I cheated and used Gist for some
reason. That Python script uses the Twitter embed endpoint (same one
used for the embedded Tweets in this post) to get the contents of a
Tweet without authentication. 

The next thing I built installed and used fetchtweet
to get a Tweet, parse it, put it in a Bash function named by the string
after an `#exectweet` hashtag (which happens to also start a comment in Bash). So here we have a Tweet with a program in it:

<blockquote class="twitter-tweet tw-align-center"><p>echo Hello world <a href="https://twitter.com/search/%23exectweet">#exectweet</a> helloworld</p>&mdash; Jeff Lindsay (@progrium) <a href="https://twitter.com/progrium/status/279087620145958912" data-datetime="2012-12-13T04:57:28+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>

To install it, we'd run this:

    $ id=279087620145958912 eval $(curl -Ls http://j.mp/install-tweet)
    Installed helloworld from Tweet 279087620145958912
    $ helloworld
    Hello world
    
We just installed a program from a Tweet and ran it! Then I wrapped this
up into a command you could install. To install the installer. This time it would let you give it the URL to a Tweet:

    $ eval $(curl -Ls http://j.mp/install-exectweet) 
    Installed exectweet
    $ exectweet https://twitter.com/progrium/status/279087620145958912
    Installed helloworld from Tweet 279087620145958912
    $ helloworld
    Hello world
    
Where would I go from there? An app that calls itself into a loop, of course!

<blockquote class="twitter-tweet tw-align-center"><p>exectweet <a href="http://t.co/ri0XTprA" title="http://j.mp/recursive-app">j.mp/recursive-app</a> ; recursive-app <a href="https://twitter.com/search/%23exectweet">#exectweet</a> recursive-app</p>&mdash; Jeff Lindsay (@progrium) <a href="https://twitter.com/progrium/status/279123541054595074" data-datetime="2012-12-13T07:20:12+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>

    $ exectweet https://twitter.com/progrium/status/279123541054595074 && recursive-app
    Installed recursive-app from Tweet 279123541054595074
    Installed recursive-app from Tweet 279123541054595074
    Installed recursive-app from Tweet 279123541054595074
    Installed recursive-app from Tweet 279123541054595074
    ...

Obviously, this whole project was just a ridiculous, mind-bending exploration.
I shared most of these examples on Twitter as I was making them. Here
was my favorite response.

<blockquote class="twitter-tweet tw-align-center" data-in-reply-to="279087620145958912"><p>@<a href="https://twitter.com/progrium">progrium</a> End of the world, brought to you by Jeff Lindsay, via the Internet collapsing in on itself and taking the world with it.</p>&mdash; Matt Mechtley (@biphenyl) <a href="https://twitter.com/biphenyl/status/279088441084497922" data-datetime="2012-12-13T05:00:44+00:00">December 12, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"> </script>

You may have noticed, it just happened to be 12/12/2012 that day.

<style type="text/css">
.twitter-tweet-rendered {
  clear: none!important;
}
.twt-reply {
  display: none!important;
}
</style>
