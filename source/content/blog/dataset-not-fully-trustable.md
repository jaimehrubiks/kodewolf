+++
date = "2017-01-28"
tags = ["machine learning", "dataset"]
title = "Why not use machine learning when the dataset is not fully trustable ?"
description = "My personnal experience with a not so good dataset in machine learning"
+++

Today I've understood that machine learning always needs a 100% sure dataset to train on. We will see why.

## Neural network to predict if an IP is a bot or not

While I was doing some stats about this blog, I suddenly thought about the fact that some requests were kind of weird :

* /admin-console 
* /sugarcrm//index.php?action=Login&module=Users
* /SQLiteManager-1.2.4/main.php
* /MySQLDumper
* /wordpress/wp-login.php
* /administrator
...

This is obviously not some kind of human, and it was that easy to detect some kind of bot. But some bot like the Google's one or the Baidu's one (the Chinese google) aren't asking those shadow pages and instead show their true nature in the User Agent :

```
Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)
Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
```

And some others are more hidden ... So I thought out a simple idea : use a neural network to identify which IP is a bot. But even if it seems a cool idea, it is hard to do because of the train dataset.

## The train dataset is all that matters

So I begun to develop this really simple application with [Keras](http://keras.io), a library on top of [Tensorflow](https://www.tensorflow.org/) to simplify the most the code. I created my dataset with diverse features like those :

* the user agent
* the number of request
* each request is a feature that contain the number of demand of that request (text processing)
* the rate of queries
* the geolocation

But when the time to label the data arrived, I was a bit lost. I started to do regex of the requests to specify if this is bot or not, but I understood that the neural network behind will not bring anything new ... Damn.

So I wondered why I can't use Neural networks, and I found out that creating labels with a human sens without knowing exactly the output is the wrong way to go. It seems obvious now but maybe one day you will find yourself in the same situation as me.

## Your data train needs to be 100% accurate

You can't do machine learning without a 100% sure data train. For example here my problem was to don't know at the beginning which IP was a bot or not. I use _Kibana_ and _ElasticSearch_ to index my nginx logs, and I thought _Kibana_ would help me classify the IP but in fact I was only looking at the user agent or the pages requested. If the process is as simple as looking in _Kibana_ which IP is what with those clues then a simple tree of `if` and `else` can do it, and there is no need to implement a Neural Network.

The goal of machine learning is to combine features in a very complex model that our brain understand without telling us. When we see a picture of a car for example, we **see the car** with our brain, but when we try to explain why it gets confused and we can't just tell some `if` to summarize it. When the process is far easier, like seeing which path a IP requests and determine if it is a bot or not, machine learning is overkill.

But maybe there is a complex model behind bots, and this is why I need to have a **REAL** train dataset. If I create it from my brain, it will be too simple and not accurate : I'm not a specialist about bots, and it has not been 21 years that I interpret bot requests (in contrary of car pictures). However the dataset needs to be 100% accurate in order to reveal this complexe model.

Conclusion : take care of your dataset. See ya !