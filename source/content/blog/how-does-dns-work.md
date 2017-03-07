+++
date = "2017-02-07"
tags = ["how", "dns"]
title = "How does DNS work ?"
description = "The DNS is the thing that allows humanity to use URL with words and not IPs, and this is how it works."
meta_img = "/images/internet_use.jpg"
best = true
+++

If you have ever been curious about how the Internet is built, you might be familiar with the concept of DNS.  This protocol is really important for people because it makes them remember **words** and not IP addresses to access a website, with what we call a **domain name** (kodewolf.com for example). And today we will see how DNS works.

# Why is it called a "domain" name ?

A bit of theory here. The term "domain" is well chosen because domain names have a pyramidal organization. Take this domain for example :

    www.example.com

There are here three levels and each is similar to a domain : 

* *com*, a subdomain from the **root** domain
* *example.com*, a subdomain from the .com domain
* *www.example.com*, a subdomain from the .example.com domain

The **root** domain that I mentionned might seem a bit obscure but it's only a blank domain which redirects its child to the authoritative server corresponding. This domain is powered by [13 root servers](https://en.wikipedia.org/wiki/Root_name_server) which are possessed by multiple internet operators in different countries. For example, they ensure that the *.com* redirects to the *gtld-servers.net* server family.

![server](/images/server.jpg)

So remember that DNS is a matter of **domain**, and that's why it works. **Each domain know where to find the subdomains**. Let's go for more explanation now.

# What happens when I ask for a website ?

As I said, DNS is a matter of domain, so the DNS client we've got with the OS kernel will ask step by step, domain by domain, the website you ask. 

In order to understand, the first step is to watch a real DNS resolution with the `dig` tool :

