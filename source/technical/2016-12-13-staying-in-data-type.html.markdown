---
title: Staying in Data Type
date: 2016-12-13 05:28 UTC
tags: code review
---

# First Take

def rotate_rightmost_digits(integer, n)
  stringified = integer.to_s
  index       = (stringified.size - 1) - n

  front, back = split_at(index, stringified)
  stringified = front + rotate_string(back)
  stringified.to_i
end

def rotate_array(array)
  copy = array.clone

  first_item = copy.shift
  copy.push first_item
  copy
end

def split_at(index, string)
  if index == -1
    front = ''
    back  = string
  else
    front, back = string[0..index], string[index + 1..-1]
  end

  [front, back]
end

def rotate_string(string)
  rotated = rotate_array string.chars
  rotated.join
end

## Wow, that was so freaking long, I'm thinking it's becuase I kept getting
## mixed up between a string and an array... I should have stuck to one type

# Second Take

def rotate_rightmost_digits(integer, n)
  all_digits = integer.to_s.chars
  all_digits[-n..-1] = rotate_array all_digits[-n..-1]
  all_digits.join.to_i
end

def rotate_array(array)
  copy = array.clone

  first_item = copy.shift
  copy.push first_item
  copy
end

# Review

Man, switching between types becomes a big headache.  It's much easier to
convert the data into the appropriate type first, then, do the manipulations all
in that type, and just convert back at the end.
