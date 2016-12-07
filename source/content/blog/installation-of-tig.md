+++
author = "Alexis Tacnet"
comments = true
date = "2016-10-15T23:19:32Z"
draft = false
featured = false
share = true
tags = ["docker", "telegraf", "influxdb", "grafana"]
title = "Telegraf, InfluxDB and Grafana experience with Docker"
+++

Hey welcome back ! Today we're installing Telegraf, InfluxDB and Grafana with Docker !

# What are those ?

Maybe you never heard of the **TICK** stack, but it's very used in a lot of start-up, and you can use it too on your server. The main goal of this stack is collecting data on your infrastructure, store it, and the display it with pretty graphs to monitor everything.

* **T** stands for **Telegraf**, a data collector (like CPU usage, free Memory ...)
* **I** stands for **InfluxDB**, a database oriented to Time-Series data
* **C** stands for **Chronograf**, web interface to graph our data
* **K** stands for **Kapacitor**, which provide alerts to Chronograf

However, it has been proved that the two last are only necessaries if you need alerts. If you don't need them (like me for example), there is a better alternative to them :

* **G** for **Grafana**, a very powerful interface to graph everything.

Grafana offers multiple possibilities like accounts, groups, multiple data sources if you're not only using InfluxDB, dashboards, plugins, and graphs that are very pleasants to make.

![Grafana](/images/grafana.png)

So let's put up our **TIG** stack !

# Docker ?

Why is there Docker in this equation ? Because I love Docker and I encourage to use it. It's faculty to simplify everything is very nice here, and I already use it on my server. Docker-compose too is really useful, and it's only a file.

Docker is cool here because each element of the stack will be alone in a container, and if there is a cluster, you can link them easily with docker-compose. 

In fact, each container in the same docker-compose file will be in the same network, with a dns resolution.

# Let's go !

The capital element in the stack is the database. The database is always the link between the collection of data and the visualisation, and not only for this stack. For exemple, the ELK stack was at the beginning only Elastic Search, but the others plugged in after.

Our database is **InfluxDB**, a simple and effective database, with time based documents : each document has to give a timestamp to identify the time of the event. Docker provides a official image for InfluxDB, so we are writing in our docker-compose file :

	version: '2'

	services:
		## InfluxDB container
		influxdb:
	    	image: influxdb:latest
	    	restart: always

Kind of easy with docker. Our database is ready to accept data.

We are using **Telegraf** to collect our data. Telegraf can collect CPU data, memory, docker utilization, network, and a impressive amount of applications !
Go check its [doc](https://docs.influxdata.com/telegraf/v1.0/) to see all it can do ! And what ? A docker official image too ? So we put that in our docker-compose :

		## Telegraf container
		telegraf:
	    	image: telegraf:latest
	    	volumes:
	      		- ./telegraf.conf:/etc/telegraf/telegraf.conf
	      		- /var/run/docker.sock:/var/run/docker.sock
	    	restart: always

The Telegraf configuration can be obtained by running :

	$ docker run --rm telegraf -sample-config > telegraf.config

In the sample configuration, we have only to change to output of Telegraph :

	[[outputs.influxdb]]
		...
		urls = ["http://influxdb:8086"]
		...

With docker, no need to expose any port because everything is in the same network because we have only one docker-compose file. The DNS resolution is nice too : the name of the container permits Telegraf to find it.

And finally, the beautiful **Grafana** :

		## Grafana container
		grafana:
	    	image: grafana/grafana
	    	restart: always

No official image for it, but the organization behind this tool has done it for us.

# Launch it !

We don't wait more, we launch it with :

	$ docker-compose up -d

We can see in our navigator on port 3000 a identification page :

![Grafana login](/images/grafana_login.png)

It was so easy. Default user is **admin** and default password is **admin** too, so I change it in the settings, and the I add a data source (the link is in the menu) :

![Grafana source](/images/grafana_source.png)

The important here is the url of the database :

	http://influxdb:8086

The database name is **telegraf**, and the InfluxDB default credentials are **root/root**.

Here too the DNS resolution of Docker is very helpful, no need to know the container's ip, its name is sufficient.

Then in the Dashboards all is possible : create rows, graphs, text, ... The only limit is your imagination !

# Conclusion

We've seen that it's very simple to install those tools with Docker, and to gave them a try on a laptop for example. Grafana is really useful to monitor CPU usage, the number of virtual machines running, the amount of memory which is free ... and I couldn't do with it anymore !

If you need more inspiration, or you want to see how I use this on this server, you can go to my [frostfire project's github](https://github.com/fuegowolf/frostfire) :) Bye !