```
fuego@fuego-XPS-13-9350 ~> dig +trace google.com

; <<>> DiG 9.10.3-P4-Ubuntu <<>> +trace google.com
;; global options: +cmd
.           55041   IN  NS  j.root-servers.net.
.           55041   IN  NS  i.root-servers.net.
.           55041   IN  NS  d.root-servers.net.
.           55041   IN  NS  f.root-servers.net.
.           55041   IN  NS  m.root-servers.net.
.           55041   IN  NS  b.root-servers.net.
.           55041   IN  NS  h.root-servers.net.
.           55041   IN  NS  c.root-servers.net.
.           55041   IN  NS  e.root-servers.net.
.           55041   IN  NS  a.root-servers.net.
.           55041   IN  NS  l.root-servers.net.
.           55041   IN  NS  k.root-servers.net.
.           55041   IN  NS  g.root-servers.net.
.           496359  IN  RRSIG   NS 8 0 518400 20170217050000 20170204040000 61045 . dz4yMiYjxpGAkz4chPK2SqC+gURagN6jj7PbSIUlFIUyDgm6hY/ul8lz l1F6MQuEB8uKncw5pfkV5RI1k/k1P4OSCeFTIHbW3HUAp1DbQAglpj9Z UO9QFGmbZT35dco6Sa6Jvr3yPfdOza3px5wzP0Ryb//BNciMiRH550+T vgGyGDVmM9ySuBxRjq3A57y0Uxg7Gk5FArhq2PQi99+w0rkWhAsCX1Ny 0uY1+byrmifmCDF4SUbRBgN9X/dH3IxjJAqJyXVC0fQ2zL/m8Q43//xN WMh281QbJ3yLbhIjHYbCSvtIMsVn1gd33n5lsETt6IEe5qmOinhPMJAn CZ8lCA==
;; Received 1069 bytes from 127.0.1.1#53(127.0.1.1) in 3 ms

com.            172800  IN  NS  h.gtld-servers.net.
com.            172800  IN  NS  j.gtld-servers.net.
com.            172800  IN  NS  e.gtld-servers.net.
com.            172800  IN  NS  b.gtld-servers.net.
com.            172800  IN  NS  g.gtld-servers.net.
com.            172800  IN  NS  k.gtld-servers.net.
com.            172800  IN  NS  l.gtld-servers.net.
com.            172800  IN  NS  c.gtld-servers.net.
com.            172800  IN  NS  m.gtld-servers.net.
com.            172800  IN  NS  f.gtld-servers.net.
com.            172800  IN  NS  d.gtld-servers.net.
com.            172800  IN  NS  i.gtld-servers.net.
com.            172800  IN  NS  a.gtld-servers.net.
com.            86400   IN  DS  30909 8 2 E2D3C916F6DEEAC73294E8268FB5885044A833FC5459588F4A9184CF C41A5766
com.            86400   IN  RRSIG   DS 8 1 86400 20170217170000 20170204160000 61045 . QD/WRld9BN4xEuD4S0ZzXXpstQdDHYFE2M28PDyp6eHoukOKxujv68MX rksiWb+vg6y202OSu4YXM2a7bHHBAY6sNMHn36mPzEUko6OAzZsWMknd Qp09wvNVir/6LOa+cIaaUoVk1mHPMxWKtGP5lgmg4ltJIv63bt3Qjz3E jAGZE/taDCzAjNyrPJqpdxq444YRVgswfHyY2Hgiiv8YUuqq0Z8Gf+6z oWqG+eAKcGJltNbPHzPMpoEQnhDTGET+DQFbHnOuK3qpY3D8mCNHEuC5 0RMihBDOgiz6q3zmtRu0k6noJx1I8V7rpCjuNml5Ff2MO60IALcIp9D7 5MiHWQ==
;; Received 862 bytes from 2001:500:2d::d#53(d.root-servers.net) in 105 ms

google.com.     172800  IN  NS  ns2.google.com.
google.com.     172800  IN  NS  ns1.google.com.
google.com.     172800  IN  NS  ns3.google.com.
google.com.     172800  IN  NS  ns4.google.com.
CK0POJMG874LJREF7EFN8430QVIT8BSM.com. 86400 IN NSEC3 1 1 0 -    CK0Q1GIN43N1ARRC9OSM6QPQR81H5M9A NS SOA RRSIG DNSKEY NSEC3PARAM
CK0POJMG874LJREF7EFN8430QVIT8BSM.com. 86400 IN RRSIG NSEC3 8 2 86400 20170210054655 20170203043655 31697 com. TvTE8yZ6srb46lkoeKQanChz8My0rBFXFM2PEG8XRR9l2gHc80dX89cw PjUHQpRMKbevLxd8Xhpq7/yXAetum07NMGvOxqotYlpVK3d2GY/LD05+ M3cSJCT5KScXHrEoXwNq99ztOqaaVaYRBhzPckIpQtyO8uXA6VXLAmAE Kjg=
S84AE3BIT99DKIHQH27TRC0584HV5KOH.com. 86400 IN NSEC3 1 1 0 - S84C439C9HACCNUVH6CBPPTUS93VLTUG NS DS RRSIG
S84AE3BIT99DKIHQH27TRC0584HV5KOH.com. 86400 IN RRSIG NSEC3 8 2 86400 20170208054033 20170201043033 31697 com. Dbh36LYQ22OQh9F/1FnbFRaGpS0FrsDBOIE9/AAGCeT+M6DKLoOdiRPP PQluiz0/H3zoEyIarW+GDcuUaVey1ERkN0U/NhYBuLluw47TKmHWkmWY HdU1YUTB5BrzV0RiEYzWVe7tIyx6qZV0RujCeE+q2gZNcrRLN63hyC9l jAA=
;; Received 660 bytes from 192.33.14.30#53(b.gtld-servers.net) in 25 ms

google.com.     300 IN  A   216.58.213.174
;; Received 44 bytes from 216.239.38.10#53(ns4.google.com) in 8 ms
```

Woah ! A big answer ! We can separate this in 4 parts, which are 4 different answers from different servers. Let's decrypt this one by one (I removed the useless lines).

## The root servers

```
.           55041   IN  NS  j.root-servers.net.
.           55041   IN  NS  i.root-servers.net.
.           55041   IN  NS  d.root-servers.net.
.           55041   IN  NS  f.root-servers.net.
.           55041   IN  NS  m.root-servers.net.
.           55041   IN  NS  b.root-servers.net.
.           55041   IN  NS  h.root-servers.net.
.           55041   IN  NS  c.root-servers.net.
.           55041   IN  NS  e.root-servers.net.
.           55041   IN  NS  a.root-servers.net.
.           55041   IN  NS  l.root-servers.net.
.           55041   IN  NS  k.root-servers.net.
.           55041   IN  NS  g.root-servers.net.
;; Received 1069 bytes from 127.0.1.1#53(127.0.1.1) in 3 ms
```

The first servers our DNS ask for are root servers ("." zone), in order to get the IP address of an authoritative server for the `.com` domain.

### An authoritative server ?

An authoritative server is a trusted server that rules a domain zone and can answer to demands about its zone. For example, the root servers are authoritative servers on the root zone.

### Why does 127.0.1.1 answer me ?

Maybe this is not your case, but if you are running Ubuntu you should have the same answer. This is because Ubuntu's Network Manager has `dnsmasq` built in, a lightweight dns server that forwards every query to the DNS specified in the network configuration.

