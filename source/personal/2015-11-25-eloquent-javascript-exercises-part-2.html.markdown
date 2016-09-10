---
title: "Eloquent Javascript Exercises Part 2"
date: 2015-11-25 13:30 UTC
tags: notes, javascript, eloquent, solutions
---

These are my solutions to some of the exercises from *Eloquent Javascript*

[http://eloquentjavascript.net/04_data.html](http://eloquentjavascript.net/04_data.html)

## Exercises

### Flattening

*Things to Note with this exercise*

1. It's weird if there is an array inside an array inside an array

~~~
var arrays = [[1, 2, 3], [4, 5], [6]];
// Your code here.
var concat = function(arrayOne, arrayTwo) {
  for (var i = 0; i < arrayTwo.length; i += 1)
    arrayOne.push(arrayTwo[i]);
  return arrayOne;
}

console.log(arrays.reduce(concat));

// → [1, 2, 3, 4, 5, 6]
~~~

### Mother-child age difference

~~~
function average(array) {
  function plus(a, b) { return a + b; }
  return array.reduce(plus) / array.length;
}

var byName = {};
ancestry.forEach(function(person) {
  byName[person.name] = person;
});

// Your code here.
var age_differences = [];

ancestry.forEach(function(person) {
  if (byName[person.mother])
    age_differences.push(person.born - byName[person.mother].born);
});

console.log(average(age_differences));
// → 31.2
~~~

### Historical life expectancy

~~~
function average(array) {
  function plus(a, b) { return a + b; }
  return array.reduce(plus) / array.length;
}

// Your code here.
var centuryDeathHash = {};
ancestry.forEach(function(person) {
  var century = Math.ceil(person.died/100)
  if (centuryDeathHash[century]) {
    centuryDeathHash[century].push(person.died - person.born);
  } else {
    centuryDeathHash[century] = [person.died - person.born];      
  }
});

var results = {};
for (var key in centuryDeathHash) {
  results[key] = average(centuryDeathHash[key]);
}

console.log(results);
~~~

### Every And Then Some

*Things to Note with this exercise*

1. With `forEach` the `break;` command out of the loop doesn't work.  So freaking weird.

~~~
function every(array, predicate) {
  var result = true;
  array.forEach(function(element) {
    if(!predicate(element)) {
      result = false;
    };
  });
  return result;
};
  
function some(array, predicate) {
  var result = false;
  array.forEach(function(element) {
    if(predicate(element)) {
      result = true;
    };
  });
  return result;
};
~~~
