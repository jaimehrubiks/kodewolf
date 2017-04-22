+++
date = "2017-04-22"
tags = ["cloud"]
title = "What to choose between dedicated servers, VPS and cloud offers ?"
description = "Cloud offers are now used more than ever to power websites and online services, but the choice between dedicated servers, virtual private servers and AWS, Digital Ocean, etc ... is still tough."
meta_img = "/images/mac_rainbow.jpg"
+++

Cloud offers are now used more than ever to power websites and online services, but the choice between dedicated servers, virtual private servers and AWS, Digital Ocean, etc ... is still tough.

![mac_rainbow](/images/mac_rainbow.jpg)

# Why I was on a dedicated server

At the beginning, Kodewolf was hosted on a dedicated server provided by a discount [OVH](https://ovh.com) subsidiary named [Kimsufi](https://www.kimsufi.com/). Since I was doing some machine learning, I thought a dedicated server with 16Gb of memory and a CPU with 4 cores would be a *must have*, even if I was spending 20 euros a month on it.

Even with a lot of different services, like a Jupyter notebook, this website, and some other projects, my server activity time was really **low**. With the [TIG Stack I described before](/blog/telegraf-influxdb-and-grafana-experience-with-docker/), I analyzed the memory and CPU consumption of my dedicated server :

<img src="/images/crios.png" alt="crios" style="max-width: 800px;" />

Not really worth the price I was paying. The machine learning is in fact not something that takes the memory and the cpu all the time, but only one time a day for example, when you need to tune parameters with a big grid search on the whole dataset.

This motivated me to look after another solution, especially in the field of the well known and greatly appreciated cloud offers.

# The pricing in cloud services

I didn't know a lot of good cloud services, but the best according to my friends was [Digital Ocean](https://www.digitalocean.com/), so I looked up for their prices, to see if I was able to do some savings and be more efficient in my ressources consumption. Here is some *Digital Ocean* pricing :

[<img src="/images/do_pricing.png" alt="do_pricing" style="width: 400px;" />](https://www.digitalocean.com/pricing/#droplet)

Woah. It's really expensive ! I had trouble to compare it with the same thing I've got from *OVH* because it was not a SSD server, but in scale of CPU and memory, the same *Digital Ocean* server would have been in range between 80$ and 160$, which is really expensive.

Even if I only needed the cheaper droplet from this cloud service, it was a time when everybody in the world was pro-cloud offers while a dedicated server from *OVH* was 4 to 8 times cheaper. **What was wrong ?**

# Each product from each company has a different price

So I started digging a bit in different offers, and I found out a really huge range of prices for approximately the **same server** : 8 threads with 16Gb of memory and no SSD.

* The **OVH EG-16**, a dedicated server for **69,99 euros** a month
* The **SoYouStart SYS-IP-1**, a dedicated server for **30 euros** a month
* The **Kimsufi KS-4A**, a dedicated server for **21,99 euros** a month

> [SoYouStart](https://www.soyoustart.com) is a discount subsidiary from OVH, and [Kimsufi](https://www.kimsufi.com/) is an even more discount subsidiary.

All of them are **dedicated servers**, but if you take a look to a VPS at *OVH*, you could have 2 cores, 12Gb of memory with SSD for **16 euros** a month. *Digital Ocean* does not have this offer, but for only 4Gb of memory you will pay **40$ a month**, which is a lot more. What are the differences between all of those products ?

# Price = 90% of service, 10% of product

In fact it is the **service** provided with the server that is the most important in the price. You don't want the same service from a dedicated server, a VPS or a cloud offer, neither you expect the same quality between *OVH*, *SoYouStart*, *Kimsufi* or *Digital Ocean*. Here are some points that may change between those solutions and needs to be evaluated as well :

* The **SLA**, which represents the amount of time when the service is up and ready (really good for *Digital Ocean*, crap for *Kimsufi*)
* The support, if something goes wrong (awesome for a VPS, and not available for a dedicated server)
* The time to get an instance up and running (10 seconds for a cloud provider, two days for a dedicated server)
* The things installed on the server (a ELK pack for *Digital Ocean* for example, nothing for a dedicated server or a VPS)
* The manner to pay (monthly for *OVH*, hourly for *Digital Ocean*)
* Where is located the service (multiple choices for a VPS, only a few for a dedicated server)
* The number of available IPv4, etc. ...

And there's more ! But you can see that the price range can be explained by the differences between the service provided along the server itself, and in fact it is what matters the most.

# What to choose ?

If you understood well, it's quite more complicated than some simple `if` and `else` rules. It depends on the **service you want** : think about what you need, and take the cheaper.

To continue on my story in the beginning, I decided to take a VPS on *Kimsufi*, because :

* I didn't need a good support
* I didn't need a great amount for locations and IPs
* I didn't need a image of some software installed at the beginning
* I didn't need enough CPU and memory to take a dedicated server

To put all of these in a nutshell : I was looking for something simple, and not highly available. I took the cheaper : a **3 euros** a month VPS with 1 core and 2Gb of memory.

# Conclusion

To conclude, it is not that simple to choose between a dedicated server, a VPS or a cloud offer like an AWS or Digital Ocean one, but you just have to understand that it is the **service** with the server that matters the most. Identify what you need in services and you will progress towards the solution that fits you the best.

See ya !