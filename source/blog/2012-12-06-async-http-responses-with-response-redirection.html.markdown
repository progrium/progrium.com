---
layout: post
title: "Async HTTP Responses with Response Redirection"
description: ""
category: 
tags: []
---
What if you could perform any HTTP request, but get the response back via a webhook? This is the simple goal of Response Redirection, a simple micro-protocol for telling an HTTP server to send the response to a URL. Instead of returning the response in the connection created by the request, the response is returned in HTTP callback fashion.

The primary use case for this is handling HTTP responses that take longer than you would prefer to keep an open connection. As we build APIs that start interacting with the real world and human processes, you could expect operations that might take hours to days to complete. 

### Example of Response Redirection

Response Redirection is done by performing a regular HTTP request with two additions: a Pragma directive telling the server you want the response to be redirected, and a Callback to be used for the response.

	GET /helloworld HTTP/1.1
	Host: example.com
	Pragma: redirect
	Callback: <http://server.com/callback>; method="post"; rel="redirect"

The response to this is a 202 Accepted or an appropriate error code. 202 Accpted is the standard response to give for operations that have been accepted and will be processed or finished later. As soon as the server as processed the request and has rendered a response, it would perform a request:

	POST /callback HTTP/1.1
	Host: server.com
	Status: 200 OK
	Content-Length: 11
	Content-Type: text/plain

	Hello world

As we talked about with the [Callback header](http://progrium.com/blog/2012/11/26/x-callback-header-an-evented-web-building-block/), if a `secret` parameter was given, it would imply that an HMAC signature be provided in the callback request. We'll revisit this again in another post. 

If the server doesn't understand `Pragma: redirect`, it would return a normal response to the initial request and the client would have to handle it as usual.

### Using Pragma

You'll notice we didn't invent a header to tell the server to we want to do Response Redirection. You may remember Pragma's original use was only for `Pragma: no-cache` and was eventually replaced with other cache control headers. However, the semantics of Pragma remain useful. To quote the [HTTP 1.1 spec](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.32):

> The Pragma general-header field is used to include implementation-specific directives that might apply to any recipient along the request/response chain.

Another potential header field would be the [Expect header](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.20). The Expect header is designed to let the client specify certain behaviors expected of the server. This would be perfect except for this property:

> The Expect mechanism is hop-by-hop: that is, an HTTP/1.1 proxy MUST return a 417 (Expectation Failed) status if it receives a request with an expectation that it cannot meet.

In today's world, this renders it useless unless we were talking about changing the behavior of proxies. The Pragma header was designed to be forwarded by proxies and ignored if it doesn't know how to fulfill the directive. 

### Alternate Implementation

In the discussion that followed the Callback header post, not only did we learn that the `X-` header prefix [is now deprecated](http://tools.ietf.org/html/rfc6648), but there is an RFC draft called [Prefer Header for HTTP](http://tools.ietf.org/html/draft-snell-http-prefer-17).

It actually addresses the issue with the Expect header, providing an alternative for specifying optional preferences for how the server handles a request. One of the example preferences is for returning the response asynchronously, which is exactly what we're achieving with Response Redirection. The only missing element is the callback, which we can easily include with our Callback header. Here we augment an example directly from the spec:

	POST /collection HTTP/1.1
	Host: example.org
	Content-Type: text/plain
	Prefer: respond-async
	Callback: <http://server.com/callback>; rel="respond-async"
	
	{Data}

The server would respond with 202 Accepted, just as we would have had with the Pragma implementation. It's up for discussion which implementation is ideal.

### Last Thoughts

Granted, there are likely better ways to approach the use case we described at the beginning. Creating a resource immediately and subscribing to state changes might actually be ideal. Perhaps the Response Redirection spec is purely academic. That brings us again to the idea of HTTP Subscriptions, which I'll get to posting about soon. 

However, Response Redirection is a great example of a simple protocol built on top of the Callback header. The use of Prefer and Pragma will also set the stage for the design decisions of my initial informal draft of HTTP Subscriptions. It will continue this trend of reusing existing pieces of technology (Pragma, Expect, Prefer, Callback) as building blocks that, from my perspective, were intended to be re-combined to achieve new behavior.

Let me know what you think in the comments or in the [Webhooks Google Group](https://groups.google.com/forum/#!forum/webhooks).
