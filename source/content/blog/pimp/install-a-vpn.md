+++
date = "2017-05-13"
tags = ["pimp your devops life", "vpn"]
title = "Pimp your devops life : Install a VPN"
description = "Today on Pimp your devops life, we're gonna learn how to install a personnal VPN on our VPS, to keep our Internet safe, private, and create a link between every computer."
meta_img = "/images/pimp/vpn.jpg"
+++

A **VPN** is a must have for an hitchhiker of the Internet world. As I previously demonstrated in an [earlier article](https://kodewolf.com/blog/is-there-any-privacy-with-the-dns-protocol-/), even if the HTTPS might be activated on a website, that doesn't mean that your connection is **private**,  and most of the time this means that it is not.

![vpn](/images/pimp/vpn.jpg)

In the not so uncommon case where you're connected to a public wifi somewhere, the local Internet provider (the restaurant for example) could see every *DNS* query you make and the IP addresses you're communicating with. If the planets are aligned and they're in fact working for the Russians : you might be in front of an imminent danger.

> But how can I protect myself from this vicious restaurant where the fries were so floppy ?

I feel the duty to teach you how to defend yourself : today we are gonna install a VPN on your freshly [VPS](https://kodewolf.com/blog/pimp-your-devops-life--install-a-vps/).

# Why a VPN ?

The privacy issue is for most blogs and tutorial the number one argument, but in fact there is plenty of good benefits to have a VPN :

* A VPN stands for **Virtual Private Network**, that means that the first goal of this thing was to create a local subnet between your computers, even if they were behind a firewall in North Korea. It is in fact really useful, to ping your home server with a `192.168.x.x` address, or sync files with SSH even if there is a firewall in front of your server.
* Dodge every firewall that only checks at the entrance on the usual ports (because the connection is initiated by the computer behind the firewall), and they are a lot out there. That means escape a nasty Turkish government or what so ever for example.
* Redirect all your traffic outside, escaping a DNS spoofing for example on your local subnet (in that really not so good restaurant for example).

Convinced ? You might be thinking that it is *hard* to install something that offers so many tradeoffs, but I will show you that you could be **ready in 5 minutes**.

# Let's pimp this VPS

**First step :** install [Docker](https://www.docker.com) and on [Docker-compose](https://docs.docker.com/compose/install/) this server, it is really useful and it is part of the *5 minutes* plan (I'm in fact not a magician).

**Second step :** create a folder for your VPN config, like this :

```
$ mkdir vpn
```

Be careful the difficulty is increasing.

**Third step :** create a `docker-compose.yml` file with our VPN container, like that :

```
$ vim docker-compose.yml
```

And then pasting this config :

```
version: '2'
services:
  openvpn:
    cap_add:
     - NET_ADMIN
    image: kylemanna/openvpn
    container_name: openvpn
    ports:
     - "1194:1194/udp"
    restart: always
    volumes:
     - ./openvpn-data/conf:/etc/openvpn
```

It is a really simple `docker-compose.yml` file, I'm sure you can understand what it does.

**Fourth step :** Config time, with small commands :

```
$ docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.YOURDOMAIN.COM
$ docker-compose run --rm openvpn ovpn_initpki
```

Replace `VPN.YOURDOMAIN.COM` by yours, and with or without the subdomain `VPN`.

```
$ docker-compose up -d openvpn
$ export CLIENTNAME="your_client_name"
$ docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
$ docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
```

Replace again `your_client_name` by the name of your computer you want to connect to your VPN. You can reproduce those 3 last lines for each client you want to connect to your server.

**Last step :** Connect your computer to it, with some commands :

```
$ sudo apt-get install openvpn
```

 Retrive the `.ovpn` config file on your server with a `scp` :

```
$ sudo scp me@vps_ip_or_dns:~/vpn/client_name.ovpn /etc/openvpn/vps.conf
```

And when you are ready, launch it :

```
$ sudo systemctl start openvpn@vps
```

Yeah ! You can check that it is working with a `curl` on some websites :

```
$ curl ifconfig.co
IP address of your server
```

# Enable it at each reboot

It is a bit boring to launch the OpenVPN service each time my computer is booting, so let's go to enable it :

```
$ sudo systemctl enable openvpn@vps
```

But if you have configured a passphrase on your client config, it will not start. In order to skip this, we're gonna provide it. Edit the `vps.conf` config file, and add this line :

```
askpass /etc/openvpn/vps.pass
```

Create this file, and add your pass in it. Let's protect it :

```
$ sudo chown root:root /etc/openvpn/vps.pass
$ sudo chmod 600 /etc/openvpn/vps.pass
```

This way it would be only visible by the root user, and your VPN connection will start at each reboot.

And this is it, now you have your ass covered by your VPS, and you can ping every computer you have on the globe with its `192.168.x.x` ip address.