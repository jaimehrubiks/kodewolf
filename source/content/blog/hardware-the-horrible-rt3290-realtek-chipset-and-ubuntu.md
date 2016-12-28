+++
author = "Alexis Tacnet"
comments = true
date = "2016-12-28T23:19:32Z"
draft = false
featured = false
share = true
tags = ["hardware", "rt3290", "ubuntu", "rtl8812au"]
title = "The horrible rt3290 realtek chipset and ubuntu"
+++

Hi ! As you can see in my [backpack](./backpack/), I've got a quite old laptop : a HP Probook 4540s. This old buddy is perfect for me : 6GB of memory, a dual-core CPU, a 500GB hard drive, a good screen and plenty of ports. But there is one thing I've forgot to check : the wireless chipset.

![Old amplifier](./images/ampli.jpg)

# The Realtek RT3290

When I was under Ubuntu 14.04 there was no problem with this chipset. The wifi was not that good, but I thought it was like all other wireless cards : sometimes the connection restarted, sometimes a reboot was necessary to scan with it, etc... It didn't bother me : Linux is something that can't work everytime.

Then my laptop lived a year with ArchLinux on it, and things started to be a little more tricky. It was the fault of the new kernel 4.4, but at this time I didn't know it, so everytime I was upgrading the kernel there was a day or two without wireless until I figured how to fix it. But for me it was normal ! _Arch is not for everybody, you always have to fix up some little things_ I thought.

And now I'm with the new Elementary OS, based on Ubuntu 16.04, with the 4.4 kernel. And wireless is a pain.

Hopefully I'm not alone, if you google "_rt3290 ubuntu 16_" you will find tons of people with similar problems. The `rt2800pci` in the linux kernel is supposed to work with that chipset, but when the module is loaded a lot of people have their Network Manager wireless-blind. It was my case, so I followed everybody : I installed the patched semi-official module for the rt3290 with `dkms`, and it wasn't easy because the kernel module was always showing up, even if it was **blacklisted**.

But one day : it worked. _Finally !_ But it was only illusion. After each reboot the module I used was not able to connect to a wifi. When I used the `rt3290` module one time, a reboot and it was the `rt2800pci` that was working, and then again the `rt3290`. _Why ?_ No idea. But even if the wireless was working, it was not very good. I had a Dell XPS at my work and I've understood what a **good** wireless is.

# The fix

So I decided to replace the 3290 realtek chipset of my laptop by a Intel one, but it was more expensive than a simple wifi dongle. I decided so to take a **D-Link DWA-171** by looking in the official documentation of Ubuntu : [WirelessCardsSupported](https://help.ubuntu.com/community/WifiDocs/WirelessCardsSupported).

As the doc says, the driver module of the `rtl8812au` is not in the kernel, but someone compiled it from sources and it seems to work. It's working too with my laptop, and I'm very happy. Here is a small comparaison of speedtest :

![rt3290](./images/rt3290.png)

Above, with the `rt3290` one, and below the `rt8812au` in my D-Link DWA-171.

![rtl8812au](./images/rtl8812au.png)

And there is no more interruptions in my connection, whenever I reboot the module is always working. No more problems ! If you've got questions, I will be happy to answer them :)

See ya !