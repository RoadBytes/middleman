---
title: 'Simple Development Workflow'
date: 2016-12-14 02:24 UTC
tags: quick tutorials
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/ssPaefyqt-I" frameborder="0" allowfullscreen></iframe>

## Objectives: *'Very'* High level view of HTML and CSS

### Review a '*Simple Development Workflow*' where we:
  * use the terminal
  * create a webpage from the desktop
    * highlight concepts of HTML and CSS

---

## Quick Review

### Terminal: Application to manage files

* Fun to use!
* For mac, it's under Applications > Utilities > Terminal.app

### HTML: Hyper Text Markup Language

* It's a Domain Specific Language in which content is stored for the web
* uses tags and attributes
  * `<TAG ATTRIBUTE=VALUE></TAG>`

### CSS: Cascading Stylesheets

* A way to separate styling from content
* generally adds styling through: tags, classes, and ids

---

## Code snippets

### terminal commands

* changing directory to the `Desktop`

  `$ cd ~/Desktop`

* adding a blank directory

  `mkdir Page`

* making file 'index.html' in a directory

  `touch index.html`

### basic html page

~~~html

<!DOCTYPE html>
<html>
<head>

  <title>Page Title</title>
  <style>
    .loud {
      color: red;
    }
  </style>

</head>
<body>

  <h1 class='loud'>This is a Heading</h1>
  <p>This is a paragraph.</p>

</body>
</html>
~~~

---

### Linking the CSS file

* `<link rel="stylesheet" type="text/css" href="styling.css">`

---

## in the wild

### [w3schools sample in browser](http://www.w3schools.com/html/tryit.asp?filename=tryhtml_layout_float)

* multiple assignments
* gotcha's: last styling definition will be executed

### [Example Template](https://freewebsitetemplates.com/download/beachresort/)

* Nice Website

---

## Further Reading

* [Book: Duckett, *HTML and CSS: Design and Build Websites*](http://www.booktopia.com.au/html-css-jon-duckett/prod9781118008188.html?source=pla&gclid=CPbFqMnE8tACFYeUvQodR64FZg)
  * reviews different html tags and fundamental concepts
* [Website](http://www.w3schools.com/)
  * resource for looking up info or trying out code
* [Free Templates](https://freewebsitetemplates.com/)
  * free templates to play with

---

## Next Tutorial

* Free static site hosting on GitHub