### How does my system know which DNS to ask for root servers ?

The DNS servers your OS knows are in the file `/etc/resolv.conf` :

    # Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
    #     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
    nameserver 127.0.1.1

No surprise here, this redirects to the `dnsmasq` instance running on my machine because of Ubuntu. If you not running it, you will see something like this :

    # Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
    #     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
    nameserver 8.8.8.8
    nameserver 8.8.4.4

### I never specified a nameserver in this file, how did my OS know ?

When the **DHCP** answers you an IP address when you ask for one, it also gives you a main DNS address and a secondary. Those addresses are either stored in the `resolv.conf` or in the `dnsmasq` configuration.

So in fact it was my primary DNS which answered me the addresses of the root servers.

### Addresses ? Those look like domain names ...

Yes but in fact those domain are a bit specials ... They're **Glue records** : their IP addresses are stored in the DNS configuration even if this server is not an authoritative server of the zone. To confirm this we can `dig` it :

```
fuego@fuego-XPS-13-9350 ~> dig +norec @127.0.1.1 d.root-servers.net NS

; <<>> DiG 9.10.3-P4-Ubuntu <<>> +norec @127.0.1.1 d.root-servers.net NS
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2044
;; flags: qr ra; QUERY: 1, ANSWER: 0, AUTHORITY: 13, ADDITIONAL: 27

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;d.root-servers.net.        IN  NS

;; AUTHORITY SECTION:
root-servers.net.   162050  IN  NS  f.root-servers.net.
root-servers.net.   162050  IN  NS  a.root-servers.net.
root-servers.net.   162050  IN  NS  e.root-servers.net.
root-servers.net.   162050  IN  NS  i.root-servers.net.
root-servers.net.   162050  IN  NS  l.root-servers.net.
root-servers.net.   162050  IN  NS  h.root-servers.net.
root-servers.net.   162050  IN  NS  c.root-servers.net.
root-servers.net.   162050  IN  NS  g.root-servers.net.
root-servers.net.   162050  IN  NS  m.root-servers.net.
root-servers.net.   162050  IN  NS  d.root-servers.net.
root-servers.net.   162050  IN  NS  b.root-servers.net.
root-servers.net.   162050  IN  NS  j.root-servers.net.
root-servers.net.   162050  IN  NS  k.root-servers.net.

;; ADDITIONAL SECTION:
a.root-servers.net. 86779   IN  A   198.41.0.4
a.root-servers.net. 434923  IN  AAAA    2001:503:ba3e::2:30
b.root-servers.net. 159235  IN  A   192.228.79.201
b.root-servers.net. 435366  IN  AAAA    2001:500:84::b
c.root-servers.net. 74402   IN  A   192.33.4.12
c.root-servers.net. 401590  IN  AAAA    2001:500:2::c
d.root-servers.net. 385 IN  A   199.7.91.13
d.root-servers.net. 426650  IN  AAAA    2001:500:2d::d
e.root-servers.net. 510810  IN  A   192.203.230.10
e.root-servers.net. 404516  IN  AAAA    2001:500:a8::e
f.root-servers.net. 189377  IN  A   192.5.5.241
f.root-servers.net. 493882  IN  AAAA    2001:500:2f::f
g.root-servers.net. 160151  IN  A   192.112.36.4
g.root-servers.net. 426650  IN  AAAA    2001:500:12::d0d
h.root-servers.net. 60078   IN  A   198.97.190.53
h.root-servers.net. 401590  IN  AAAA    2001:500:1::53
i.root-servers.net. 29324   IN  A   192.36.148.17
i.root-servers.net. 493882  IN  AAAA    2001:7fe::53
j.root-servers.net. 246024  IN  A   192.58.128.30
j.root-servers.net. 493882  IN  AAAA    2001:503:c27::2:30
k.root-servers.net. 162437  IN  A   193.0.14.129
k.root-servers.net. 510810  IN  AAAA    2001:7fd::1
l.root-servers.net. 159687  IN  A   199.7.83.42
l.root-servers.net. 427955  IN  AAAA    2001:500:9f::42
m.root-servers.net. 92741   IN  A   202.12.27.33
m.root-servers.net. 493882  IN  AAAA    2001:dc3::35
```

Yeah ! The `ADDITIONAL SECTION` is exactly what we wanted, this way we know the exact addresses of the servers. The IP addresses of the DNS are **glued** to the domain name itself : even if it looks like a domain, there is always a IP behind.

