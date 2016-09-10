---
title: Learn Beginner Web Development by starting your own blog
date: 2015-08-28 16:58 UTC
tags: beginner, web development, blog
---

There are a ton of blogging software options for coders these days: Wordpress, Blogger, and ummmm, I don't really know the list because I don't use these things that much, feel free to look them up.  I thought I'd make a tutorial for beginners to not only learn about the basics of web development, but also make their own blog while they are at it, for free.  I know there are people of all different skill levels, but FYI I start with zero assumptions to maximize the accessibility of the tutorials; this may be at the risk of sounding condescending, so if you feel that way... YOU'RE ALRIGHT... RELAX!

## Lesson 1 HTML and Browsers (5 to 10 mins)

---

*Objective:*

## The goal of this lesson is to simply connect the idea that *EVERY* web page is essentially an HTML file.

---

The gist of every web page is simply a file.  It's letters in a file arranged in a special way.  Specifically, it's a syntax called *HTML* and it looks a little something like like this:

~~~ html
<!DOCTYPE html>
<head>
  <title>Page Title</title>
</head>
<body>
  <h1>This is a heading</h1>
  <p>This is a paragraph.</p>
</body>
~~~

Things to note:

* the things in angle brackets, `< >`, are tags.
* Generally pages have a `<head></head>` and a `<body></body>`
* *HTML* has a nested structure:
  * there is a opening and closing tag for most tags
  * tags can be *inside* others

### Activities

#### *(Activity One)* Look at the *HTML* of this page:

* if you right click on the page you should see some options.
* it'll look something like this:

![picture of how to access view page source option](images/view-page-source.png)

* looking at the page source, notice the syntax
* can you see the tags? which ones stand out? where does the closing head tag `</head>` sit?


![picture of source code of page](images/page-source.png)


#### *(Activity Two)* Make your own web page from your desktop

Now, you're going to make your own html file and open it from your desktop

* create a file "index.html" and save it to your desktop
* write any text you want in it
* open it...

* create another file "other.html" and write this inside

~~~
<!DOCTYPE html>
<head>
  <title>Page Title</title>
</head>
<body>
  <h1>This is a heading</h1>
  <p>This is a paragraph.</p>
</body>
~~~

* open it...

What do you notice that's different from your "index.html" and "other.html" files?

If you had any observations or questions, feel free to leave them below.

---

*Objective:*

## The goal of this lesson is to simply connect the idea that *EVERY* web page is essentially an HTML file.

---

There is of course much more to consider.

## Congratulations! You've finished Lesson 1


## Lesson 2 Your Development Environment

---

*Objective:*

## The goal of this lesson is to get you understanding how to develop locally

---

