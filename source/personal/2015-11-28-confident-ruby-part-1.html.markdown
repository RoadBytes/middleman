---
title: "Confident Ruby Part 1"
date: 2015-11-28 13:13 UTC
tags: ruby, confident ruby, methods
---

I just started reading *Confident Ruby* and I like how clear Avdi presents certain concepts.  Here are some notes I have from his book.

## Methods

Thinking about methods, it's good to have an idea of the order in which to handle it's different parts:

1. Input Collection
2. Performing Work
3. Delivering Output
4. Handling Failures

Being a newbie, it's great to get exposed to the meta question of, "What are methods?" and "How should they look?"

There is a strong sense of **Story Telling** that holds together a lot of the concepts in writing good code.  The programmer should make clear what a method does and how it handles the four main parts of her methods.  With this context: *Duck Typing*, *Sending Messages*, *Identifying Roles*, and *Architecture* make much more sense in guiding the implementation of applications and making the information clear.

## Collecting Input

Ruby converter methods are analyzed:

* `to_s` vs `to_str`
* `to_a` vs `to_ary`
* ...

There is a distinction between *explicit* and *implicit* conversions.  Mainly:

* explicit: converts objects and other data that "might not be like the target" with out exception.
* implicit: more often raises an exception, and operates behind the scenes; hence, implicit.

~~~
ie.

`(1..10).to_a => [1, 2, 3, 4, 5]`

converts a "range" to an array.


`(1..10).to_ary => NoMethodError`

converting a "range" to an array raises an exception
~~~

Generally, handling input can be seen to fall into three broad categories:

* Coerce objects into roles
* Reject unexpected values
* Substitute known good objects for unacceptable ones

