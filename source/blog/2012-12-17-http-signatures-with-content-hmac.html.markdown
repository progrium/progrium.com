---
layout: post
title: "HTTP Signatures with Content-HMAC"
description: ""
category: 
tags: []
---
Today I wanted to propose another header. It would be used for signing HTTP content with HMAC, and is appropriately called Content-HMAC. In [a previous post](http://progrium.com/blog/2012/11/26/x-callback-header-an-evented-web-building-block/) about the Callback header, I mentioned using an X-Signature header in callback requests to sign the payload of the callback. It looked like this:

	X-Signature: sha1=<hexdigest of sha1 hmac>

The HMAC would be built with just the content of the request (i.e., no headers, no query params) and a secret key. [This was borrowed directly from the PubSubHubbub spec](http://pubsubhubbub.googlecode.com/svn/trunk/pubsubhubbub-core-0.3.html#authednotify), but the general idea of using HMAC to sign callback requests has become pretty standard in the world of webhooks. Here are details on how [Google](http://code.google.com/p/support/wiki/PostCommitWebHooks#Authentication) and [Twilio](http://www.twilio.com/docs/security#validating-requests) use them.

Each of these providers is using their own header for basically the same use case. It would seem like there is an opportunity to standardize on a common header format for it. There's been a number of proposals for a general Signature header to sign an entire request. There was a fairly comprehensive one proposed called [Content-Signature](http://tools.ietf.org/html/draft-burke-content-signature-00). With signing, the difficulty is often getting the input string correct. Most signing mechanisms need to normalize their input. If you've ever had to deal with OAuth or AWS signatures, you'll know what I'm talking about. With request signing, the headers pose a particularly tricky situation with signing since they often change as the request goes through proxies.

The idea of Content-HMAC is to focus on a simpler goal of signing just the content payload, since it's normally treated as-is, and is not altered when going through proxies. The X-Signature proposal I had was a decent one, as is almost any cowpath-based proposal, but I realized it would probably be a good idea to limit the implied scope to what it's really doing: providing an HMAC for request (or response) content.

It turns out there's a similar header that's not used that often anymore called Content-MD5. It was a simple mechanism to provide an MD5 digest of the content. My current proposal is to take this existing pattern and apply it to HMAC, giving us the Content-HMAC header:

	Content-HMAC: <hash mechanism> <base64 encoded binary HMAC>

Here's an example:

	Content-HMAC: sha1 f1wOnLLwcTexwCSRCNXEAKPDm+U=

This proposal borrows its naming convention from Content-MD5, but the format is more similar to Authorization. The Authorization header allows multiple authorization schemes to be used. You define the scheme followed by a space and then the actual authorization data. Since HMAC allows different hashing techniques to be used, we use that pattern here to let you specify the hashing technique. We also take the existing pattern of base64 encoding used in several HTTP headers to make it conform even more to existing standards. 

Content-HMAC was created for callback requests, but it's a useful way to sign any HTTP request or response payload. For requests, it's worth mentioning it only applies when there is a content payload, so for example it's meaningless with GET requests. 

It's also very worth mentioning that the need for content signing is unnecessary when using HTTPS. It currently looks like the future will eventually be 100% SSL encrypted HTTP, but until then, there will always be situations where HTTPS is not available. Content-HMAC is perhaps a stop-gap until we reach that ideal. Until then, I think Content-HMAC is a good, standard way to add authorization to callback requests.

Let me know if you have any questions or feedback on this proposal. Further discussion is likely to happen on the [Webhooks Google Group](https://groups.google.com/forum/#!forum/webhooks).
