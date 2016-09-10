---
title: Looking for Code Love
date: 2015-08-14 19:45 UTC
tags: humor, codenewbies
---

Semi-Fictional Account of learning to code on your own. (Some names have been changed to protect the characters of this post)

## Me and Hal

I've been working on learning Rails for over a year now, and up until this point I haven't had much interaction with other human beings.  I've worked on CS50, other edX courses, Michaels Hartl's Rails tutorial, and a self paced online bootcamp Tea Leaf Academy, and the resources online are amazing.  Still, I can't help but feel like I'm missing out on something.

Some days I'd spend hours with my computer, a sturdy MacBook Pro with Intel Processor.  I even named him, Hal.  Things are generally great with Hal and me, Me and Hal.  Best friends forever.  Some days, I'd gently close Hal's screen and stroke his plastic cover.  We'd laugh about life and what we'd learned that day.  "Hey Hal, that was so cool to finally understand what MVC is right?"  I'd wait and see Hal sit there lifeless and silent.  "Crap, I need friends"

## Me and Gal

Scared that I just spoke to my computer, I try to find another friend in my life.  One that is actually human.  My wife, Gal.  Gal comes home from work and I attempt to talk to her about the excitement of the day.  "Hey Gal.  How was work?... Good!  Bye the way, I just learned about MVC and I think I'm ready to apply it to a real application."  Gal looks at me and asks, "That's awesome honey.  What's an MVC?"

"Well, it's a pattern used to make coding for certain applications more understandable.  There are Models to represent the objects, Views for presentation, and Controllers to facilitate actions.  So interesting right?"  I'm a bit more bouncy then a normal person should be and I wait and stare at her hoping to find some agreement.

Gal stares and tries to be supportive "Wow! That sounds great...  What do you mean by object?"

#### (five hours later)

I've tried to explain the technical and disconnected understanding I've just 'learned' to my patient and confused wife, "So yeah, Cookie Monster would be an instance of a Cartoon object, and eating could be a method..."

I love Gal, but some how I'm still missing something to support my solo learning career.

#### (Enter CodeNewbies)

## Me and Pal

I join the Slack channel and start interacting with people on the channel.  I meet a member, his name is Pal.

I say, "Hey Pal.  I just learned about MVC and I think I'm actually starting to get it."

Pal says, "Cool man.  That's awesome.  Wanna practice implementing it in Rails?"

### We look at a Remote Repo on GitHub add a sorting method to a Posts model.

~~~ Ruby
def self.sort_by_date
  sort_by &:created_at
end
~~~

### We remove the logic from one of the views to take advantage of our `sort_by_date` method.

~~~ Ruby
%article.row
  - @Posts.sort_by_date.each do |post|
    .post.col-md-2
    = link_to post do 
      = image_tag post.small_image_url
~~~

### We commit our local branch and push for a pull request.

~~~ Bash
$ git commit -m "Pal and Jason, Jason and Pal best friends for ever... implemented 'sort_by_date' to Post model"
~~~

### I finally understand things a bit more.  I find that support that helps me move forward.

So, yeah.  Learning on CodeNewbies has been amazeballs, since I have someone to practice a lot of the concepts I'm learning with.  Hal, is still there for me, and Gal lends a patient ear, and Pal helps me solidify my new learning to take things to a new level...  I still need friends.

**One day.**

## About the Author

Hi, my name is Cal, just kidding... Jason.  I'm learning to code Rails.  Reach me at 'jason.data@roadbytes.me'
