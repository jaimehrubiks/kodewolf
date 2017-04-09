+++
date = "2017-04-09"
tags = ["hash code", "machine learning"]
title = "Google Hash Code 2017 : our attempt"
description = "For the first time I've decided to participate to the Google Hash Code with some other friends, and this is what we've learned from this competition."
meta_img = "/images/hash_code.png"
best = false
+++

For the first time I've decided to participate to the Google Hash Code with some other friends, and this is what we've learned from this competition.

<img src="/images/hash_code.png" alt="hash_code" style="width: 300px;" />

# Machine learning can't solve everything

Okey, maybe you're laughing right now, but this started from a good will to **learn** about the limits of machine learning.

The practice problem was about slicing a pizza we were given in order to get the best score with constraints. With the recent applications on the net about the now famous *Generative Models*, we decided to make one to create slices from a neural model, like a human should have done. And here we are, coding a neural network with :

* As input : a matrix which is the pizza
* As output : an array which represents the best slices

That seems a little bit crazy I know, but we were really enthusiastic about it. The differences with a classic Generative Model is that we don't have a neural network after it to determine if the result is good or not (like if we generate images of cars and a neural network behind is giving a score to the generated picture, according if it sees a car or not).

I've thought that it didn't matter, and that all I needed was to modify the **objective function** in order to work it out, but I was wrong.

Neural networks are not magic at all, they adapt their score with a **gradient** that makes them go in a better direction. Here the end of the pipeline and the pizza in input were not related by any *linear function* at all, so our neural network didn't really know where to improve.

The point of having another neural network (that is trained by the way) at the end is to complete the linear pipeline i.e allow a gradient to be generated and then applied.

# Algorithm to the rescue

After having learn from our first attempt, we were ready to go back to normal algorithm with a good old **Branch and bound**.

And it worked quite nicely in fact, the branch and bound is a strong algorithm that always gives you a good solution at first, and will with time improve its best solution.

With a clever score or two, you can make the branch and bound refute a good amount of solutions at the beginning of a branch and improve its speed by far.

However, when the pizza began to be really huge, the branch and bound was overwhelmed and never gave a really good solution because the depth was too big.

# Split everything !

Yeah I know the goal of the practice problem was to make *slices*, but with a slow branch and bound the solution was to cut roughly the input and then give the smaller pizzas to branch and bound processes which were run in parallelism. We were now ready to compete on the real problem.

# Conclusion

In fact, we've **more learned** from the practice than from the real competition. We did a branch and bound but never really managed to do parallelism at all, so it was really slow. Maybe we now understand that we should have done a faster code that gives at least solutions instead of a perfect algorithm that gives us none at all.

Hope you enjoyed this competition like I did with my friends, and if you didn't participate you know what to do next year ! See ya !