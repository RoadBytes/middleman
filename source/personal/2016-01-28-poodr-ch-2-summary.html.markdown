---
title: POODR Ch 2 Summary
date: 2016-01-28 23:18 UTC
tags: summary, poodr, ch 2
---

Ch 2 Summary "Designing Classes with a Single Responsibility

## Intro
* Keep Class Structure simple
  * do something Right Now (this easy), but Change Later (this is hard)

## Deciding what belongs in a class
* Organization is difficult, where do you put things?

* Grouping Methods into Classes
  * classes affect future implementations and understanding of project
  * you will never know less than you know right now, so *preserve changability*

* Organizing Code to Allow for Easy Changes
  * easy means:
    * Changes have not unexpected side effects
    * small changes only require small changes of code
    * reusability
    * easiest way to make changes is to add code
  * **TRUE** accronym
    * *Transparent* make that sucka obvious
    * *Reasonable* cost of change proportional to cost of implementation
    * *Usable* current code should be usable in new and unexpected contexts
    * *Examplary* so nice people would want to keep it that way

## Creating classes that have single responsibility

* example involving bicycles: gears change ratios of pedal rotations and wheel rotations
  * `ratio = chainring / cog.to_f`

* The following is implemented 

~~~

class Gear 
  attr_reader :chainring, :cog 
  def initialize( chainring, cog) 
    @chainring = chainring 
    @cog = cog 
  end 
  
  def ratio 
    chainring / cog.to_f 
  end 
end 

puts Gear.new( 52, 11).ratio # -> 4.72727272727273 
puts Gear.new( 30, 27).ratio # -> 1.11111111111111
~~~

* You're required to add `gear inches` to account for different wheel sizes

~~~

class Gear 
  attr_reader :chainring, :cog, :rim, :tire
  def initialize( chainring, cog, rim, tire) 
    @chainring = chainring 
    @cog       = cog 
    @rim       = rim
    @tire      = tire
  end 
  
  def ratio 
    chainring / cog.to_f 
  end 

  def gear_inches
    ratio * (rim + 2 * tire)
  end
end

puts Gear.new( 52, 11, 26, 1.5). gear_inches 
# -> 137.090909090909 22 23 
puts Gear.new( 52, 11, 24, 1.25). gear_inches 
# -> 125.272727272727
~~~

  * for current context code is fine, but past implementations would break bc more arguments are required
  * `Gear.new( 52, 11).gear_inches` creates an error!
  * *Is this the best way to orgainze code?!?!?!?!*
  * how would we find out?

* Why single responsibility matters
  * code that's easy to change are like a box of building blocks
  * don't couple behavior to free up entanglement
  * don't copy paste, makes change hard

* Determining if a class has single responsibility
  * Literally personify the thing and ask it questions
    * see what makes sense for that 'thing' (gear in this example) to answer
    * what's your wheel size, not necessarily sensible
  * describe it in one sentence
    * "and", there's more than one responsibility
    * "or", there's more than one and they are different
  * *Cohesion* the concept that a Single class does things that are **Highly Related**
    * apply to `Gear` class example
      * tire may need to be separated
* Determining when to make design decisions
  * Put off design until necessary
  * make intentions clear

## Writing Code that Embraces Change

* Depend on Behavior, Not Data
  * Don't Repeat Yourself DRY
  * Hide instance variables
    * `@cog` can be accessed with `def cog; @cog; end;`
      * this is created with `attr_reader`
    * this allows `@cog` to be changed in ONE place!
    * control level of accessibility with `public` and `private`
  * Hide Data Structures
    * Example: initializing with an Array
      * this is too obscure and doesn't inform the user that the input is `:rim` and `:tire` data
      * `diameter` method "know" `@data`'s obscure structure


~~~

# @data = [[ 622, 20], [622, 23], [559, 30], [559, 40]]

def diameters
  # 0 is rim, 1 is tire
  data.collect do |cell|
    cell[0] + (cell[1] * 2)
  end
end
~~~

~~~

# @data = [[ 622, 20], [622, 23], [559, 30], [559, 40]]
# converted to
# @data = [#<struct Wheel rim = 622, tire = 20>, ... , #<struct Wheel rim = 559, tire = 40>]

def diameters
  wheels.collect do |wheel|
    wheel.rim + (wheel * 2)
  end

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect do |cell|
      Wheel.new(cell[0], cell[1])
    end
  end
end
~~~

* so, 

    * Example: to reveal intentions and structure, use Struct to make `rim` and `tire` available.
  * Enforce Single Responsibility Everywhere
    * Extract Extra Responsibilities from Methods


~~~

def diameters
  wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
end
~~~

instead:

~~~

def diameters
  wheels.collect { |wheel| diameter(wheel) }
end

def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end
~~~

  * now we have a `diameter(wheel)` method for reusability
  * can be used in `gear_inches`

  * this refactor didn't change behavior but it:
    * Exposed previously hidden qualities
    * Avoided the need for comments
    * encouraged reuse
    * was more portable
  * Isolate extra responsibilities
    * Wheel class converted from Struct to actual Class

~~~

class Gear
  Wheel = Struct.new(:rim, :tire) do 
    ...
  end
end
~~~

~~~

class Gear
  ...
end

class Wheel
end
~~~

  * each class has single responsibility

