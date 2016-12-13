---
title: 99 bottles of OOP Poetry
date: 2016-12-13 05:12 UTC
tags: oop, sandi metz, 99 bottles of oop
---

I'm reading 99 Bottle of OOP, and I saw this bit that helped me see how there is
a poetry to coding to *Discover* connections in the problem space.

In the book, you're asked to implement an interface that returns the song '99
Bottles of Beer'.  One method involves `verse(number)`, and tests are made for
verse 99, and 3, since they would all be very similar.  Here's a excerpt from
the book.

~~~ruby

def verse(number)
  if number = = 99
    "99 bottles of beer on the wall, " +
    "99 bottles of beer.\ n" +
    "Take one down and pass it around, " +
    "98 bottles of beer on the wall.\ n"
  else
    "3 bottles of beer on the wall, " +
    "3 bottles of beer.\ n" +
    "Take one down and pass it around, " +
    "2 bottles of beer on the wall.\ n"
  end
end

Sandi Metz, Katrina Owen. 99 Bottles of OOP (Kindle Locations 1188-1204). 
~~~

One thing that I thought was interesting was the idea of separating what's
changing from what's constant.  Like so,

~~~ruby

def verse( number)
  if number = = 99
    n = 99
  else
    n = 3
  end

  "#{n} bottles of beer on the wall, " +
  "#{n} bottles of beer.\n" +
  "Take one down and pass it around, " +
  "#{n - 1} bottles of beer on the wall.\n"
end

Sandi Metz, Katrina Owen. 99 Bottles of OOP (Kindle Locations 1221-1238). 
~~~

Here, the author shows how we now have insight to how the code can be abstracted
for other verses.  There is a template for the verses that are similar.
