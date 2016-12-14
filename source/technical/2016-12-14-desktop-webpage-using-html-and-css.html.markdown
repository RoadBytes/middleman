---
title: 'Desktop Webpage: Using HTML and CSS'
date: 2016-12-14 02:24 UTC
tags: quick tutorials
---

## Objectives:

* use the terminal
* create a webpage from the desktop
  * highlight concepts of HTML and CSS

---

## Quick Review

HTML: Hyper Text Markup Language
* It's a Domain Specific Language in which content is stored for the web
* uses tags and attributes

CSS:  Cascading Stylesheets
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
  <link rel="stylesheet" href="css/styles.css">
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

### in the wild

[w3schools sample in browser](http://www.w3schools.com/html/tryit.asp?filename=tryhtml_layout_float)

* multiple assignments
* gotcha's: last styling definition will be executed

---

## Further Reading

* [Book: Duckett, *HTML and CSS: Design and Build Websites*](http://www.booktopia.com.au/html-css-jon-duckett/prod9781118008188.html?source=pla&gclid=CPbFqMnE8tACFYeUvQodR64FZg)
  * reviews different html tags and fundamental concepts
* [Website](http://www.w3schools.com/)
  * resource for looking up info or trying out code

---

## Next Tutorial

* Free static site hosting on GitHub