This is really a core feature of the DNS protocol because without it it would be impossible to query the `root-servers.net` domain without itself (we need it to know the `.net` zone) ! This is why **every DNS has the root server list built in it in Glue records :** this way each time a new request is made, the DNS know where to ask, in term of IP address, without the need to ask someone else.

![library](/images/library.jpg)

However every server doesn't have every glue record built in, but only the ones that are useful to find a sub-domain, like we will see in the next answer, the `.com` part. 

## The `.com` domain

```
com.            172800  IN  NS  h.gtld-servers.net.
com.            172800  IN  NS  j.gtld-servers.net.
com.            172800  IN  NS  e.gtld-servers.net.
com.            172800  IN  NS  b.gtld-servers.net.
com.            172800  IN  NS  g.gtld-servers.net.
com.            172800  IN  NS  k.gtld-servers.net.
com.            172800  IN  NS  l.gtld-servers.net.
com.            172800  IN  NS  c.gtld-servers.net.
com.            172800  IN  NS  m.gtld-servers.net.
com.            172800  IN  NS  f.gtld-servers.net.
com.            172800  IN  NS  d.gtld-servers.net.
com.            172800  IN  NS  i.gtld-servers.net.
com.            172800  IN  NS  a.gtld-servers.net.
;; Received 862 bytes from 2001:500:2d::d#53(d.root-servers.net) in 105 ms
```

So we asked a root server (the `d.root-servers.net)` one) the `.com` domain. Again, **Glue records** are here to provide IP addresses behind those domain names. You can check it with the `dig +norec h.gtld-servers.net NS` command.

There are glue records here because we can't know the IP address of `h.gtld-servers.net` directly without asking to the DNS of `gtld-servers.net`, which is ... `h.gtld-servers.net` ... yeah. With a glue record, the parent server answers where to continue even if it's inside the subdomain.

Now next step is the Google part !

## The `google.com` domain

```
google.com.     172800  IN  NS  ns2.google.com.
google.com.     172800  IN  NS  ns1.google.com.
google.com.     172800  IN  NS  ns3.google.com.
google.com.     172800  IN  NS  ns4.google.com.
;; Received 660 bytes from 192.33.14.30#53(b.gtld-servers.net) in 25 ms
```

The `b.gtld-servers.net` said to me where to find the google DNS ! With ... ? **Glue records** yeah ! You understood perfectly ;) The answer however is a bit different :

```
google.com.     300 IN  A   216.58.213.174
;; Received 44 bytes from 216.239.38.10#53(ns4.google.com) in 8 ms
```

**An IP !** Victory ! We now know where to ask when we want Google.

# Recursive server and cache

The DNS adventure we just saw is a little biased in fact. It would be very hard to load each domain this way, mainly because of the charge that would imply for famous DNS like the root servers for example.

![internet_use](/images/internet_use.jpg)

In order to fix this, the better solution is **caching**. This is why Internet browsers are caching the DNS response, and even sometimes the OS itself. But the charge would still be too huge for the poor 30-year-old root servers, so there is a need to cache for multiple users.

The current way to do this is to always query a DNS that other people use too and let it do the job : ask for the root servers, the global domains and then the website we want. This way, this server will cache each answer and serve it to everybody who's asking : this kind of server is called a **Recursive server** (8.8.8.8 is a reccursive server for example).

## The `dig +trace` does not exactly represent the reality

With this parameters, `dig` creates a tiny DNS that does the role of the recursive server instead of asking the one in our network configuration. It is in fact the only way to see each answer :)

# The format of a DNS record

```
google.com.     172800  IN  NS  ns2.google.com.
google.com.     300 IN  A   216.58.213.174
```

If you wonder how to read those lines, it is really simple !

* The `google.com.` is the domain we're asking.
* The number right after is the **TTL** (time to live) of the record. This is the time the recever should keep this in cache in order to have cache and a up-to-date record.
* The `IN` speciefy the goal of the record, here to give an endpoint.
* The `NS` stands for **NameServer** and `A` means an **IPv4** while `AAAA` an **IPv6**. It gives the nature of the record, the last term.

# Security and privacy

Well ... there is a lot to talk about in this section, and that might interest more people than just those that are curious about DNS, so I will talk about it my next article !

If you want a teaser, keep in mind that there is no such thing as "security" and "privacy" in the DNS protocol, and a lot of other issues that matters.

# Conclusion

Hope that was useful to you ! Don't hesitate to contact me if you don't understand something, and see ya !

## Final bonus

The root domain has a blank domain name, a url is in reality :

    www.example.com..

But browsers allows us to not write the last points ! ;)