---
title: Advent of Code (Day 8)
date: 2017-12-08 08:31 UTC
tags: Advent of Code, Day 8
---

[Check out out day 8 here.](https://adventofcode.com/2017/day/7)

## Quick run down

This was a lot like the jumping challenge from [day
5](https://adventofcode.com/2017/day/5).  This time, you only had to go through
the register instruction list once and change its value if some condition
regarding another register was met.  Like the previous day, there was some data
to parse, but we'll see in a minute that it was easily handled by ruby's
specialness!

## Parsing the Input

Here is a sample of what typical input looked like.

~~~

b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
~~~

if we split each line on the `' '` (space), we can get each element set up like
so:

~~~ ruby

instruction = 'b inc 5 if a > 1'.split(' ')
  ['b', 'inc', '5', 'if', 'a', '>', '1']
~~~

### Breaking each part down

~~~

[  'b'      'inc'   '5'    'if'    'a'      '>'         '1' ]
[ reg_name  sign  value    if   other_reg comparison integer]
index:  0      1     2      3       4         5          6
~~~

This is the anatomy of each `instruction`.

The cool thing is, iterating through each instruction, we can name the elements
of each instruction in an array of instructions from the enumerator.  A little
confusing I know, so here is a code sample to show what I mean.

~~~ ruby

instructions.each do |reg_name, sign, value, _if, other_reg, comparison, integer|
  # ...
end
~~~

This would help bring some meaning to the enumerator when handling each
instruction.

## Challenge One

~~~ ruby

input = File.read('input.txt').split("\n")
instructions = input.map! { |instruction| instruction.split(' ') }

registers = Hash.new(0)
sign_map = { 'dec': -1, 'inc': + 1 }

def condition(registers, other_reg, comparison, integer)
  integer = integer.to_i

  case comparison
  when '>'
    registers[other_reg] > integer
  when '>='
    registers[other_reg] >= integer
  when '<'
    registers[other_reg] < integer
  when '<='
    registers[other_reg] <= integer
  when '=='
    registers[other_reg] == integer
  when '!='
    registers[other_reg] != integer
  end
end


instructions.each do |reg, sign, value, _if, other_reg, comparison, integer|
  registers[reg] += sign_map[sign.to_sym] * value.to_i if (condition(registers, other_reg, comparison, integer))
end

puts registers.values.max
~~~

## Challenge Two

Part two was pretty easy, you just needed to find the highest value of any
register at any point of the operation.  For this we can just set a global
`highest` initially as `0` and if any register, at any time were greater than the
`highest`, we just reassign this as the new `highest`.

### so for part two

~~~ ruby

highest = 0

instructions.each do |reg, sign, value, _if, other_reg, comparison, integer|
  registers[reg] += sign_map[sign.to_sym] * value.to_i if (condition(registers, other_reg, comparison, integer))
  highest = registers[reg] if registers[reg] > highest
end

puts highest
~~~

## The End

So, how did you solve this one?  Let me know!  Merry Christmas and/or your
specified holiday of choice.
