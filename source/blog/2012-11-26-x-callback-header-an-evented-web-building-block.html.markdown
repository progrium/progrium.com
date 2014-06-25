---
layout: post
title: "X-Callback Header: Evented Web Building Block"
description: ""
category: 
tags: []
---
<div class="alert alert-info">
Since this posting, we decided to adopt "best current
practice" and drop the X- prefix as described in <a href="http://tools.ietf.org/html/rfc6648">RFC 6648</a>. Future posts refer to this as the Callback header.
</div>
Webhooks is the simple concept of HTTP callbacks. It expands on the simple request/response model of HTTP, giving you the semantics of [callbacks in programming](http://j.mp/10EitT8). Request/response gives you one response for one request in one synchronous operation. It's like invoking a function and getting a return value. With callbacks, after you register a callback, the callback will receive one or more invocations, perhaps minutes or hours apart. 

Callbacks are a necessary component of any evented or reactor-based system, like Node.js, Twisted, or EventMachine. So, naturally, HTTP callbacks are necessary to achieve [the Evented Web](http://progrium.com/blog/2012/11/19/from-webhooks-to-the-evented-web/).

Modeling callbacks in HTTP is somewhat straightforward. The callback is a URL. You perform an HTTP request against an application to register a callback URL. The application then performs an HTTP request to that URL to invoke that callback. 

Those high-level requirements are enough to set anybody in the right direction to effectively implement webhooks or HTTP callbacks for their application. The problem is that now every application implements the specifics differently. While this is fine to provide a callback paradigm for each application, it doesn't let us *build* on this paradigm. The Evented Web needs to agree on some standards, and the X-Callback header is one of those standards.

### X-Callback Header

The X-Callback header is a proposal for a common way to describe HTTP callbacks, primarily in the case of registering them. It does not get into the specifics for different ways of using HTTP callbacks, so it's more of a building block for APIs or larger protocols such as HTTP Subscriptions, which I mentioned [in my previous post](http://progrium.com/blog/2012/11/19/from-webhooks-to-the-evented-web/).

Here's what it looks like to use X-Callback:

	X-Callback: <http://example.com/callback>; method="post"

The format is directly borrowed from the [Link header](http://www.w3.org/Protocols/9707-link-header.html) used for responses. You provide a URL and then optional key-value parameters. In the case above, the HTTP method for invoking the callback was specified as a parameter. 

Here is a more formal description of the header:

    X-Callback     = "X-Callback" ":" #("<" URI ">" *( ";" callback-param ) )
    callback-param  = token [ "=" ( token | quoted-string ) ]

Since this is just the beginning of the conversation, there are no "built-in" callback parameters in this definition. They're effectively all extensions. However, these are what I'd propose for standard parameters:

* __method__: The HTTP method preferred for invoking this callback. Servers can ignore or override based on their policies, but this lets the requester optionally state preference.
* __secret__: The secret to be used for signing callback requests. More on this in the next section.
* __rel__: The relationship of this callback to this request, similar to the rel of the Link header. This lets you specify the role of this callback, which is useful when multiple callbacks are provided. It effectively lets you classify the callbacks.

### Authenticating with Signatures

A common pattern across most implementations of webhooks has been the use of signatures for authenticating the callback "invocation" requests. Either built-in to the X-Callback header spec or maybe as a separate extension, a standard way of providing a secret then building and including a signature would be a Good Idea. The following is a proposal based on PubSubHubbub's signature model, but is not that different from the majority of implementations out there.

We start with a shared secret. Transmission of this secret can be done out of band (through a dashboard, for example), or the secret can be provided via the _secret_ parameter of the X-Callback header during registration. 

The secret can then be used with HMAC to sign anything. In the case of callbacks, it would sign the body of the callback request body. Since you can use different hashing techniques with HMAC, the technique used is specified along with a hexadecimal digest of the HMAC signature. This is put in the X-Signature header of requests:

	X-Signature: sha1=0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33

Now the callback handler can rebuild this signature knowing the secret and having the content body and the hash technique. Authenticating is then comparing the built signature with the one provided in the X-Signature header. 

Signing lets the callback handler be more certain of the source without requiring SSL. Signatures become much less necessary if all requests are using HTTPS. But having this simple complement to X-Callback makes it easy when you need it, and may help unify all the different approaches that are all effectively doing the same thing.

### Example Callback Flow

Let's use all this in an example, showing you the actual HTTP requests. First, we're going to register a callback at a particular endpoint:

	POST /callbacks/register HTTP/1.1
	Host: server-example.com
	X-Callback: <http://example.com/callback>; method="post"; secret="opensesame"
	Content-Length: 0
	

The server can respond however it likes since X-Callback header doesn't specify anything more than how to hand the server a callback. Let's assume it returned 200 OK. 

Now, whenever it likes, the server is going to be performing an HTTP POST on the callback URL. Since a secret was provided, the server will be providing a signature using the X-Signature header. Here's what one of those requests might look like:

	POST /callback HTTP/1.1
	Host: example.com
	Content-Type: application/json
	Content-Length: 26
	X-Signature: sha1=76afe1da675cf6d3d59c71a4af44dafc69fd03f0

	{"payload": "Hello world"}

You'll notice we've stayed completely out of the content layer of HTTP. This is quite intentional. This gives implementors lots of flexibility and keeps this a "pure" extension to HTTP.

### A Building Block

As I've mentioned, this header is intended to be used in APIs and protocols that use callbacks in different ways. The obvious example is HTTP Subscriptions, which will let you subscribe to events using HTTP callbacks. 

Another example, which I'll also talk about soon, is HTTP Response Redirection. Regular [HTTP Redirection](http://en.wikipedia.org/wiki/URL_redirection#HTTP_status_codes_3xx) lets the server redirect the client's request to another URL, whereas Response Redirection lets the client redirect where the server sends the response using an HTTP callback.

The X-Callback header is simple, focused, and content neutral. Hopefully this makes it a powerful building block for other technologies of the Evented Web.
