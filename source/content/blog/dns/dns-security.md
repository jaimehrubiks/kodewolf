+++
date = "2017-03-11"
tags = ["dns", "security"]
title = "The security of the DNS protocol"
description = "The DNS protocol is something essential in the web sphere, but we will see that it is not secured."
meta_img = "/images/old_lock.jpg"
best = false
+++

Hi ! Today we're gonna see the **security** aspect of the DNS protocol. If you're interested in web, you should be used to the following statement :

> "HTTPS everywhere ! We need to secure the web'

That's right, but is really HTTPS securing *everything* on Internet ? Let's see that.

## What is HTTPS ?

When Internet started to democratize, more and more people were spending time on it, especially to buy things with the rise of marketplaces like eBay, and some bad people suddenly realized that robbering banks was no longer the best choice when you wanted to make easy money. In fact, they discovered that only a cheap computer was needed to steal a lot of things.

That was the time of **Man-in-the-middle** attacks, when some people in the same places you were started to intercept your packets, sometimes full of credentials, especially bank ones. This was why Internet needed security, and the HTTPS was born.

As you probably know, the **S** stands for **Secure** because this protocol can communicate with a distant server *securely*. How is it done ? Simple.

All you need is two pairs of asymetric keys, and if you don't know what is it you should read this [wikipedia page](https://en.wikipedia.org/wiki/Public-key_cryptography). When your browser is asking for a page on a secure website, it will encrypt it with the **certificate** of the distant site : the certificate is the public key of the server. The server has obviously the key to decrypt your message and will answer you with a message encrypted with your public key, that you can decrypt with your private one. All transmissions are this way secure : only you and the server can see the potential credentials you're sending.

The other aspect of the HTTPS for the end user is that you know that you can trust the server your sending informations to. In fact, even if the transmission is secure, an attacker could set up a false server that looks like the Facebook's one, and receive, securely, your credentials. With HTTPS, the certificate of the distant server is always the same and has to be authorized by a **Certificate Authority**, that verifies the identity behind a server, so you can know when you are on Facebook and not on another site.

## Why DNS has no security

In fact, if an end user needs an Certificate Authority that validates a domain name, it is because a malicious DNS Server could indicate a wrong server for `facebook.com`. This way, even if the false Facebook has HTTPS enabled, its certificate will not be approuved and your browser will reject it.

> A malicious DNS ? How that is possible ?

Yep, that is what you think. A DNS query is everything but secured, and HTTPS was an answer to it. We decided not to secure a protocol but to change another to solve the related issues.

![old_lock](/images/old_lock.jpg)

When you query a DNS server, the packet is not encrypted at all, and no certificate is checked to see if the server has the right to answer us. If a malicious server tells you that `facebook.com` is a wrong IP, your computer will trust it. Those kind of attacks are called **DNS Poisoning** and are relatively easy to set up thanks to the lack of control from our computer.

## Explore the DNS queries that pass through a firewall

In order to visualize it, let's see some packets that passes through a firewall on the DNS port, the 53 :

```
22:38 root@firewall # tcpdump -i eth2 port 53
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth2, link-type EN10MB (Ethernet), capture size 262144 bytes
18:19:10.289104 IP artikodin.via.ecp.fr.47590 > 193.108.88.128.domain: 29852 [1au] A? cl3.apple.com.edgekey.net.globalredir.akadns.net. (77)
18:19:10.292531 IP 193.108.88.128.domain > artikodin.via.ecp.fr.47590: 29852- 1/0/1 CNAME e2842.e9.akamaiedge.net. (111)
18:19:10.293022 IP artikodin.via.ecp.fr.36184 > a88-221-81-195.deploy.akamaitechnologies.com.domain: 34558 [1au] A? e2842.e9.akamaiedge.net. (52)
18:19:10.294957 IP a88-221-81-195.deploy.akamaitechnologies.com.domain > artikodin.via.ecp.fr.36184: 34558*- 1/0/1 A 104.94.171.234 (68)
18:19:10.309692 IP 95.45.189.12.15602 > artikodin.via.ecp.fr.domain: 65483 [1au] AAAA? update.videolan.org. (48)
18:19:10.309945 IP artikodin.via.ecp.fr.domain > 95.45.189.12.15602: 65483*- 1/0/1 AAAA 2a01:e0d:1:3:58bf:fa02:c0de:5 (76)
18:19:10.406358 IP 203.205.147.152.domain > artikodin.via.ecp.fr.9925: 62539*- 0/1/1 (95)
18:19:10.408091 IP artikodin.via.ecp.fr.57345 > 182.140.184.140.domain: 47922 [1au] AAAA? q.qlogo.cn. (39)
18:19:10.410935 IP host74-28-static.38-85-b.business.telecomitalia.it.46755 > artikodin.via.ecp.fr.domain: 46652 [1au] A? wiki.videolan.org. (46)
```

The `artikodin.via.ecp.fr` address you can see is the **Secondary DNS** of the domain I was an administrator of, and surprise : nothing is encrypted, I can see the queries that are going through the firewall without struggle.

If I was a bad guy, I could have answer the secondary DNS some malicious websites, and people asking this DNS would have be **poisoned**. Hopefully, my browser would know the wrong certificates and warn me, but only if HTTPS is enabled. And you can see on [this report of Google](https://www.google.com/transparencyreport/https/grid/?hl=en) that a few top sites are always working with no HTTPS.

## Conclusion

Be careful when using a not secured website, because even if the url in your browser bar is showing the right site, you never know if the server you're using is malicious or not. Hope you've learned something about the DNS security, something more people should be aware of.

See ya !
