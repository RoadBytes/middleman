---
title: Advent of Code (Day 7)
date: 2017-12-07 09:10 UTC
tags: Advent of Code, Day 7
---

[Check out out day 7 here.](https://adventofcode.com/2017/day/7)

This was an interesting challenge that had a `tower` (aka tree) of `programs`
(aka nodes) structure.  Each program had a `name`, `weight`, and pointed to
other programs.

## From the description:

Your input has the `name` `(weight)` and `references` (if present) in a text
file like this:

~~~

pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)
~~~

The tower ultimately looks like something like this.

~~~

                gyxo
              /
         ugml - ebii
       /      \
      |         jptl
      |
      |         pbga
     /        /
tknk --- padx - havc
     \        \
      |         qoyq
      |
      |         ktlj
       \      /
         fwft - cntj
              \
                xhth
~~~

## Challenge One

You had to find the root program, ie, the only program that isn't referenced by
another program.

Half the work was parsing through the input to get to the data, but the other
step that was difficult was thinking about how to handle the modeling and
referencing.

### Thinking of the `program` model

Here is a nice version of what I came up with at the time; the real version
looked like crap and I was racing through the challenge like a dummy... I loved
it.

~~~ ruby

class Program
  def initialize(name, weight, references)
    # ...
  end
end
~~~

if we just initialized each program, we can collect all the references and then
just select the one program that isn't one of the references.  In my `Program`,
the `@references` variable was just an array of strings of the names of the
other programs being referenced.

~~~ ruby

referenced_programs = Program.all.map {|prog| prog.reference}.flatten
root = Program.all.select {|prog| !referenced_programs.include? prog.name}.first

puts root.name
~~~

### Parsing the data

~~~

ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
~~~

Given the input liked like this, I iterated through each line and chopped the
hell out of the strings.

~~~ ruby

input = File.read('input.txt').split("\n")
input.map! { |program| program.split(' -> ') }

initial_programs = []

input.each do |(name_weight, references)|
  references = []
  references = references.split(', ') if references
  name, weight = name_weight.split(' ')
  weight = weight[1..-2].to_i
  programs << [name, weight, references}
end
~~~

Then I just took the `initial_programs` array and initialized a bunch of
`programs`

~~~ ruby

class Program
  attr_accessor :name, :weight, :references

  def initialize(name, weight, references)
    @name = name
    @weight = weight
    @references = references
  end

  # other stuff here ...
end

initial_programs.map! do |(name, weight, references)|
  Programm.new(name, weight, references)
end
~~~

With all our programs initialized, it was a piece of cake.

## Challenge Two

For this one, there were programs that were imballenced, meaning that
`references` that didn't all have the same total weight (self.weight, and weight
of all the references up to that point in the tower).  Here is where
understanding the tree structure helped.  I just needed a way to get find a
program from it's name. `Program.find(name) # => program`, and a bit of
recursion.

~~~ ruby

def tree_weight
  if references.size == 0
    @tree_weight = self.weight
  else
    tree_weights = references.map do |name|
      Programm.find(name).tree_weight
    end

    @tree_weight = tree_weights.inject(:+) + self.weight
  end
end
~~~

Anyway, my blog writing time is up so I'm going to bed.  Happy holidays!  Get me
on twitter if you had any ?'s. `@Jason_Data`
