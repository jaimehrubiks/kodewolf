+++
date = "2016-12-28"
tags = ["hardware", "rt3290", "ubuntu", "rtl8812au"]
title = "The horrible rt3290 realtek chipset and ubuntu"
description = "A story about my rt3290sta chipset and the mess it was to get it functionnal."
meta_img = "/images/high/ampli.jpg"
+++

Hi ! As you can see in my [backpack](/backpack/), I've got quite an old laptop : a HP Probook 4540s. This old girl is perfect for me : 6GB of memory, a dual-core CPU, a 500GB hard drive, a good screen and plenty of ports. But there is one thing I forgot to check : the wireless chipset.

![Old amplifier](/images/ampli.jpg)

# The Realtek RT3290

When I was under Ubuntu 14.04 there was no problem with this chipset. The wifi was not that good, but I thought it was like all other wireless cards : sometimes the connection restarted, sometimes a reboot was necessary to scan with it, etc... It didn't bother me : Linux is something that can't work everytime.

Then my laptop lived for a year with ArchLinux on it, and things started to be a little bit trickier. It was the new kernel 4.4's fault, but at that time I didn't know it yet, so each time I upgraded the kernel I spent a day or two without wireless connection until I figured how to fix it. But for me it was normal ! _Arch is not for everybody_, I thought _you always have to fix some little things_.

And now I'm with on new Elementary OS, based on Ubuntu 16.04, with the 4.4 kernel. And wifi is a pain.

Hopefully I'm not alone, if you google "_rt3290 ubuntu 16_" you will find tons of people with similar problems. The `rt2800pci` in the linux kernel is supposed to work with that chipset, but when the module is loaded a lot of people have their Network Manager wireless-blind. It was my case, so I did the same as everybody : I installed the patched semi-official module for the rt3290 with `dkms`, and it wasn't easy because the kernel module was always showing up, even if it was **blacklisted**.

But one day it worked. _Finally !_ But it was only an illusion. After each reboot the module I used was not able to connect to a wireless network. Sometimes the `rt3290` was working, after a reboot the `rt2800pci` alone was working, another reboot and it switched back to the `rt3290` etc... _Why ?_ No idea. But even if the wifi was working, it was not very good. I had a Dell XPS at work and I've understood what a **good** wireless chipset is.

# The fix

So I decided to replace the 3290 realtek chipset of my laptop by a Intel one, but it was more expensive than a simple wifi dongle. I decided so to take a **D-Link DWA-171** by looking in the official documentation of Ubuntu : [WirelessCardsSupported](https://help.ubuntu.com/community/WifiDocs/WirelessCardsSupported).

As the doc says, the driver module of the `rtl8812au` is not in the kernel, but someone compiled it from sources and it seems to work. It's also working with my laptop, and I'm very happy with it. Here is a small comparaison of speedtest :

![rt3290](/images/rt3290.png)

Above, with the `rt3290`, and below with the `rt8812au` in my D-Link DWA-171.

![rtl8812au](/images/rtl8812au.png)

And there is no more interruptions in my connection, whenever I reboot the module is always working. No more problems ! If you've got questions, I will be happy to answer them :)

See ya !