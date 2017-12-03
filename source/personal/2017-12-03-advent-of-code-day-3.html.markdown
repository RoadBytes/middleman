---
title: Advent of Code (Day 3)
date: 2017-12-03
tags: Advent of Code, Day 3
---

I worked on [Advent of Code Day 3](https://adventofcode.com/2017/day/3) and it
took so much longer compared to the other challenges.  I probably wouldn't have
even tried to finish if it wasn't for my friend Branko who challenged me.  Dude,
kicked my butt... I'll get him next time.

# First Challenge

I'm assuming you're familiar with the challenge so I won't go into detail of the
specs here.  Generally, imagine you are on an infinite checker board (grid) and
you are standing on a square.  You proceed to walk around your starting
square in a spiral fashion and measure your Manhattan distance from your current
position to the starting point in each move.  The challenge required you to
return this measurement at some large value.

I found a pattern in how many steps it took to get from a squared number of
steps to the starting point.

| number of steps | side path length | total distance to start |
| --- | --- | --- |
| 4  | 2 | (-1)**(2) * x       |
|    |   | (-1)**(2) * y * (1)   |
|    |   | (-1)**(2 - 1) * x  (1)  |
|    |   |                 |
| 9  | 3 | (-1)**(3) * x     |
|    |   | (-1)**(3) * y * (2) |
|    |   | (-1)**(3 - 1) * x (2) |
|    |   |               |
| 16 | 4 | (-1)**(4) * x     |
|    |   | (-1)**(4) * y * (3) |
|    |   | (-1)**(4 - 1) * x (3) |
|    |   |               |
| (n + 1)**2 | n |  (-1)**(n) * x     |
|            |   |  (-1)**(n) * y * (n - 1) |
|            |   |  (-1)**(n - 1) * x * (n - 1)  |

Sum to square 1 at square n can be calculated through finding the distance at
the nearest square number of steps and counting up the remaining steps from this
point.

~~~ ruby

require 'matrix'

x   = Vector[1, 0]
y   = Vector[0, 1]

sum = Vector[0, 0]

(2..601).each do |n|
  sum += (-1)**(n) * x
  sum += (-1)**(n) * y * n
  sum += (-1)**(n - 1) * x * n
end

puts sum
~~~

## My value was 361527

~~~

361527 is 601**2 + 326 more steps

sum at n == 601 is Vector[300, -300]

326 more steps

(-1)**(602) * x          # one step
(-1)**(602) * y * (325)  # 325 steps

Vector[300 + 1, -300 + 325]

[301, 25] and Mahattan distance would be 301 + 25 = 326

326 total steps to square 1
~~~

# Second Challenge

For this challenge, there were values on each square that were the sum of the
surrounding squares' values. This part had me really look into the specs and try to
understand what was happening.  The pattern I found above didn't make sense so I
gave it another looksee and found the following pattern.

| step | change in distance |
| --- | --- |
| 1  | +x step right |
| 2  | +y step up |
| 3  | -x step back |
| 4  | -x step back |
| 5  | -y step down |
| 6  | -y step down |
| 7  | +x right |
| 8  | +x right |
| 9  | +x right |
| 10 | +y up |
| 11 | +y up |
| 12 | +y up |

In each layer of steps around the grid, the length of a side increased by 1 and
there would be an equal number of x's and y's. Also the sign would flip from
positive to negative as you walked up the right and up, to the back and down.

I imagined each step being a movement in the x or y direction.  I would populate
an array `@@grid_steps` for each layer and `shift` a step off each move to
'walk' through the grid.  When the array was empty, the number of x's and y's
would both increase by 1, flip sign, and I continue to shift off a step for each
move through the grid.

Also, I used a hash to store the values for each place on the grid.  I'm not
sure if `Vector`'s make good keys so I just used an array of the `Vextor`'s x
and y position.

~~~
require 'matrix'

class Grid
  @@grid_width = 0
  @@current_place = Vector[0, 0]

  @@grid_values = Hash.new(0)
  @@grid_values[[0, 0]] = 1

  @@grid_steps = []

  def self.set_current_value
    @@current_place += next_step
    value = get_grid_values_around(@@current_place) # I didn't need an arg but don't care to refactor atm
    @@grid_values[ [@@current_place[0], @@current_place[1]] ] = value
  end

  def self.next_step
    if @@grid_steps.size == 0
      @@grid_width += 1
      set_grid_steps_at_width
      @@grid_steps.shift
    else
      @@grid_steps.shift
    end
  end

  def self.set_grid_steps_at_width
    x = Vector[1, 0]
    y = Vector[0, 1]

    x_step = (-1)**(@@grid_width + 1) * x
    y_step = (-1)**(@@grid_width + 1) * y

    @@grid_width.times { @@grid_steps << x_step }
    @@grid_width.times { @@grid_steps << y_step }
  end

  def self.get_grid_values_around(current_step)
    x = current_step[0]
    y = current_step[1]

    @@grid_values[[x + 1, y + 1]] +
    @@grid_values[[x + 1, y]] +
    @@grid_values[[x + 1, y - 1]] +
    @@grid_values[[x, y + 1]] +
    @@grid_values[[x, y - 1]] +
    @@grid_values[[x - 1, y + 1]] +
    @@grid_values[[x - 1, y]] +
    @@grid_values[[x - 1, y - 1]]
  end
end

n = 0

while (n < 361527)
  n = Grid.set_current_value
end

puts n
~~~

Anyway, if the next challenges get much harder, I'm not sure I'll have enough
time to complete them.  I'd be happy to just give it a shot.  If I do, you'll
see my solution right on this blog.
