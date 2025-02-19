#!/usr/bin/env ruby

# Fibonacci sequence untill the given term 

# set the variable to an array with the first 2 values of the sequence
fib = [0,1]
# set the test term
n = 10
# set the initial starting point to the third value(second term) in the sequence
init = 2

# loop tesing if the initial starting point is still less than the test term 
while init < n+1 do 
    # push the sum of the last 2 values to set the next value
    fib << fib[init-1] + fib[init-2]
    # reset the initial starting point to 1 value higher
    init += 1 
end

puts "to term n: #{fib.join(" ")}"
puts "n term: #{fib.last}"
