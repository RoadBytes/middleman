Hi! These are the [middleman](https://middlemanapp.com)
source files for my website [roadbytes.me](http://roadbytes.me/)

I love static site generation because it's just so much more sensible for my
blog posts.  Some reasons include:

  * it is fast
  * it eliminates a need for security
  * it's free with GitHub hosting
  * it's a great way to learn about ruby web development

# There are major types of posts I'm working on

* RoadBytes: TuneUps
* RoadBytes: Construction Zone

## TuneUps

These posts are write ups of my experience in refactoring various code bases.

They are meant to help intermediate developers by practicing various skills:

* Working with git
* Code Literacy
* Refactoring
* Collaborating

Here is my first [TuneUp Post](http://roadbytes.me/technical/2016/09/08/tune-up-poker.html).  It's on a code base meant to organize Poker Hands.

## Construction Zone

https://www.youtube.com/embed/zFGVtx6N9Jw

These are videos of various study places around the world I'm visiting.

I'll evaluate:

* Cost
* Hours of operation
* Wifi
* Power Outlets
* Toilets
* Atmosphere (not study oriented)
* Other

# Highlights of things in the code base

## Styling

* Currently, I've fashioned my site to look like an Emacs editor.
  * this was inspired by my play with 'Org mode' and ['SpaceMacs'](http://spacemacs.org/)
* I use [Bourbon](http://bourbon.io/) instead of Bootstrap because I think it's a bit cleaner and
  it helps me learn more about css, and html.
* [I wrote a post on how I think about creating css classes](http://roadbytes.me/technical/2016/07/19/organizing-my-stylesheets.html)

## Noteable cofigurations

In the [config.rb](https://github.com/RoadBytes/middleman/blob/master/config.rb),
I was able to make some interesting adjustments to the middleman template

### I have two different blogs, `Personal` and `Technical`

* Since I make a lot of different type of posts, I thought it would be good to
  separate them out and group my code related posts in one place.

### I'm a big fan of [question toggling](http://roadbytes.me/technical/2016/07/16/better-learning-with-question-toggling.html)

* Because of this, I created a helper method that makes it easy for me to add
  toggled questions into blog posts.

* Here is the code of my `question_toggle` method

~~~ ruby
helpers do
  def question_toggle(question, answer, textbox = false)
    textarea_html = "<textarea rows='4' style='color: green' " +
                    "placeholder='write your answer before checking mine'>" +
                    "</textarea>"
    textarea_result = textbox ? textarea_html : ""

    "<div class='question'>" +
    "  Q: #{question}"       +
    "  <div class='answer'>" +
    "    A: #{answer}"       +
    "  </div>"               +
    "</div>"                 +
    textarea_result
  end
end
~~~

* Styling and functionality is added through `.question` and `.answer` classes.

~~~ javascript

// middleman/source/javascripts/app.js

$(document).ready(function() {
  // hide all answers on page
  $('.answer').hide();
  // toggle for answer when clicked
  $('.question').click(function(event){
    $('.answer', this).toggle();
  });
});
~~~

~~~ sass

// middleman/source/stylesheets/components/_question.scss

.question {
  &:after {
    content: "(click to toggle answer)";
    display: block;
  }
  &:before {
    content: "Check for Understanding";
    display: block;
    text-decoration: underline;
  }
  &:active,
  &:focus,
  &:hover {
    color: darken($action-color, 80%);
  }

  border-style: dotted;
  color: $action-color;
  font-size: 1.5em;
  padding-left: 1em;
  margin: 1em;
  transition: color 0.1s linear;

  .answer {
    color: $base-font-color;
    transition: color 0.1s linear;

    p, pre {
      margin: 0;
      padding: 0;
    }
  }
}
~~~

# Continual Change

I will be continually changing up my website as I learn more.  For feedback or
suggestions, email me at jason.data@roadbytes.me
