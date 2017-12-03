---
title: Advent of Code (Day 2)
date: 2017-12-03 01:21 UTC
tags: Advent of Code, Day 2
---

It's Christmas time again, and I know this because [Advent of
Code](https://adventofcode.com/) is here :).  I've never participated in this
event until now and it's surprisingly a ton of fun.

### Why is it fun?

Why is it fun? Partly because of the story in the challenges, but mostly because
the challenges give me permission to throw caution to the wind and just hack the
shit out of some data to try and get past the leader board... in only a few
minutes. Everyone one of the top 100 finishers completed the challenge in less
than 5 mins.  It's taken me that long to read the damn spec (I'm a slow reader).
So, forget testing, and planning, and thinking.  When the new challenge comes
along, DO IT ASAP!

### Are there cheaters?

I looked into Reddit, and found that Advent participants go all in and skip to
the story to make it on the leader board.  They bank of their experience from
previous challenges to get an idea of what they have to do and just pump out the
answer and cross their fingers they did it correctly.  I'm sure there are a ton
of other ways to cheat as well.

#### A possible hack

You have to input a value to answer a challenge and if the website tells you if
your higher or lower, you can probably guess the answer in 5 guesses; no coding
required.  This of course totally defeats to purpose of learning to code well,
in exchange for the glory of the leader board. So, it's a mix between hacking to
get on the board and learning to code well.  I, of course, opt to do the
'virtuous thing' and work on coding well instead of hacking the system.  But,
maybe one day, I'll change my mind and throw coding practices out the window.

Until then, here is the code from Day 2, Advent of Code, 2017.

### My hacked aftermath

In the end, my code gets the answer, but not in a clear way.  Still, I think
it's a healthy mix of learning, having fun, and hacking.

~~~ ruby
rrr = [ [278,1689,250,1512,1792,1974,175,1639,235,1635,1690,1947,810,224,928,859],
[160,50,55,81,68,130,145,21,211,136,119,78,174,155,149,72],
[4284,185,4499,273,4750,4620,4779,4669,2333,231,416,1603,197,922,5149,2993],
[120,124,104,1015,1467,110,299,320,1516,137,1473,132,1229,1329,1430,392],
[257,234,3409,2914,2993,3291,368,284,259,3445,245,1400,3276,339,2207,233],
[1259,78,811,99,2295,1628,3264,2616,116,3069,2622,1696,1457,1532,268,82],
[868,619,139,522,168,872,176,160,1010,200,974,1008,1139,552,510,1083],
[1982,224,3003,234,212,1293,1453,3359,326,3627,3276,3347,1438,2910,248,2512],
[4964,527,5108,4742,4282,4561,4070,3540,196,228,3639,4848,152,1174,5005,202],
[1381,1480,116,435,980,1022,155,1452,1372,121,128,869,1043,826,1398,137],
[2067,2153,622,1479,2405,1134,2160,1057,819,99,106,1628,1538,108,112,1732],
[4535,2729,4960,241,4372,3960,248,267,230,5083,827,1843,3488,4762,2294,3932],
[3245,190,2249,2812,2620,2743,2209,465,139,2757,203,2832,2454,177,2799,2278],
[1308,797,498,791,1312,99,1402,1332,521,1354,1339,101,367,1333,111,92],
[149,4140,112,3748,148,815,4261,138,1422,2670,32,334,2029,4750,4472,2010],
[114,605,94,136,96,167,553,395,164,159,284,104,530,551,544,18]]

sorted = rrr.map {|row| row.sort }


# gg = rrr.map { |row| row.max - row.min }

# print gg.inject(:+)
# puts gg.inject(:+)

test = [5, 9, 2, 8]

def even_divide(row)
  row.each_with_index do |item, index|
    # divide into each other item
    row[(index + 1)..-1].each do |divisor|
      return divisor / item if (divisor % item == 0)
    end
  end
end

# puts even_divide(test)


ratios = sorted.map{|row| even_divide(row)}

print ratios.inject(:+)
~~~

### Learning from the experience

Now, I'm going to clean this up to see if I can make it more readable.

~~~
# It helped to learn Vim to get the input parsed to this data type

input_rows = [
  [278,1689,250,1512,1792,1974,175,1639,235,1635,1690,1947,810,224,928,859],
  [160,50,55,81,68,130,145,21,211,136,119,78,174,155,149,72],
  [4284,185,4499,273,4750,4620,4779,4669,2333,231,416,1603,197,922,5149,2993],
  [120,124,104,1015,1467,110,299,320,1516,137,1473,132,1229,1329,1430,392],
  [257,234,3409,2914,2993,3291,368,284,259,3445,245,1400,3276,339,2207,233],
  [1259,78,811,99,2295,1628,3264,2616,116,3069,2622,1696,1457,1532,268,82],
  [868,619,139,522,168,872,176,160,1010,200,974,1008,1139,552,510,1083],
  [1982,224,3003,234,212,1293,1453,3359,326,3627,3276,3347,1438,2910,248,2512],
  [4964,527,5108,4742,4282,4561,4070,3540,196,228,3639,4848,152,1174,5005,202],
  [1381,1480,116,435,980,1022,155,1452,1372,121,128,869,1043,826,1398,137],
  [2067,2153,622,1479,2405,1134,2160,1057,819,99,106,1628,1538,108,112,1732],
  [4535,2729,4960,241,4372,3960,248,267,230,5083,827,1843,3488,4762,2294,3932],
  [3245,190,2249,2812,2620,2743,2209,465,139,2757,203,2832,2454,177,2799,2278],
  [1308,797,498,791,1312,99,1402,1332,521,1354,1339,101,367,1333,111,92],
  [149,4140,112,3748,148,815,4261,138,1422,2670,32,334,2029,4750,4472,2010],
  [114,605,94,136,96,167,553,395,164,159,284,104,530,551,544,18]
]

# First Challenge

max_differences = input_rows.map { |row| row.max - row.min }
sum_check = max_differences.inject(:+)

puts sum_check

# Second Challenge

## Sort the rows to see what item divides the items in front of it in the array

sorted_rows = input_rows.map {|row| row.sort }

## The challenge stated that only two items in the row can be evenly divided

def check_sum_ratio(row)
  row.each_with_index do |item, index|
    # divide into each other item
    row[(index + 1)..-1].each do |divisor|
      return divisor / item if (divisor % item == 0)
    end
  end
end

check_sum_ratios = sorted_rows.map{|row| even_divide(row)}
sum_check = check_sum_ratios.inject(:+)

puts sum_check
~~~

So, that's my implementation and thoughts of Advent of Code.  How/What did you
do?

Love,

Jason
