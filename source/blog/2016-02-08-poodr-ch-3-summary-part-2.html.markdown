---
title: POODR Ch 3 summary Part 2
date: 2016-02-08 14:42 UTC
tags: poodr, ch 3, managing dependencies, summary
---

continuing from...

### Remove Argument-Order Dependencies

* Isolate Multiparameter Initialization

~~~

module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog       = cog
      @wheel     = wheel
    end
  
    # ...
  end
end

# wrap module to protect from change
module GearWrapper
  # self can be a module too.  It's necessary to make it a 'class' method.  Otherwise it's an instance method
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end

# how it's called
GearWrapper.gear(
  args[:chainring],
  args[:cog],
  args[:wheel])
~~~

  * things to note:
    * module not class
    * `GearWrapper` makes new instances of `SomeFramework::Gear`  
    * this implementation shows you can send `gear` message while not having instances of `GearWrapper`
    * this is called **FACTORY** pattern where an objects main function is to create another object

## Managing Dependency Direction

* Reversing Dependencies
  * flipping `Wheel` to depend on `Gear`

~~~

class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog       = cog
  end

  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire, :gear
  def initialize(rim, tire, chainring, cog)
    @rim  = rim
    @tire = tire
    @gear = Gear.new(chainring, cog)
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
end

Wheel.new(26, 1.5, 52, 11).gear_inches
~~~

* Choosing Dependency Direction
  * depend on something that changes less likely than you do
    * concrete likely change more than abstract
    * changing class with lots of dependencies has lots of consequences
  * Understand likelihood of change
    * Ruby base changes less
    * Framework classes more likely change
  * Recognizing Concretions and abstractions
    * abstract less likely to change
    * avoid overly dependent classes
    * find dependencies that matter
    * depend on things that change less likely than you do.

**Depend on things that don't change!**
