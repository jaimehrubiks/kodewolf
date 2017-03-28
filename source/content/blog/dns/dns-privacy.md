+++
date = "2017-03-28"
tags = ["dns", "privacy"]
title = "Is there any privacy with the DNS protocol ?"
description = ""
meta_img = "/images/old_lock.jpg"
best = false
+++

On March 23 of this year, the Senate of the United States of America voted in favor of the repeal of Internet privacy rules which were instaured by Obama during his presidency. If the bill passes, biggest ISPs from America will be free to gather data from users' traffic and then use it, in a commercial way or not.

Let's be clear here, I'm not a big defender of privacy, but that looks a bit 'not cool'. However, we are developpers and computer engineers, we know how those things work and how to defend ourselves.

> I use HTTPS and a VPN, what could go wrong ?

In fact, those tools are not covering 100% of the data you may transmit, and today we're gonna talk about the privacy in the DNS protocol.

# The privacy between you and your DNS server

We've [previously saw](/blog/the-security-of-the-dns-protocol/) that the DNS protocol is not really secured, and that everybody that was in the middle of your connection, like your favorite Internet provider, could see with or without HTTPS your DNS query.

That is the first big issue in the DNS protocol : the websites you are visiting are no longer private if you **only** use HTTPS without a VPN.

## A VPN could save you on this

If you remember my previous article, I was saying that if someone was spoofing a Domain Name Server in your area, he could send you a wrong and risky IP to compromise your personnal data for example. A **VPN** is a good solution to this, and it's protecting your privacy from the firewall of your ISP too.

With a VPN, your DNS query will be secured to the VPN server and then a normal query will be done. This way, your ISP doesn't know what your browsing, and the VPN ISP doesn't know that it is you because it only sees the VPN IP address : you have **anonymity**.

## Practice

So let's a bit what it looks like in practice. I have two machines : one which is the VPN server, and another that is the VPN client. I've set up all of this with an OpenVPN docker image and it's working like a charm.

I've got the firewall between those two machines too, and here is what I see when I do a `dig ifconfig.co` on my OpenVPN client :

```
12:08 root@firewall /home/fw# tcpdump -i eth1 -n host 192.168.1.143
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth1, link-type EN10MB (Ethernet), capture size 262144 bytes
12:11:16.915081 IP 192.168.1.143.41409 > 192.168.1.201.1194: UDP, length 109
12:11:16.931907 IP 192.168.1.201.1194 > 192.168.1.143.41409: UDP, length 125
```

The `192.168.1.143` is my client, and the `192.168.1.201` is my server here, and my firewall can't see nothing about the DNS request I just made, only UDP with encrypted content. In the other hand, on the VPN server :

```
root@vpnserver:~ # tcpdump -i ens3 port 53
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on ens3, link-type EN10MB (Ethernet), capture size 262144 bytes
12:15:26.460177 IP 192.168.1.100.39684 > google-public-dns-a.google.com.domain: 22149+ [1au] A? ifconfig.co. (40)
```

Just after having decrypted the DNS query, the VPN server just executes it, and then answer my client in a encrypted way : **the DNS request is private**.

## Verify that your DNS query is going through your VPN

When I first did this, I didn't see my DNS query through the VPN, and it was because of the **routes** my network manager set up on my device :

```
root@client:~$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.255.5   128.0.0.0       UG    0      0        0 tun0
0.0.0.0         192.168.1.254   0.0.0.0         UG    0      0        0 eth0
192.168.1.201   192.168.1.254   255.255.255.255 UGH   0      0        0 eth0
128.0.0.0       192.168.255.5   128.0.0.0       UG    0      0        0 tun0
192.168.1.71    192.168.1.254   255.255.255.255 UGH   0      0        0 eth0
192.168.1.254   0.0.0.0         255.255.255.255 UH    0      0        0 eth0
192.168.255.1   192.168.255.5   255.255.255.255 UGH   0      0        0 tun0
192.168.255.5   0.0.0.0         255.255.255.255 UH    0      0        0 tun0
```

My DNS server in my `/etc/resolv.conf` was `192.168.1.201`, and my network manager decided to route it directly to the gateway on the interface `eth0` which is of course not my VPN interface. Just remove this route or change your favorite DNS server to be sure to go through your VPN.

# Your privacy in the DNS server

Now that you know how to keep away people in the middle of your request from the website your want to browse, we have to take a look on the other end of this connection : the DNS server.

Just look at this DNS server logs from Bind9, a popular DNS server software for linux :

```
14-Feb-2017 15:42:37.434 client 192.168.144.241#31322 (www.google.fr): query: www.google.fr IN A + (192.168.130.71)
14-Feb-2017 15:42:37.434 client 192.168.144.241#21762 (ajax.googleapis.com): query: ajax.googleapis.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.434 client 192.168.144.241#16488 (apis.google.com): query: apis.google.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.435 client 192.168.144.241#11275 (clients5.google.com): query: clients5.google.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.435 client 192.168.144.241#59332 (fonts.googleapis.com): query: fonts.googleapis.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.435 client 192.168.144.241#32604 (lh3.googleusercontent.com): query: lh3.googleusercontent.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.441 client 192.168.144.241#19642 (ogs.google.com): query: ogs.google.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.445 client 192.168.144.241#32694 (plus.google.com): query: plus.google.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.881 client 192.168.145.165#55761 (www.googletagmanager.com): query: www.googletagmanager.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.882 client 192.168.145.165#55254 (media.blizzard.com): query: media.blizzard.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.888 client 192.168.145.165#59958 (www-googletagmanager.l.google.com): query: www-googletagmanager.l.google.com IN A + (192.168.130.71)
14-Feb-2017 15:42:37.889 client 203.187.215.35#53033 (mb.videolan.org): query: mb.videolan.org IN A -ED (192.168.130.71)
14-Feb-2017 15:42:37.891 client 192.168.145.165#51775 (www-googletagmanager.l.google.com): query: www-googletagmanager.l.google.com IN AAAA + (192.168.130.71)
14-Feb-2017 15:42:37.910 client 192.168.145.165#54580 (a402.g.akamai.net): query: a402.g.akamai.net IN A + (192.168.130.71)
14-Feb-2017 15:42:38.002 client 192.168.147.35#57050 (dragonage.wikia.com): query: dragonage.wikia.com IN A + (192.168.130.71)
14-Feb-2017 15:42:38.003 client 192.168.130.72#56845 (17.128.195.138.in-addr.arpa): query: 17.128.195.138.in-addr.arpa IN PTR + (192.168.130.71)
```

All the IPs have been anonymised with `192.168`, but this is from a real network, and everything here is in clear. In fact, I could set up a ELK stack and then do statistics about everybody in the subnet.

## Who has access to those logs ?

It obviously depends on your DNS server you've chosen. If you didn't chose one in your network interfaces, your default DNS server is the one provided by your DHCP, and the most of the times it is your ISP's primary one.

If you don't trust your ISP, you should change your DNS for one provided by a trusthy VPN, or just create a DNS server on a VPS that will play the role of intermediate and will protect your real IP address.

# Conclusion

The DNS protocol is not something really secure, and so not really private. Besides some solutions are availables to protect you from your ISP that wants to sell your personnal data like your browsing history. Play safe, use a VPN !

See ya !