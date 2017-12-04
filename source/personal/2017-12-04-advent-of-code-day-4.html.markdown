---
title: Advent of Code (Day 4)
date: 2017-12-04 05:18 UTC
tags: Advent of Code, Day 4
---

Hot Diggity, this one DIDN'T take 4 hours.  Merry Freaking Christmas!

[Check out out day 4 here.](https://adventofcode.com/2017/day/4)

For the first one you had lines of 'passwords', and you couldn't have repeat words.  You just had to count how many valid passwords there are.

The second one, you couldn't have any words as anagrams of each other.

I created a `letter_spectrum`, an array of the letters of each word sorted so
two anagram words would have the same `letter_spectrum`.

~~~ ruby

def no_repeats?(string)
  words_count = Hash.new(0)
  words = string.split(' ')

  words.each do |word|
    words_count[word] += 1
  end

  words_count.values.all? {|count| count == 1}
end

def letter_spectrum(word)
  word.split('').sort
end

def no_anagrams?(string)
  spectrum_count = Hash.new(0)
  words = string.split(' ')

  words.each do |word|
    spectrum = letter_spectrum(word)
    spectrum_count[spectrum] += 1
  end

  spectrum_count.values.all? {|count| count == 1}
end

passwords = File.read('passwords.txt').split("\n")

valid_passwords = passwords.select { |password| no_repeats?(password) }
unique_passwords = passwords.select { |password| no_anagrams?(password) }

puts "valid passwords #{valid_passwords.size}"
puts "unique passwords #{unique_passwords.size}"
~~~
