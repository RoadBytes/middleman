---
title: "OOP and a Rock, Paper, Scissors Game"
date: 2016-07-30 22:31 UTC
tags: oop, practice
---

# Rock, Paper, Scissors Game to learn OOP

I made an object oriented Rock, Paper, Scissors game to practice working with Design and TDD.  If you're not familiar with Rock, Paper, Scissors:

  * Two players randomly picks: Rock, Paper, or Scissors
  * The winner follows the logic
    * Rock smashes Scissors,
    * Scissors cut Paper,
    * Paper covers Rock.

Anyway, it's a great way to learn and practice developing an application.  (So is anything where you develop an application, but who's counting)

If you wanted to make a RPS application, you should go on ahead.  I just had the application run in the terminal, and you can check it out here in my [Github](https://github.com/RoadBytes/RPS):

* https://github.com/RoadBytes/RPS

---

# Here are some of my notes on OOP if you wanted more help.  It's inspired/copied from LaunchSchool's OOP course.

---

# Notes on OOP

1. Write a textual description of the problem or exercise.
2. Extract the major nouns and verbs from the description.
3. Organize and associate the verbs with the nouns.
4. The nouns are the classes and the verbs are the behaviors or methods.

# Finding a Description

We don't think about the flow at all.
First write out a textual description of RPS

~~~

RPS is a two player game where each player chooses Rock, Paper, or Scissors.

- rock > scissors
- scissors > paper
- paper > rock

same move is a tie
~~~

# Here is a potential extraction

~~~

Nouns: player, move, rules
Verbs: choose, compare
~~~

Organizing Nouns and verbs

~~~

Player
  - choose
Move
Rule

- compare
~~~

# Making an engine

~~~

class RPSGame
  def initialize
  end

  def play
  end
end
~~~

# focusing on the `play` method

~~~

def play
  display_welcome_message
  get_human_move
  get_computer_move
  display_winner
  display_goodbye_message
end
~~~

if the human and computer were players, they would have `#choose`

# After implementing the App

I liked working on a OOP method of Rock Paper Scissors and I tried to organize my application like a Rails App.  I also installed Rspec to handle testing to add the bonus features.

# Bonus features

I'm making branches to be able to access the app as I change it in various states.  See the log to show all branches

https://github.com/RoadBytes/RPS

* Lizard, Spock
* Separate Paper, Rock, and Scissors classes
* History of moves

# Lizard, Spock

- I just added these values to the `Move` class.  I also just created a class constant `VALID_VALUES` to help dry up the code.
- In the `Computer` class, I had a method that instantiated a `move` variable by referencing the `Moves::VALID_VALUES` class constant, and I ended up changing this "constant", but I just added a `.clone` method and so a new array object was created all together.
- It was relatively easy, but there was some dependency I needed to change with Player choose.  Players can now choose 'lizard', and 'spock' so I piped in the `Move::VALID_VALUES` here too to hopefully dry up future choices.

# Separate Paper, Rock, Scissors classes

- This was really interesting bc the `Move#compare` method was much easier to implement
  * for example, in the `Paper` class

~~~

def compare(other_move)
  return 'tie' if other_move.class == self.class
  other_move.class.to_s == "Rock" ? "win" : "lose"
end
~~~

- I also liked how to instantiate new moves dynamically with `Kernel.const_get(class.name).new`

# Separate Paper, Rock, Scissors classes

## Pros

- Again, the `#compare` method was easier to implement
- It actually wasn't that hard to insert it into the current code
  - we just needed to have a `compare` method
  - this was due to `Player`'s dependency injection
  - `Player.move = Move.new`

## Cons

- Not much, I guess having more files can get confusing
- I had to do some sleuthing to find `Kernel.const_get`
  - this helped with the dynamic instantiation of 'Move' objects

# History of moves

###### As long as the user doesn't quit, keep track of a history of moves by both the human and computer. What data structure will you reach for? Will you use a new class, or an existing class? What will the display output look like?

- Seems easier to just add it as an attribute of the `Player` class
- It can be an array where moves are just pushed onto it.
- I'm thinking I won't display this info so nothing would change here...
- But if I wanted to add move display
  - it'd just be a list of moves with a table
  - Player on top header and each row would represent each game
  - if this is the case, then we can have another MoveLedger class maybe?

# Adjust computer choice based on history

###### Come up with some rules based on the history of moves in order for the computer to make a future move. For example, if the human tends to win over 60% of his hands when the computer chooses "rock", then decrease the likelihood of choosing "rock". You'll have to first come up with a rule (like the one in the previous sentence), then implement some analysis on history to see if the history matches that rule, then adjust the weight of each choice, and finally have the computer consider the weight of each choice when making the move. Right now, the computer has a 33% chance to make any of the 3 moves.

# Rule

When ever the computer loses, it just adds the non losing moves into an array. This array will then have more of a likelihood of returning the non losing moves when `.sample` is run on it.
