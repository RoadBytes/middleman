---
title: Practicing Single Responsibility
date: 2016-08-06 17:23 UTC
tags: practice, single responsibility, intermediate
---

Since I've been applying for jobs, I came across a ToyRobot challenge and it's helping me dig a bit deeper with OOP Design.  You can find details in the `README` of my [repo](https://github.com/RoadBytes/ToyRobot)

So other people can benefit from my experience, I thought I'd present a case where you can take my `Robot` class and extract out a `Table` class.

Here is a file and [link to the repo file](https://github.com/RoadBytes/ToyRobot/blob/before-seeing-solutions/app/robot.rb) if you wanted to implement it yourself.

~~~ ruby

# Robot object impelemented to specs
class Robot
  attr_accessor :x, :y, :direction

  DIRECTIONS    = [:SOUTH, :EAST, :NORTH, :WEST].freeze
  USER_COMMANDS = %w(place report move left right).freeze
  TABLE_SIZE    = 5
  # (0, 0) south west most corner of square table

  def place(x, y, direction)
    return self unless DIRECTIONS.include? direction
    return self unless coordinates_in_bounds(x, y)
    @x         = x
    @y         = y
    @direction = direction
    self
  end

  def report
    return self if robot_not_set
    puts "#{x}, #{y}, #{direction}"
    self
  end

  # rubocop:disable Metrics/PerceivedComplexity
  def move
    self.x += 1 if east? && not_on_east_edge?
    self.x -= 1 if west? && not_on_west_edge?
    self.y += 1 if north? && not_on_north_edge?
    self.y -= 1 if south? && not_on_south_edge?
    self
  end
  # rubocop:enable Metrics/PerceivedComplexity

  def left
    return self if robot_not_set
    index = DIRECTIONS.index(direction)
    new_index = (index + 1) % DIRECTIONS.size
    self.direction = DIRECTIONS[new_index]
    self
  end

  def right
    return self if robot_not_set
    index = DIRECTIONS.index(direction)
    new_index = index - 1
    self.direction = DIRECTIONS[new_index]
    self
  end

  private

  def coordinates_in_bounds(x, y)
    x < TABLE_SIZE && y < TABLE_SIZE &&
      x >= 0 && y >= 0
  end

  def robot_not_set
    x.nil? || y.nil? || direction.nil?
  end

  def north?
    direction == :NORTH
  end

  def south?
    direction == :SOUTH
  end

  def east?
    direction == :EAST
  end

  def west?
    direction == :WEST
  end

  def not_on_east_edge?
    x != TABLE_SIZE - 1
  end

  def not_on_west_edge?
    x != 0
  end

  def not_on_north_edge?
    y != TABLE_SIZE - 1
  end

  def not_on_south_edge?
    y != 0
  end
end
~~~

Try it out yourself, and I even have some tests set up.  After giving it a go, here is a link to my [answer to the challenge.](https://github.com/RoadBytes/ToyRobot/blob/after-seeing-solutions/app/robot.rb)  Spoiler Alert! Here are some things I think are interesting with the implementation below.

---

## Placing the Robot on the Table

### `Robot` would have a `Table` through it's initialization

* Through Sandi Metz, I learned dependency injection involved having
  instantiation of other objects on the boundary of the class... In our case,
  since there are no arguments for `Robot.new`, I just initialized a `Table` in
  the `Robot.initialize` method establishing a `Robot#table`.

~~~ ruby

class Robot
  attr_accessor :table

  def initialize
    @table = Table.new
  end
  ... (other stuff)
end
~~~


### I thought it was interesting trying to slice the class in two and determine what the `Table` would be responsible for.

* The easy part was placing the constant `TABLE_SIZE` in `Table`
* Finding if it was `#not_on_*direction*_egde` was probably part of the `Table` as well.
* This led to the `x` and `y` getter being a extracted out, but I still felt like it was deeply a part of `Robot`
* The compromise was:

~~~ ruby

class Robot
  ... (other stuff)

  def x
    table.x
  end

  def y
    table.y
  end
~~~

* I had `robot.x` just pass on the `x` message onto `table` and the setting of instance variables `@x` and `@y` was in `Table`

~~~ ruby

class Table
  ... (other stuff)

  def set(x, y)
    @x = x
    @y = y
  end
~~~

* I liked this idea of just passing on messages, so for `coordinates_in_bounds`, I had robot just pass on this message as well.
  * `Robot` has an instance method `Robot#coordinates_in_bounds`
  * `Table` had the logic

~~~ ruby

class Robot
  ... (other stuff)

  def coordinates_in_bounds(x, y)
    table.coordinates_in_bounds(x, y)
  end
end

class Table
  ... (other stuff)

  def coordinates_in_bounds(x, y)
    x < TABLE_SIZE && y < TABLE_SIZE &&
      x >= 0 && y >= 0
  end
end
~~~

### Next steps and How'd it go for you?

Anyway, I'll continue to chop up this class and try different techniques.  I
might seeing if a robot can not know about its direction.  If
you tried it yourself, leave a comment link to your repo.
