---
title: "Eloquent Javascript Exercises: Part 1"
date: 2015-11-22 23:45 UTC
tags: notes, javascript, eloquent, solutions
---

These are my solutions to some of the exercises from *Eloquent Javascript*

[http://eloquentjavascript.net/04_data.html](http://eloquentjavascript.net/04_data.html)

## Exercises

### The Sum of a Range

~~~
function range(start, end) {
  var step = 1;
  if(arguments.length > 2) {
    step = arguments[2];
  }
  
  array = [];
  if (step < 0) {
    for(var i = start; i > end - 1; i += step) {
      array.push(i);
    } 
  } else {
    for(var i = start; i < end + 1; i += step) {
      array.push(i);
    }
  }
  
  return array;
}


function sum(array) {
  var sum = 0;
  for(var i = 0; i < array.length; i += 1)
    sum += array[i];
  return sum;
}

 console.log(sum(range(1, 10)));
// → 55
console.log(range(5, 2, -1));
// → [5, 4, 3, 2]
~~~

### Reversing an Array

*Things to Note with this exercise*

1. The length of `array` is constantly changing so fix it with `var array_length = array.length`
2. `pop()` must have the brackets to work properly
3. I'd like to refactor, perhaps not need `temp_array` but don't really know a solution from the top of my head...

~~~
function reverseArray(array) {
  var reversed_array = [];
  for (var i = array.length - 1; i >= 0; i -= 1)
    reversed_array.push(array[i]);
  return reversed_array;
}

function reverseArrayInPlace(array) {
  var temp_array = []
  var array_length = array.length
  for (var i = 0; i < array_length; i += 1) {
    temp_array.push(array.pop());
  }
  for (var i = 0; i < array_length; i += 1) {
    array.unshift(temp_array.pop());
  }
  return array;
}

var new_array = reverseArray(["A", "B", "C"]);
reverseArray(new_array);
console.log(new_array);
// → ["C", "B", "A"];

var arrayValue = [1, 2, 3, 4, 5];
 reverseArrayInPlace(arrayValue);
 console.log(arrayValue);
// → [5, 4, 3, 2, 1]
~~~

### A List

*Things to Note with this exercise*

1. the nesting thing is kind of tripping me out.
2. that `for` loop is a life freaking saver!  It basically does all the work.

~~~
function arrayToList(array) {
  var flipped_array = array.reverse();
  var list = {};
  for (var i = 0; i < array.length; i += 1) {
    var item = {}
    if (i == 0) {
      item.value = flipped_array[i];
      item.rest  = null;
    } else {
      item.value = flipped_array[i];
      item.rest  = list;
    }
    list = item;
  }
  return list;
};

function listToArray(list) {
  var array = [];
  for (var node = list; node; node = node.rest) {
    array.push(node.value);
  }
  return array
};

function prepend(value, list) {
  return { value: value, rest: list }
}

function nth(list, number) {
  var i = 0;
  for (var node = list; node; node = node.rest) {
    if (number == i)
      return node.value;
    i += 1;
  }
  return undefined;
}

~~~

### Deep Comparison

*Things to Note with this exercise*

1. Recursion is the key here
2. Comparison of objects is really funky

~~~
function deepEqual(one, two) {
  for (var name in one) {
    if ((typeof(one[name]) == "object") && (one[name] != null)) {
      if (!(deepEqual(one[name], two[name])))
        return false;
    } else {
      if (one[name] != two[name]) {
        return false;
      }
    }
  }
  return true
}
~~~
