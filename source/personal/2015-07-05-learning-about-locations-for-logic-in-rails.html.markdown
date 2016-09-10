---
title: Learning about Locations for Logic in Rails
date: 2015-07-05 07:30 UTC
tags: tealeaf, rails, logic
---

I just created a feature for a Netfilx type app where a `user` can add a `video` to their queue.  I had to have this added video be the last one on the user's queue items list.

This presented a certain type of logic so I implemented as follows: as video's are added to their queue, the position attribute of the `queue_item` as in `queue_item.position` is incremented so that it's the last item added in the `my_queue#index` view.

The interesting thing was that the position was determined as follows:

~~~ ruby
def position_assignment
  current_user.queue_items.size + 1
end
~~~

and, I didn't really know where to put it.  I could have put it in several places really:

* Application Controller
* User Model
* QueueItems Controller
* QueueItem Model

Long story short, I put `position_assignment` in the *User Model* since that was the object ultimately being sent a message.

This brings me to the question, how do you determine where to send certain methods?  I was told to follow something like this:

* *Application Controller and Helpers:* for presentation type methods or general methods
* *Model:* for business logic and data type methods
* *Controllers:* keep small and generally methods here are particular to specific controllers

#### Things to think about:

* Is this method generally specific to a model/class?
* Would you need to use this method throughout the application (ie. in the view and model)
* Does this method apply to several models/calsses?

I'm still learning how this all should be answered, but I'm sure it'll make sense later.
