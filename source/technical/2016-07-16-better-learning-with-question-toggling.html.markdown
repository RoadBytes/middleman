---
title: "Better learning with question toggling"
date: 2016-07-16 22:08 UTC
tags: javascript, beginner
---

## Objective:

* talk about levels of comprehension
* think critically with implementation of a jQuery toggle feature for blog posts

## Recall vs Recognition:

If you're learning to code, there are a different levels of comprehension of material to consider. A deeper level of comprehension is *Critical Thinking*, which may involve deducing information and many calculations.  Two other levels we'll consider here are [Recall and Recognition](http://blogs.psychcentral.com/always-learning/2010/01/recognition-vs-recall/).

With *Recall*, the information must be retrieved totally from memory. Think of fill in the blank:

> Q: What do McDonald's employees call frequent buyers of their food? <input type="text" name="states" placeholder="fill in the blank">

In contrast, with *Recognition*, most of the information is presented and the correct answer only needs to be recognized. Think multiple choice:

> Q: What do McDonald's employees call frequent buyers of their food?
>
> Choose one:
>
> * "Suckers"
> * "Lucky Ones"
> * "Heavy Users"
> * "McClients"
>
> [To find out, see #2 from this page](http://www.livin3.com/50-cool-and-weird-fun-facts-that-you-should-know)

## Getting better at understanding memory

Activation of memory can be stimulated more quickly depending on:

* context, cues in the material
* recency, when was the last time you thought of the memory
* practice, Critical Thinking, Recognition, and Recall

Learning coding is somewhat challenging because some people think they understand something when they see an answer to some question and recognize that it is correct.  This might not be good enough in reality, because most of coding does not involve a multiple choice style level of memory.

Recall can be even better in studying since it activates more rigorous memory engagement. With more rigorous engagement, it can shorten the time to study by promoting more neural connections.  Even better is critical thinking, where you're meant to deduce the information, and this type of comprehension is what is practiced most with coding.

## Adding Recall to blog posts

Having said all this, I think it would be cool to have Recall questions in blog posts to help practice material.  A simple way to implement this would be a way to toggle answers by clicking on the provided questions.

<div class="question">Q: What are two different methods of memory retrieval.
  <div class="answer">
    A: Recall and Recognition, (plus Critical Thinking if you thought about it)
  </div>
</div>

### Prerequisite Knowledge

* Familiarity with jQuery, we can practice a little critical thinking
* we have the following classes to access the specific elements

~~~ html

<div class="question">
  Q: [insert question here]
  <div class="answer">
    A: [insert answer here]
  </div>
</div>
~~~

With this set up, I can have the following javascript, but there will be a problem:

~~~ javascript

$(document).ready(function() {
  // hide all answers on page
  $('.answer').hide();
  // toggle for answer when ".question" clicked
  $('.question').click(function(event){
    $('.answer').toggle();
  });
});
~~~


<div class="question">
  Q: Can you think about what main trouble comes from this implementation?
  <div class="answer">
    A: all selected '.answer's will be toggled on any '.question' click event
  </div>
</div>

The jQuery selector was interesting because the context defaults to the root of
the DOM, but if you provide a second argument, it will work with that context `$(selector, context)`

If was change line with the `toggle()` to this `$('.answer', this).toggle();`

now only `.answer`'s in the `.question` that is clicked will toggle.

~~~ javascript

$(document).ready(function() {
  // hide all answers on page
  $('.answer').hide();
  // toggle for child '.answer' when clicked
  $('.question').click(function(event){
    $('.answer', this).toggle();
  });
});
~~~

## Review

Learning to code will be challenging, but it will also help you improve your learning speed and metacognition.  Don't get frustrated if you think you know something and have trouble practicing more complex memory/comprehension tasks.  Just stick with it and try to climb up the memory complexity ladder and you'll be a pro in no time.

<div class="question">
  Q: What method is being called on '.answers' when the page is first loaded?
  <div class="answer">
    A: 'hide();'
  </div>
</div>
