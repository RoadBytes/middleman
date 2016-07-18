---
title: POODR Ch 2 practice
date: 2015-08-27 23:57 UTC
tags: poodr, practice
---

Train of thought for POODR Ch 2

## friend wants a calculator for gears: 

* ratio = chainring / cog
* implement Gear.new(52, 11).ratio

<div class="question">Code from book
  <div class="answer">
    <pre>

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

Metz, Sandi (2012-09-05). Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series) (Kindle Locations 720-740). Pearson Education. Kindle Edition. 

    </pre>
  </div>
</div>


## friend wants to add gear_inches functionality:

* ratio * (rim + 2 * tire)
* Gear.new(52, 11, 26, 1.5).ratio
* Gear.new(52, 11, 26, 1.5).gear_inches

<div class="question">Code from book
  <div class="answer">
    <pre>

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

    </pre>
  </div>
</div>

## Gear.new(52, 11).ratio no longer works!

<div class="question">Code from book
  <div class="answer">
    <pre>

puts Gear.new(52, 11).ratio 
# ArgumentError: wrong number of arguments (2 for 4)
# 	from gear.rb:3:in `initialize'
# 	from (irb):3:in `new'
# 	from (irb):3

    </pre>
  </div>
</div>

* consider class implementation
* New object through Wheel Struct
* New object through Wheel class

<div class="question">Code from book
  <div class="answer">
    <pre>

class Gear 
  attr_reader :chainring, :cog, :wheel
  def initialize( chainring, cog, rim, tire) 
    @chainring = chainring 
    @cog       = cog 
    @wheel     = Wheel.new(rim, tire)
  end 
  
  def ratio 
    chainring / cog.to_f 
  end 

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do 
    def diameter
      rim + 2 * tire
    end
  end
end

    </pre>
  </div>
</div>

## Things to consider for changeable code

<div class="question">Info from book
  <div class="answer">
    <pre>

## Write code that embraces change

* hide variables, use getters and setter not direct `@variable`
  * here `cog` is the only place that knows what `@cog/cog` means
  * ie, multiplying cog by `adj_factor` only requires `def cog; @cog * adj_factor; end`
  * your data can be thought of as plain old objects

* separate complex data structures with the information itself.

    </pre>
  </div>
</div>

## Final implementation from Ch 2 of Gear with Wheel

<div class="question">Info from book
  <div class="answer">
    <pre>

class Gear 
  attr_reader :chainring, :cog, :wheel
  def initialize( chainring, cog, wheel=nil) 
    @chainring = chainring 
    @cog       = cog 
    @wheel     = wheel
  end 
  
  def ratio 
    chainring / cog.to_f 
  end 

  def gear_inches
    ratio * wheel.diameter
  end
end

class Wheel 
  attr_reader :rim, :tire
  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def diameter
    rim + 2 * tire
  end

  def circumference
    diameter * Math::PI
  end
end

    </pre>
  </div>
</div>

* resulting methods and features

<div class="question">Info from book
  <div class="answer">
    <pre>

> @wheel = Wheel.new(26, 1.5)
 => #<Wheel:0x007f8f343d8ec8 @rim=26, @tire=1.5> 
> @wheel.diameter
 => 29.0 
> @wheel.circumference
 => 91.106186954104 
> Gear.new(52, 11).ratio
 => 4.7272727272727275 
> Gear.new(52, 11, @wheel).ratio
 => 4.7272727272727275 
> Gear.new(52, 11, @wheel).gear_inches
 => 137.0909090909091 

    </pre>
  </div>
</div>

