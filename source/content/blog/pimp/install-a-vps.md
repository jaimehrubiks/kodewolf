+++
date = "2017-04-30"
tags = ["pimp your devops life", "vps"]
title = "Pimp your devops life : Install a VPS"
description = "A new serie is starting : Pimp your devops life, and today we're gonna install the must have of every coder on this planet : a VPS."
meta_img = "/images/pimp/vps.jpg"
+++

Hi ! Today I'm starting a new blog serie, named **Pimp your devops life** : those articles aim to improve your day to day coder life on various subjects, showing you what you can do better and how to do it.

![intro](/images/pimp/intro.jpg)

### Who is this for ?

Everybody that can code and understand code, and wants to improve his life workflow ! However those blogs are not beginners ones, you should have some knowledge about computers before.

### What will I learn ?

I will teach and show you that you can **really** develop your day to day life : projects management, tools that are more than useful, media management, raspberry pi experiments ... All is done here to show you that you can **live better** with some code in your life.

# Install a VPS

The first thing every coder and devops profile should have is a **VPS** : a *Virtual Private Server*.

> A *VPS* is a virtual machine on a big cluster that contains hundred of them, often cheap but small

There are plenty of advantages to have one, and here are some of them :

* A place to experiment things without tracability (your identity cannot be retrieved from your IP)
* A place to host all your projects if they need to run 24/7, like websites, crawlers, API, etc. ...
* A place that have a shell if you don't have your computer with you
* A place to run tasks that need to run in background when you travel for example

In fact, a VPS is a must have for every coder that wants to run projects and experiments. So **get one**.

> If you wonder why a VPS and not a dedicated server or a AWS instance, you should read my [previous article](https://kodewolf.com/blog/what-to-choose-between-dedicated-servers-vps-and-cloud-offers-/).

![vps](/images/pimp/vps.jpg)

## Choose the best offer that fits you

As I said in my previous article, there is a lot of VPS offers out there, and they cost you different amounts of your money, so choose carefully.

Actually, we're here to *experiment* and have a place to put *side projects*, so we only need few things :

* A small CPU, to run some calculations, but not so much (if you want to do high CPU usage tasks just take a cloud instance like an AWS or Digital Ocean one for one hour, it will be cheaper)
* A bit of memory, but again not so much (high memory like machine learning tasks goes to cloud too)
* Some space to save files, and a SSD is a must to go fast
* No support, because we know how to deal with problems ;)

The cheaper that I found for those specs is a VPS from [Kimsuffi](https://www.kimsufi.com), a discount subsidiary from OVH : a [VPS SSD 1](https://www.kimsufi.com/fr/vps-ssd.xml) with 1vCore, 2GB of memory and a 10GB SSD for only 3 euros a month. I'm very happy with it now, but if you find one cheaper for you don't hesitate to try for a month and then evolve to something else if you're not satisfied.

## What to do next

So now you may have a VPS now ... but what could you do it with it ? Here are some ideas to familiarize yourself with it, and maybe trigger some new projects in your brain :

* Install a proper shell, like [fish](http://fishshell.com/) or [zsh](http://www.zsh.org/)
* Install [Docker](http://docker.io) because it is awesome
* Run a website, a blog like this one for example
* Crawl some websites to gather data and experiment on it
* Make a bot that wakes you up, etc. ...

The sky is the limit ! Be creative, unleash everything you know in a small project on this new server. The next step for us will be to **install a VPN** in order to keep privacy on the net, but foremost create a virtual network between all your computers and machines, to access them from everywhere, even behind a strict firewall.