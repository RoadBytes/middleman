---
title: POODR Ch 3 summary
date: 2016-01-31 10:57 UTC
tags: poodr, ch 3, managing dependencies, summary
---

POODR ch 3 Managing Dependencies

## Exercises

* I made some files with tests to see if you can refactor the initial `Gear` and `Wheel` implementations so that they follow the concepts from the chapter.
* Link to the repo is here: 
  * [https://github.com/RoadBytes/poodr/tree/master/Ch3practice](https://github.com/RoadBytes/poodr/tree/master/Ch3practice)

## Intro

* Behavior of object:
  * has behavior directly (ch 2)
  * inherits it from another class (ch 6)
  * knows another object that know the behavior (ch 3)

* Single Responsibility classes create need for several classes.
* they must then "know" about each other and knowing creates dependency

## Understanding Dependencies

~~~

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new( rim, tire). diameter
  end
  
  def ratio 
    chainring / cog.to_f 
  end 

  # ... 
end

class Wheel 
  attr_reader :rim, :tire 
  def initialize( rim, tire) 
    @rim = rim 
    @tire = tire 
  end 
  
  def diameter 
    rim + (tire * 2) 
  end 
  
  # ...
end
~~~

* Recognizing dependencies: List four ways Gear "knows" or depends on Wheel
  * Gear knows name of Wheel
  * Gear knows of method "diameter"
  * Gear know Wheel has two arguments
  * Gear know the order of these arguments

  * These dependencies MUST be managed and can be minimized further!  Ge'yah!

* Coupling Between Objects (CBO)
  * These dependencies couple Gear and Wheel. Changing one requires a change in the other.

* Other Dependencies
  * Law of Demeter: one object know another object that knows another object
  * Test coupling dependencies

## Write Loosely Coupled Code

### Inject Dependencies

* `gear_inches` know about `Wheel`

~~~

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end
end
~~~

* if Wheel's name changes, so must `gear_inches`
* `gear_inches` cannot be used for `Disk` or `Cylinder`
* `gear_inches` shouldn't care about `Wheel`, only `diamter`

* this can be decoupled through *dependency injection*

~~~

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, :wheel)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end
end
~~~

* issues above are now addressed
  * Wheel can be called anything
  * `Disk` or `Cylinder` may be used
  * any class that has `diameter` can be used

* Isolate Dependencies

  * what if you can't break dependencies due to limitations of code access
    * isolate does babies
  * This helps dependencies stay visible in the code base

  * Isolate Instance creation
    * Add instance to `def initialze`

~~~

def initialize(chainring, cog, rim, tire)
  @chainring = chainring
  @cog       = cog
  @wheel     = Wheel.new(rim, tire)
end
~~~

* isolate in it's own lazy `wheel` method

~~~

def initialize(chainring, cog, rim, tire)
  @chainring = chainring
  @cog       = cog
  @rim       = rim
  @tire      = tire
end

def wheel
  @wheel || Wheel.new(rim, tire)
end
~~~

* this is still an issue: `Gear` can only work with `Wheel`, but it highlights this problem and isolates it from the rest of the code

* Isolate Vulnerable External Messages
  * problem: it's not clear that the `wheel.diameter` method not from `Gear`
  * we can isolate `wheel.diameter` by creating a `diameter` method for `Gear` 
    * `def diameter; wheel.diamter; end`
  * `Gear` can now send `diameter` message to `self` and get the result it's looking for.
  * it may be a good idea to wrap external methods to isolate dependencies

### Remove Argument-Order Dependencies

* Use hashes for initialization arguments

~~~

def initialize(args)
  @chainring = args[:chainring]
  @cog       = args[:cog]
  @wheel     = args[:wheel]
end

...

Gear.new(
  chainring: 52,
  cog:       11,
  wheel:     Wheel.new(26, 1.5)
).gear_inches
~~~

  * order is now independent
  * changes add verbosity which may help with clarity even though a dependency is added
  * decide for yourself if this refactor is necessary
    * only two parameters for personal code may do well to keep dependency
    * several input with distributed code may benefit from Hash args

* Explicitly Define Defaults
    
~~~

def initialize(args)
  @chainring = args[:chainring] || 40
  @cog       = args[:cog]       || 18
  @wheel     = args[:wheel]
end

# may be an issue if there are boolean args
# will never set args[:bool] with false of nil values if, @bool = args[:bool] || true
~~~

~~~

# use fetch if args have false or nil values

def initialize(args)
  @chainring = args.fetch(:chainring, 40)
  @cog       = args.fetch(:cog, 18)
  @wheel     = args[:wheel]
end
~~~

~~~

# specifying defaults by merging a defaults hash 

def initialize( args)
  args = defaults.merge( args) 

  # merge will add default key and value pairs of `args` is missing key
  @chainring = args[:chainring] 
  @cog       = args[:cog]
  @wheel     = args[:wheel]
end 

def defaults  
  { chainring: 40, cog: 18 }
end
~~~

  * Isolate multiparameter Initialization

